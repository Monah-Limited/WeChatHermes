#!/usr/bin/env bash
# ============================================================================
# WeChatHermes — One-Click Installer
# ============================================================================
# Talk to AI from WeChat. One command, done.
#
# Usage:
#   curl -sfL https://raw.githubusercontent.com/monah-studio/WeChatHermes/main/install.sh | sh
# ============================================================================

set -euo pipefail

REPO="monah-studio/WeChatHermes"
HERMES_VENV="$HOME/.hermes-wechathermes/venv"
HERMES_CONFIG="$HOME/.hermes"

# ── Colors ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

info()  { printf "${BLUE}🔵 %s${NC}\n" "$*"; }
ok()    { printf "${GREEN}✅ %s${NC}\n" "$*"; }
warn()  { printf "${YELLOW}⚠️  %s${NC}\n" "$*"; }
error() { printf "${RED}❌ %s${NC}\n" "$*"; exit 1; }
step()  { printf "\n${CYAN}━━━ %s ━━━${NC}\n" "$*"; }
url()   { printf "${CYAN}🔗 %s${NC}\n" "$*"; }

# ── Header ──────────────────────────────────────────────────────────────────
cat << 'EOF'

╔══════════════════════════════════════════════╗
║         WeChatHermes  Installer              ║
║     🤖 + 💬 = Talk to AI from WeChat         ║
╚══════════════════════════════════════════════╝
EOF
echo ""

# ── OS Check ────────────────────────────────────────────────────────────────
step "1/6  系统检查 / System Check"

OS="$(uname -s)"
if [ "$OS" != "Darwin" ] && [ "$OS" != "Linux" ]; then
    error "WeChatHermes supports macOS and Linux. Detected: $OS"
fi

ARCH="$(uname -m)"
info "OS: $OS ($ARCH)"

# ── Python Check ────────────────────────────────────────────────────────────
step "2/6  Python 环境检查 / Python Check"

PYTHON=""
for py in "/opt/homebrew/bin/python3.11" "/opt/homebrew/bin/python3.12" \
          "/usr/local/bin/python3.11" "/opt/homebrew/bin/python3" \
          "/usr/bin/python3" "$HOME/.local/bin/python3.11"; do
    if [ -x "$py" ] && "$py" -c "import sys; sys.exit(0 if sys.version_info >= (3,9) else 1)" 2>/dev/null; then
        PYTHON="$py"
        break
    fi
done

if [ -z "$PYTHON" ]; then
    warn "Python 3.9+ not found. Installing via Homebrew (macOS)..."
    if command -v brew &>/dev/null; then
        brew install python@3.11 2>&1 | tail -3
        PYTHON="/opt/homebrew/bin/python3.11"
    elif command -v apt &>/dev/null; then
        sudo apt update -qq && sudo apt install -y python3 python3-pip python3-venv -qq 2>&1 | tail -3
        PYTHON="/usr/bin/python3"
    else
        error "Please install Python 3.9+: https://www.python.org/downloads/"
    fi
fi

PY_VER="$($PYTHON --version 2>&1)"
ok "$PY_VER at $PYTHON"

# ── Install Hermes Agent ─────────────────────────────────────────────────────
step "3/6  安装 Hermes Agent / Installing Hermes Agent"

# Check if already installed
if command -v hermes &>/dev/null 2>&1; then
    HERMES_VER=$(hermes --version 2>/dev/null || echo "installed")
    ok "Hermes already installed: $HERMES_VER"
else
    info "Installing Hermes Agent..."
    $PYTHON -m venv "$HERMES_VENV" 2>/dev/null || mkdir -p "$HERMES_VENV"
    $HERMES_VENV/bin/pip install --quiet --upgrade pip 2>/dev/null
    $HERMES_VENV/bin/pip install --quiet hermes-agent 2>&1 | tail -3
    
    # Add to PATH
    HERMES_BIN="$HERMES_VENV/bin"
    if [ -f "$HERMES_BIN/hermes" ]; then
        mkdir -p "$HOME/.local/bin"
        ln -sf "$HERMES_BIN/hermes" "$HOME/.local/bin/hermes"
        # Add to PATH for this session
        export PATH="$HOME/.local/bin:$PATH"
        ok "Hermes installed to $HERMES_BIN"
    else
        error "Hermes installation failed"
    fi
fi

# Verify hermes command
if ! command -v hermes &>/dev/null; then
    export PATH="$HOME/.local/bin:$PATH"
fi
if ! command -v hermes &>/dev/null; then
    error "hermes command not found in PATH"
fi

HERMES_VER=$(hermes --version 2>/dev/null || echo "unknown")
ok "Hermes $HERMES_VER"

# ── Configure WeChat Gateway ────────────────────────────────────────────────
step "4/6  配置微信网关 / Configure WeChat Gateway"

# Check if weixin is already configured
if hermes gateway list 2>/dev/null | grep -qi "weixin\|wechat"; then
    ok "WeChat gateway already configured"
else
    info "WeChat gateway not configured. Let's set it up..."
    echo ""
    warn "接下来的步骤需要您在手机上操作："
    echo ""
    echo "  1. 下面会启动网关设置向导"
    echo "  2. 从列表中选择 Weixin / WeChat (选项 13)"
    echo "  3. 回答 Y 开始微信登录"
    echo "  4. 屏幕上会出现一个 URL"
    echo "  5. 用手机浏览器打开该 URL → 出现二维码"
    echo "  6. 用微信扫描二维码 → 登录完成！"
    echo ""
    read -p "按 Enter 继续..." _
    
    hermes gateway setup
fi

# ── Install Gateway Service ─────────────────────────────────────────────────
step "5/6  安装后台服务 / Install Gateway Service"

if hermes gateway status 2>/dev/null | grep -qi "running"; then
    ok "Gateway already running"
else
    info "Installing gateway as background service..."
    hermes gateway install 2>&1 | tail -3 || true
    hermes gateway start 2>&1 | tail -3 || true
    ok "Gateway service installed and started"
fi

# ── Done ─────────────────────────────────────────────────────────────────────
step "6/6  完成！/ Complete!"

echo ""
ok "============================================"
ok "  WeChatHermes 安装完成！"
ok "  Installation Complete!"
ok "============================================"
echo ""
echo "  📱 现在打开微信，给机器人发一条消息试试！"
echo "  📱 Send a message to the bot on WeChat!"
echo ""
echo "  试试这些命令 / Try these commands:"
echo "    hi"
echo "    今天天气怎么样？"
echo "    help"
echo ""
echo "  💡 命令前缀 / Command prefix:"
echo "    发送文字即可和 AI 对话"
echo "    发送图片 → AI 会自动识别"
echo ""
echo "  🔧 管理命令 / Admin commands:"
echo "    hermes gateway status     查看网关状态"
echo "    hermes gateway stop       停止网关"
echo "    hermes gateway start      启动网关"
echo ""
url "  https://github.com/$REPO"
echo ""
info "  ⭐ 如果好用，请点个 Star！"
echo ""
