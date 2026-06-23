
<p align="center">
  <b>🌐 <a href="#-中文-1">中文</a> · <a href="#-english">English</a></b>
</p>

<h1 align="center">WeChatHermes 🤖💬</h1>

<p align="center">
  <b>Talk to AI from WeChat. One command, done.</b><br>
  <b>一键安装 Hermes AI Agent，在微信中和 AI 对话。</b>
</p>

<p align="center">
  <a href="#-one-click-install--一键安装"><img src="https://img.shields.io/badge/🚀_一键安装-One_Command-blue?style=for-the-badge" alt="One Click Install"></a>
  <a href="https://github.com/Monah-Limited/WeChatHermes/stargazers"><img src="https://img.shields.io/github/stars/Monah-Limited/WeChatHermes?style=for-the-badge&logo=github" alt="Stars"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge" alt="MIT"></a>
  <br>
  <img src="https://img.shields.io/badge/macOS-✓-blue?logo=apple" alt="macOS">
  <img src="https://img.shields.io/badge/Linux-✓-orange?logo=linux" alt="Linux">
  <img src="https://img.shields.io/badge/Python-3.9+-green?logo=python" alt="Python">
</p>

---

## 📱 这是什么？/ What is this?

**中文：** WeChatHermes 让你在**微信里和 AI 对话**。安装后，你给机器人发消息，它会调用各种工具（查天气、搜资料、写代码、分析文件...）并回复你。

**English:** WeChatHermes lets you **chat with an AI agent from WeChat**. Once installed, message the bot and it can search the web, check weather, write code, analyze files, and more — replying directly in WeChat.

```
你: 今天北京天气怎么样？
Bot: ☀️ 北京今天晴，25-32°C，适合外出。
     (刚刚查询了天气API)

你: 帮我写一个 Python 斐波那契函数
Bot: def fibonacci(n):
         if n <= 1: return n
         return fibonacci(n-1) + fibonacci(n-2)
     (代码已写好，可以直接用)
```

---

## 🚀 一键安装 / One-Click Install

**中文：** 打开终端，粘贴以下命令，按回车：

**English:** Open your terminal, paste this command, hit Enter:

```bash
curl -sfL https://raw.githubusercontent.com/Monah-Limited/WeChatHermes/main/install.sh | sh
```

**安装过程：** 约 1-3 分钟，全程自动化

```
❶ 检查系统      → macOS / Linux ✓
❷ 检查 Python   → 3.9+ ✓
❸ 安装 Hermes   → pip install hermes-agent
❹ 配置微信网关  → 选 WeChat → 扫码登录（需手机操作）
❺ 启动服务      → 后台运行 ✓
❻ 完成！        → 打开微信发消息吧！
```

---

## 📋 使用指南 / How to Use

安装完成后，直接在微信里给机器人发消息：

| 你的消息 | Bot 会怎么做 |
|---------|-------------|
| `hi` | 打招呼，显示可用功能 |
| `今天天气怎么样？` | 查询实时天气 |
| `搜索 Python 教程` | 联网搜索，返回结果 |
| `帮我写个排序算法` | 生成代码 |
| `分析这张图片` | 发送图片 → AI 分析内容 |
| `帮我总结这个 PDF` | 发文件 → AI 总结 |
| `help` | 显示帮助信息 |

### 管理员命令 / Admin Commands

```bash
hermes gateway status    # 查看服务状态
hermes gateway stop      # 停止服务
hermes gateway start     # 启动服务
hermes gateway setup     # 重新配置
```

---

## ⚙️ 工作原理 / How It Works

```
┌──────────────────┐     ┌──────────────┐     ┌─────────────────┐
│  微信 WeChat     │ ←──→ │  Hermes      │ ←──→ │  AI 模型        │
│  发消息 / 收回复  │     │  Gateway     │     │  DeepSeek / GPT │
└──────────────────┘     └──────────────┘     └─────────────────┘
                                  │
                          ┌───────┴───────┐
                          │   工具 / Tools │
                          │ 天气 │ 搜索 │   │
                          │ 代码 │ 文件 │ … │
                          └───────────────┘
```

- **Hermes Agent** — 开源的 AI Agent 框架（由 Nous Research 开发）
- **WeChat Gateway** — 通过 iLink 协议连接微信
- **AI 模型** — 默认使用 DeepSeek V4 Flash（极低成本，~¥1/百万 tokens）

---

## 🧠 配置自定义模型 / Custom Models

**中文：** 你可以切换成其他 AI 模型（GPT-4、Claude 等）：

**English:** You can switch to other AI models:

```bash
hermes config set model gpt-4
hermes config set provider openai
hermes config set openai_api_key sk-xxx...
```

---

## 🗑️ 卸载 / Uninstall

```bash
hermes gateway stop
hermes gateway uninstall
pip uninstall hermes-agent -y
rm -rf ~/.hermes ~/.hermes-wechathermes
```

---

## 🔐 隐私 / Privacy

**中文：** 所有数据运行在你的**本地电脑**上，不会上传到第三方服务器。AI 模型调用通过你配置的 API Key（DeepSeek / OpenAI / 其他）。

**English:** Everything runs on **your local machine**. No data leaves your computer except API calls to your configured AI model provider.

---

## 🧠 "30 Apps in 100 Days"

这是 **30 Apps in 100 Days** 挑战的 Day 2 作品。

Day 1: [SmartClipAI](https://github.com/Monah-Limited/SmartClipAI) — AI 剪贴板助手

---

## 🤝 贡献 / Contributing

**中文：** PR 欢迎！改进方向：

**English:** PRs welcome! Ideas:

- [ ] 支持更多聊天平台（Telegram, Discord, WhatsApp）
- [ ] 自动检测 `hermes gateway setup` 选项编号
- [ ] 安装后自动打开浏览器跳转 QR 码
- [ ] Docker 一键部署

---

## 🙏 Credits / 致谢

This project builds on these open-source projects:

| Project | What it does |
|---------|-------------|
| [**Hermes Agent**](https://github.com/nousresearch/hermes-agent) | AI agent framework that powers the brain |
| [**WeChat iLink**](https://github.com/iuiaoin/wechat- ilink) | WeChat bridge / protocol gateway |
| [**ItChat**](https://github.com/littlecodersh/ItChat) | WeChat personal account API (inspiration) |
| [**itchat-uos**](https://github.com/why2lyj/itchat-uos) | UOS-compatible ItChat fork |
| [**OpenClaw**](https://github.com/Monah-Limited) | Monah's AI orchestration layer |

**Special thanks** to the Hermes Agent team at [Nous Research](https://nousresearch.com) for building the agent runtime that makes this integration possible.

---

## 🇨🇳 中文

<p align="center">
  <b><a href="#-english">← English</a> · 中文</b>
</p>

**WeChatHermes 🤖💬** — 一键在微信中和 Hermes AI Agent 对话。

### 一键安装

```bash
curl -fsSL https://raw.githubusercontent.com/Monah-Limited/WeChatHermes/main/install.sh | bash
```

### 功能

- 💬 在微信中直接和 AI 对话
- 🤖 支持 Hermes Agent 全部能力
- 🔧 一键安装，无需配置
- 🔒 消息加密传输

### 致谢

感谢 [Nous Research](https://nousresearch.com) 的 Hermes Agent、[WeChat iLink](https://github.com/iuiaoin/wechat-ilink) 和 [ItChat](https://github.com/littlecodersh/ItChat) 项目。

---

## 📄 许可证 / License

MIT

---

<p align="center">
  <b>⭐ 如果对你有帮助，请点个 Star！</b>
</p>
