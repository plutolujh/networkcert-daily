/**
 * Cloudflare Worker with D1 Database
 * API Router for 网络规划师备考 - 每日练习系统
 */

// Cron 定时触发：调用 Claude API 生成扩展资料
export async function scheduled(event, env, ctx) {
  const today = new Date().toISOString().split('T')[0];
  const db = env.DB;

  // 获取过去24小时内的答题和笔记数据
  const { results: history } = await db.prepare(`
    SELECT h.*, q.content as question_text, q.tags, q.answer, q.explanation
    FROM question_history h
    JOIN questions q ON h.question_id = q.id
    WHERE h.answered_at >= datetime('now', '-1 day')
    ORDER BY h.answered_at DESC
  `).all();

  const { results: notes } = await db.prepare(`
    SELECT n.*, q.content as question_text, q.tags, q.explanation
    FROM question_notes n
    JOIN questions q ON n.question_id = q.id
    WHERE n.created_at >= datetime('now', '-1 day')
    ORDER BY n.created_at DESC
  `).all();

  const wrongQuestions = history.filter(h => !h.is_correct);
  const needExtNotes = notes.filter(n => n.note_type === 'confused' || n.note_type === 'need_extended');

  // 组合分析数据
  const analysisData = {
    date: today,
    wrongCount: wrongQuestions.length,
    wrongQuestions: wrongQuestions.map(w => ({
      knowledgePoint: w.tags,
      question: w.question_text?.substring(0, 200),
      userAnswer: w.user_answer,
      correctAnswer: w.answer,
      explanation: w.explanation
    })),
    notesCount: needExtNotes.length,
    notes: needExtNotes.map(n => ({
      knowledgePoint: n.tags,
      noteType: n.note_type,
      content: n.note_content
    }))
  };

  // 调用 Claude API 生成扩展资料
  const prompt = `你是网络规划设计师备考助手。请根据用户过去24小时的学习数据，生成个性化扩展资料。

## 学习数据
${JSON.stringify(analysisData, null, 2)}

## 输出要求
请生成一份扩展学习资料，JSON格式：
{
  "summary": "今日学习总结（50字内）",
  "weaknesses": ["需要补强的知识点1", "需要补强的知识点2"],
  "items": [
    {
      "knowledgePoint": "知识点名称",
      "coreExplanation": "核心原理解释（100字内）",
      "memoryTips": ["记忆口诀/技巧1", "记忆口诀/技巧2"],
      "commonMistakes": ["常见误区1", "常见误区2"],
      "practiceSuggestion": "练习建议（50字内）"
    }
  ],
  "tomorrowFocus": "明日学习重点（30字内）"
}`;

  try {
    const claudeRes = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': env.CLAUDE_API_KEY,
        'anthropic-version': '2023-06-01',
        'anthropic-dangerous-direct-browser-access': 'true'
      },
      body: JSON.stringify({
        model: 'claude-haiku-4-20250501',
        max_tokens: 2000,
        messages: [{ role: 'user', content: prompt }]
      })
    });

    const claudeData = await claudeRes.json();
    let extensionContent;

    if (claudeData.content) {
      const text = claudeData.content[0]?.text || '';
      // 尝试解析 JSON
      const jsonMatch = text.match(/\{[\s\S]*\}/);
      extensionContent = jsonMatch ? JSON.parse(jsonMatch[0]) : { summary: text };
    } else {
      extensionContent = { summary: '数据解析中...' };
    }

    // 保存到数据库
    await db.prepare(`
      INSERT OR REPLACE INTO daily_extensions (date, content, source_notes)
      VALUES (?, ?, ?)
    `).bind(today, JSON.stringify(extensionContent), JSON.stringify({
      historyCount: history.length,
      notesCount: notes.length
    })).run();

    console.log(`[${today}] 扩展资料生成成功`);
  } catch (err) {
    console.error('生成扩展资料失败:', err);
  }
}

