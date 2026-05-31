# 每日知识点复习网站

网络规划设计师备考每日学习系统。

## 技术架构

- **Frontend**: 静态 HTML + PWA
- **Backend**: Cloudflare Worker
- **Database**: Cloudflare D1 (SQLite)

## 功能

- 每日综合知识复习
- 案例分析答题框架
- 论文写作模板
- 学习进度追踪

## 部署

### 方式一：GitHub Actions (推荐)

推送到 `main` 分支后自动部署。

需要添加 secrets:
- `CLOUDFLARE_API_TOKEN`: Cloudflare Account API Token

### 方式二：本地部署

```bash
cd daily-site
wrangler deploy
```

## API 端点

| 端点 | 方法 | 说明 |
|------|------|------|
| `/api/health` | GET | 健康检查 |
| `/api/daily` | GET | 获取每日内容 |
| `/api/progress` | GET | 获取学习进度 |
| `/api/progress` | POST | 更新学习进度 |

## D1 数据库

- Database ID: `d932e501-8d69-423e-a6a8-86b9f2b3ae74`
- Binding: `DB`

初始化数据库:
```bash
wrangler d1 execute networkcert-daily --file=schema.sql
```