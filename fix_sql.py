#!/usr/bin/env python3
"""
处理 questions.sql，分离 answer 和 explanation 字段
"""

def fix_options_simple(options_str):
    """修复 options 格式"""
    # options_str 看起来像: [['A. xxx', 'B. yyy']]
    # 我们需要把它变成 JSON: ["A. xxx", "B. yyy"]

    # 去掉首尾的 [[ 和 ]]
    if options_str.startswith("[['") and options_str.endswith("']]"):
        inner = options_str[2:-2]  # remove [[ and ]]
        # 替换 \' 为 '
        inner = inner.replace("\\'", "'")
        # 分割成各个选项
        items = [x.strip().strip("'") for x in inner.split("', '")]
        items = [x for x in items if x]
        return '["' + '", "'.join(items) + '"]'
    return options_str

def main():
    input_file = 'questions.sql'
    output_file = 'questions_clean.sql'

    with open(input_file, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    new_lines = []
    stats = {'total': 0, 'with_answer': 0, 'with_explanation': 0}

    for line in lines:
        line = line.strip()
        if not line or not line.startswith("INSERT INTO questions"):
            continue

        stats['total'] += 1

        # 简单字符串处理方式
        # 找到 "参考答案：X" 和 "解析 ：" 的位置

        # 找参考答案
        ans_idx = line.find('参考答案')
        answer = ''
        if ans_idx >= 0:
            # 参考答案后面第一个大写字母 A-D 或甲乙丙丁
            rest = line[ans_idx:]
            for i, c in enumerate(rest):
                if c in 'ABCD甲乙丙丁':
                    answer = c
                    if c in '甲乙丙丁':
                        mapping = {'甲': 'A', '乙': 'B', '丙': 'C', '丁': 'D'}
                        answer = mapping.get(c, c)
                    break

        # 找解析
        exp_idx = line.find('解析')
        explanation = ''
        if exp_idx >= 0:
            # 从 "解析" 后开始，到下一个 "第X题" 或 "参考答案" 或 options 开始
            rest = line[exp_idx + 2:]  # skip "解析"
            # options 开始标志是 '', '[[
            opt_idx = rest.find("''', '[[")
            ans_match_idx = rest.find('参考答案')

            end = len(rest)
            if opt_idx > 0:
                end = min(end, opt_idx)
            if ans_match_idx > 0:
                end = min(end, ans_match_idx)

            explanation = rest[:end].strip()
            explanation = explanation.lstrip(' ：:').strip()
            # 合并多余空白
            while '  ' in explanation:
                explanation = explanation.replace('  ', ' ')

        # 找 content - 在 type 之后 options 之前
        # 格式: VALUES ('type', 'content', '[[options...

        # 提取 options 部分
        opt_start = line.find("', '[[")
        opt_end = line.rfind("]]'") + 2
        if opt_start > 0 and opt_end > opt_start:
            options_raw = line[opt_start + 4:opt_end + 1]  # skip ',
            options_clean = fix_options_simple("[[" + options_raw + "]]")
        else:
            options_clean = '[]'

        # 提取 difficulty, category, tags, year (最后4个字段)
        # 找到最后一个 ), 之前的内容
        last_fields_match = line.rfind("), '")
        if last_fields_match > 0:
            suffix = line[last_fields_match + 3:]
            parts = suffix.split("', '")
            if len(parts) >= 4:
                difficulty = parts[0].strip()
                category = parts[1].strip()
                tags = parts[2].strip()
                year = parts[3].strip().rstrip(');')

        # 找 type 和 content
        values_start = line.find("VALUES ('")
        if values_start >= 0:
            rest = line[values_start + 9:]  # skip "VALUES ('"
            # type 是到第一个 ',
            type_end = rest.find("', '")
            if type_end > 0:
                type_val = rest[:type_end]
                # content 从下一个 ' 开始
                content_start = rest.find("', '", type_end + 1)
                if content_start > 0:
                    content_start += 4  # skip ',
                    # content 结束于 options 开始
                    content_end = line.find("', '[[", content_start)
                    if content_end > 0:
                        content = line[content_start:content_end]
                        # 清理答案和解析
                        # 移除 "参考答案" 及其后的内容
                        ans_pos = content.find('参考答案')
                        if ans_pos >= 0:
                            content = content[:ans_pos]
                        # 移除 "解析" 及其后续
                        exp_pos = content.find('解析')
                        if exp_pos >= 0:
                            content = content[:exp_pos]
                        # 转义单引号
                        content = content.replace("'", "''")

        # 转义 explanation
        explanation = explanation.replace("'", "''")

        # 构建新行
        new_line = f"INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES ({type_val}, '{content}', \"{options_clean}\", '{answer}', '{explanation}', {difficulty}, {category}, {tags}, {year});"

        new_lines.append(new_line)

        if answer:
            stats['with_answer'] += 1
        if explanation and len(explanation) > 20:
            stats['with_explanation'] += 1

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write('\n'.join(new_lines))

    print(f"处理完成: {stats['total']} 行")
    print(f"有答案: {stats['with_answer']}")
    print(f"有解析 (>20字符): {stats['with_explanation']}")
    print(f"输出文件: {output_file}")

    # 显示样例
    print("\n=== 样例 ===")
    with open(output_file, 'r', encoding='utf-8') as f:
        for i, line in enumerate(f):
            if "explanation" in line and len(line) > 200:
                parts = line.split("', '")
                if len(parts) >= 5:
                    exp = parts[4].strip()
                    if len(exp) > 30:
                        print(f"行{i+1}: answer={parts[3].strip()}, exp={exp[:60]}...")
                        break

if __name__ == '__main__':
    main()