// 知识点速记表
const knowledgeCards = {
  'TCP三次握手': {
    principle: '三次握手建立TCP连接',
    steps: ['客户端发送SYN=x', '服务器返回SYN+ACK=y, ack=x+1', '客户端发送ACK=x+1, ack=y+1'],
    state: 'CLOSED→SYN_SENT→ESTABLISHED (客户端)',
    mnemonic: '主动方先SYN，被动方SYN+ACK，然后ACK确认'
  },
  'VLAN': {
    principle: '隔离广播域，划分逻辑网络',
    types: '基于端口(最常用)、基于MAC、基于协议、基于IP子网',
    trunk: '802.1Q打标签，4字节',
    mnemonic: 'VLAN隔离广播，Trunk承载多VLAN'
  },
  'STP': {
    principle: '生成树协议，消除环路',
    states: 'Blocking→Listening→Learning→Forwarding',
    roles: '根桥、根端口、指定端口、非指定端口',
    mnemonic: '先选根桥，再定端口角色'
  }
};

// 获取随机题目
async function getRandomQuestion(db, category) {
  let query = 'SELECT * FROM questions';
  let bindings = [];
  if (category) {
    query += ' WHERE category LIKE ?';
    bindings.push(`%${category}%`);
  }
  query += ' ORDER BY RANDOM() LIMIT 1';
  const result = await db.prepare(query).bind(...bindings).first();
  return result;
}

// 获取每日一题
async function getDailyQuestion(db, date) {
  // 按日期hash选择题目，确保每天同一日期得到相同题目
  const hash = date.split('-').join('');
  const num = parseInt(hash) % 757; // 757是题库总数
  const result = await db.prepare('SELECT * FROM questions LIMIT 1 OFFSET ?').bind(num).first();
  return result;
}

// 评判答案
function checkAnswer(question, userAnswer) {
  const correct = question.answer.toString().split(',');
  const user = userAnswer.toString().split(',');

  if (correct.length !== user.length) return false;

  const correctSet = new Set(correct.map(x => x.trim()));
  const userSet = new Set(user.map(x => x.trim()));

  if (correctSet.size !== userSet.size) return false;

  for (const c of correctSet) {
    if (!userSet.has(c)) return false;
  }
  return true;
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    const path = url.pathname;

    // CORS headers
    const corsHeaders = {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type',
    };

    if (request.method === 'OPTIONS') {
      return new Response(null, { headers: corsHeaders });
    }

    const db = env.DB;

    try {
      // 健康检查
      if (path === '/api/health') {
        return new Response(JSON.stringify({ status: 'ok' }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // ===== 题库API =====

      // 获取知识点速记卡
      if (path === '/api/knowledge') {
        const tag = url.searchParams.get('tag') || 'TCP';
        const card = knowledgeCards[tag];
        if (card) {
          return new Response(JSON.stringify({ tag, ...card }), {
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          });
        }
        // 返回所有标签
        return new Response(JSON.stringify({ tags: Object.keys(knowledgeCards) }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // 获取随机一题
      if (path === '/api/question/random') {
        const category = url.searchParams.get('category');
        const question = await getRandomQuestion(db, category);
        if (!question) {
          return new Response(JSON.stringify({ error: '题库为空' }), {
            status: 404,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          });
        }
        // 不返回正确答案
        const { answer, ...safeQuestion } = question;
        return new Response(JSON.stringify(safeQuestion), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // 获取每日一题
      if (path === '/api/question/daily') {
        const date = url.searchParams.get('date') || new Date().toISOString().split('T')[0];
        const question = await getDailyQuestion(db, date);
        if (!question) {
          return new Response(JSON.stringify({ error: '题库为空' }), {
            status: 404,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          });
        }
        const { answer, ...safeQuestion } = question;
        return new Response(JSON.stringify(safeQuestion), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // 提交答案评判
      if (path === '/api/question/submit' && request.method === 'POST') {
        const body = await request.json();
        const { question_id, user_answer, is_correct } = body;

        // 获取题目答案和解析
        const question = await db.prepare('SELECT answer, explanation FROM questions WHERE id = ?').bind(question_id).first();

        // 记录答题历史
        await db.prepare(`
          INSERT INTO question_history (question_id, user_answer, is_correct, answered_at)
          VALUES (?, ?, ?, CURRENT_TIMESTAMP)
        `).bind(question_id, user_answer, is_correct ? 1 : 0).run();

        // 如果答错，记录到错题本
        if (!is_correct) {
          await db.prepare(`
            INSERT OR IGNORE INTO wrong_questions (question_id, count, last_reviewed)
            VALUES (?, 1, CURRENT_TIMESTAMP)
          `).bind(question_id).run();
        } else {
          // 答对了，从错题本移除
          await db.prepare('DELETE FROM wrong_questions WHERE question_id = ?').bind(question_id).run();
        }

        return new Response(JSON.stringify({
          status: 'recorded',
          answer: question?.answer,
          explanation: question?.explanation
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // 获取错题本
      if (path === '/api/wrong-questions') {
        const { results } = await db.prepare(`
          SELECT q.*, w.count, w.last_reviewed
          FROM wrong_questions w
          JOIN questions q ON w.question_id = q.id
          ORDER BY w.count DESC
        `).all();
        return new Response(JSON.stringify(results), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // ===== 案例分析API =====

      // 获取案例分析题目列表（按年份）
      if (path === '/api/case/questions' && request.method === 'GET') {
        const year = url.searchParams.get('year');
        let query = 'SELECT * FROM case_questions';
        let bindings = [];
        if (year) {
          query += ' WHERE year = ?';
          bindings.push(parseInt(year));
        }
        query += ' ORDER BY id';
        const { results } = await db.prepare(query).bind(...bindings).all();

        // 获取每个大题的子问题
        for (const q of results) {
          const subs = await db.prepare('SELECT * FROM case_sub_questions WHERE question_id = ? ORDER BY sub_num').bind(q.id).all();
          q.subQuestions = subs;
        }

        return new Response(JSON.stringify(results), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // 获取单个案例分析题目详情
      if (path.startsWith('/api/case/question/') && request.method === 'GET') {
        const questionId = path.split('/').pop();
        const question = await db.prepare('SELECT * FROM case_questions WHERE id = ?').bind(questionId).first();

        if (!question) {
          return new Response(JSON.stringify({ error: '题目不存在' }), {
            status: 404,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          });
        }

        const subs = await db.prepare('SELECT * FROM case_sub_questions WHERE question_id = ? ORDER BY sub_num').bind(questionId).all();
        question.subQuestions = subs;

        return new Response(JSON.stringify(question), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // 提交案例分析答案（带批改）
      if (path === '/api/case/submit' && request.method === 'POST') {
        const body = await request.json();
        const { question_id, sub_num, user_answer, grade_result } = body;

        await db.prepare(`
          INSERT OR REPLACE INTO case_user_answers (question_id, sub_num, user_answer, score, grading_result, updated_at)
          VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
        `).bind(question_id, sub_num, user_answer, grade_result?.score || null, JSON.stringify(grade_result || {})).run();

        return new Response(JSON.stringify({ status: 'saved' }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // 获取案例分析答题历史
      if (path === '/api/case/history') {
        const questionId = url.searchParams.get('question_id');
        if (questionId) {
          const result = await db.prepare('SELECT * FROM case_user_answers WHERE question_id = ? ORDER BY sub_num').bind(questionId).all();
          // 解析 grading_result JSON
          for (const r of result) {
            if (r.grading_result && typeof r.grading_result === 'string') {
              try {
                r.grading_result = JSON.parse(r.grading_result);
              } catch (e) {}
            }
          }
          return new Response(JSON.stringify(result), {
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          });
        }
        return new Response(JSON.stringify({ error: 'question_id required' }), {
          status: 400,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // 获取答题统计
      if (path === '/api/stats') {
        const total = await db.prepare('SELECT COUNT(*) as cnt FROM questions').first();
        const answered = await db.prepare('SELECT COUNT(DISTINCT question_id) as cnt FROM question_history').first();
        const correct = await db.prepare('SELECT COUNT(*) as cnt FROM question_history WHERE is_correct = 1').first();
        const wrongCount = await db.prepare('SELECT COUNT(*) as cnt FROM wrong_questions').first();

        return new Response(JSON.stringify({
          total: total?.cnt || 0,
          answered: answered?.cnt || 0,
          correct: correct?.cnt || 0,
          wrongCount: wrongCount?.cnt || 0,
          accuracy: answered?.cnt > 0 ? Math.round(correct?.cnt / answered?.cnt * 100) : 0
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // ===== 笔记API =====

      // 保存笔记
      if (path === '/api/note' && request.method === 'POST') {
        const body = await request.json();
        const { question_id, note_type, note_content } = body;

        if (!question_id || !note_type) {
          return new Response(JSON.stringify({ error: '缺少必要参数' }), {
            status: 400,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          });
        }

        // 检查题目是否存在
        const question = await db.prepare('SELECT id FROM questions WHERE id = ?').bind(question_id).first();
        if (!question) {
          return new Response(JSON.stringify({ error: '题目不存在' }), {
            status: 404,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          });
        }

        // 更新或插入笔记
        await db.prepare(`
          INSERT INTO question_notes (question_id, note_type, note_content, updated_at)
          VALUES (?, ?, ?, CURRENT_TIMESTAMP)
        `).bind(question_id, note_type, note_content || '').run();

        return new Response(JSON.stringify({ status: 'saved' }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // 获取题目的笔记
      if (path.startsWith('/api/note/') && request.method === 'GET') {
        const noteId = path.split('/')[3];
        if (!noteId) {
          return new Response(JSON.stringify({ error: '缺少笔记ID' }), {
            status: 400,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          });
        }

        const note = await db.prepare('SELECT * FROM question_notes WHERE id = ?').bind(noteId).first();
        if (!note) {
          return new Response(JSON.stringify({ error: '笔记不存在' }), {
            status: 404,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          });
        }

        return new Response(JSON.stringify(note), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // 获取题目的所有笔记
      if (path === '/api/notes' && request.method === 'GET') {
        const questionId = url.searchParams.get('question_id');
        let query = 'SELECT * FROM question_notes';
        let bindings = [];
        if (questionId) {
          query += ' WHERE question_id = ?';
          bindings.push(questionId);
        }
        query += ' ORDER BY created_at DESC';
        const { results } = await db.prepare(query).bind(...bindings).all();

        return new Response(JSON.stringify(results), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // 获取今日扩展资料
      if (path === '/api/extensions/today') {
        const today = new Date().toISOString().split('T')[0];
        const ext = await db.prepare('SELECT * FROM daily_extensions WHERE date = ?').bind(today).first();

        if (!ext) {
          return new Response(JSON.stringify({ error: '今日暂无扩展资料' }), {
            status: 404,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          });
        }

        return new Response(JSON.stringify(ext), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // 生成扩展资料
      if (path === '/api/extensions/generate' && request.method === 'POST') {
        const today = new Date().toISOString().split('T')[0];

        // 获取过去24小时内标记为需要扩展的笔记
        const { results: notes } = await db.prepare(`
          SELECT n.*, q.tags, q.content as question_content, q.explanation
          FROM question_notes n
          JOIN questions q ON n.question_id = q.id
          WHERE n.note_type IN ('confused', 'need_extended')
            AND n.created_at >= datetime('now', '-1 day')
          ORDER BY n.created_at DESC
        `).all();

        if (notes.length === 0) {
          return new Response(JSON.stringify({ error: '过去24小时没有需要扩展的笔记' }), {
            status: 404,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          });
        }

        // 按知识点分组生成扩展资料
        const knowledgeGroups = {};
        for (const note of notes) {
          const kp = note.tags || '其他';
          if (!knowledgeGroups[kp]) {
            knowledgeGroups[kp] = [];
          }
          knowledgeGroups[kp].push(note);
        }

        // 生成扩展资料内容
        const extensionContent = {
          generatedAt: new Date().toISOString(),
          sourceCount: notes.length,
          items: []
        };

        for (const [kp, kpNotes] of Object.entries(knowledgeGroups)) {
          const item = {
            knowledgePoint: kp,
            noteCount: kpNotes.length,
            corePoints: [],
            memoryTips: [],
            commonMistakes: [],
            relatedQuestions: [],
            fromKnowledgeBase: false
          };

          // 检查知识库是否已有该知识点
          const existingKb = await db.prepare('SELECT * FROM knowledge_base WHERE knowledge_point = ?').bind(kp).first();

          for (const note of kpNotes) {
            if (note.note_content && note.note_content !== '需要解释') {
              item.corePoints.push(note.note_content);
            }
            if (note.explanation) {
              item.memoryTips.push(note.explanation);
            }
            item.relatedQuestions.push({
              id: note.question_id,
              content: note.question_content?.substring(0, 100) + '...'
            });
          }

          // 添加核心知识点扩展
          item.corePoints.push(`【扩展】${kp} 是网络规划设计师考试的核心考点，建议深入理解其原理和应用场景。`);

          // 保存到知识库
          const contentStr = item.corePoints.join('\n\n');
          if (existingKb) {
            // 已存在：更新内容 + 增加引用次数
            await db.prepare(`
              UPDATE knowledge_base
              SET content = ?, source_count = source_count + 1, last_updated = CURRENT_TIMESTAMP
              WHERE knowledge_point = ?
            `).bind(contentStr, kp).run();
            item.fromKnowledgeBase = false; // 本次生成覆盖
          } else {
            // 新增
            await db.prepare(`
              INSERT INTO knowledge_base (knowledge_point, content, source_count)
              VALUES (?, ?, 1)
            `).bind(kp, contentStr).run();
          }

          extensionContent.items.push(item);
        }

        // 保存到数据库（每日扩展资料表）
        const contentJson = JSON.stringify(extensionContent);
        const noteIds = notes.map(n => n.id).join(',');

        await db.prepare(`
          INSERT OR REPLACE INTO daily_extensions (date, content, source_notes)
          VALUES (?, ?, ?)
        `).bind(today, contentJson, noteIds).run();

        // 清理7天前的每日扩展资料（保留知识库）
        await db.prepare(`
          DELETE FROM daily_extensions WHERE date < datetime('now', '-7 days')
        `).run();

        return new Response(JSON.stringify({
          status: 'generated',
          date: today,
          content: extensionContent
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // 获取知识库内容（从数据库积累的扩展资料）
      if (path === '/api/knowledge/base' && request.method === 'GET') {
        const search = url.searchParams.get('search') || '';
        const page = parseInt(url.searchParams.get('page') || '1');
        const limit = Math.min(parseInt(url.searchParams.get('limit') || '20'), 50);
        const offset = (page - 1) * limit;

        let query = 'SELECT * FROM knowledge_base';
        let countQuery = 'SELECT COUNT(*) as total FROM knowledge_base';
        const params = [];
        const countParams = [];

        if (search) {
          query += ' WHERE knowledge_point LIKE ?';
          countQuery += ' WHERE knowledge_point LIKE ?';
          params.push(`%${search}%`);
          countParams.push(`%${search}%`);
        }

        query += ' ORDER BY source_count DESC, last_updated DESC LIMIT ? OFFSET ?';

        const countResult = await db.prepare(countQuery).bind(...countParams).first();
        const rawItems = await db.prepare(query).bind(...params, limit, offset).all();
        const items = Array.isArray(rawItems) ? rawItems : [];

        return new Response(JSON.stringify({
          total: countResult?.total || 0,
          page,
          limit,
          items: items.map(i => ({
            knowledgePoint: i.knowledge_point,
            content: i.content,
            sourceCount: i.source_count,
            lastUpdated: i.last_updated
          }))
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // ===== 原有API保持兼容 =====

      // 获取每日内容
      if (path === '/api/daily') {
        const date = url.searchParams.get('date') || new Date().toISOString().split('T')[0];
        const result = await db.prepare('SELECT * FROM daily_content WHERE date = ?').bind(date).first();

        if (!result) {
          return new Response(JSON.stringify({
            date: date,
            type: 'comprehensive',
            topic: '综合知识 - 自助学习',
            tags: '选择题,高频考点',
            knowledge: JSON.stringify([
              { title: 'TCP三次握手', points: ['第一次：SYN=1, seq=x', '第二次：SYN=1, ACK=1, seq=y, ack=x+1', '第三次：ACK=1, seq=x+1, ack=y+1'] },
              { title: 'VLAN划分', points: ['基于端口（最常用）', '基于MAC地址', '基于协议', '基于IP子网'] }
            ]),
            framework: null
          }), {
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          });
        }

        return new Response(JSON.stringify(result), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // 更新学习进度
      if (path === '/api/progress' && request.method === 'POST') {
        const body = await request.json();
        await db.prepare(`
          INSERT INTO learning_progress (date, task_type, status, score, notes, updated_at)
          VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
        `).bind(body.date, body.task_type, body.status, body.score || null, body.notes || null).run();

        return new Response(JSON.stringify({ status: 'updated' }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // 获取学习进度
      if (path === '/api/progress') {
        const date = url.searchParams.get('date');
        let query = 'SELECT * FROM learning_progress';
        let bindings = [];
        if (date) {
          query += ' WHERE date = ?';
          bindings.push(date);
        }
        const { results } = await db.prepare(query).bind(...bindings).all();
        return new Response(JSON.stringify(results), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      return new Response('Not Found', { status: 404 });
    } catch (err) {
      return new Response(JSON.stringify({ error: err.message }), {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    }
  }
};