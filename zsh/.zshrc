echo "good to have you master"

# Organized configuration from ~/.zshrc-config/
ZSH_CONF_DIR="$HOME/.zshrc-config"

source "$ZSH_CONF_DIR/.zshrc-aliases"
source "$ZSH_CONF_DIR/.zshrc-flags"
#source "$ZSH_CONF_DIR/.zshrc-instahyre"
source "$ZSH_CONF_DIR/.zshrc-work"
source "$ZSH_CONF_DIR/.zshrc-iterm"
source "$ZSH_CONF_DIR/.zshrc-misc"
source "$ZSH_CONF_DIR/.zshrc-path"
source "$ZSH_CONF_DIR/.zshrc-utils"
source "$ZSH_CONF_DIR/.zshrc-tork"
source "$ZSH_CONF_DIR/.zshrc-kitty-tab"
# Add trash-cli to PATH for undo functionality
export PATH="/opt/homebrew/opt/trash-cli/bin:$PATH"

# Lazy-load NVM (Instant shell startup)
export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}
node() { nvm >/dev/null; node "$@" }
npm()  { nvm >/dev/null; npm "$@" }
npx()  { nvm >/dev/null; npx "$@" }

# Python & uv
export PATH="$HOME/.local/bin:$PATH"
eval "$(uv generate-shell-completion zsh 2>/dev/null)"


# Optimized Java & Misc PATH
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export PATH="/opt/homebrew/opt/openjdk@21/bin:/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="/Users/bogusdeck/.codeium/windsurf/bin:$PATH"
export PATH="/Users/bogusdeck/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/Library/Python/3.11/bin:$HOME/.local/bin:$PATH"

# Optimized Angular Completion
if command -v ng &> /dev/null; then
    NG_COMPLETION_CACHE="$HOME/.cache/ng_completion.zsh"
    [ ! -f "$NG_COMPLETION_CACHE" ] && ng completion script > "$NG_COMPLETION_CACHE"
    source "$NG_COMPLETION_CACHE"
fi

# Disable Vi mode entirely & force standard Emacs keymap
bindkey -e

# Fix for Arrow keys
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[b" backward-word
bindkey "^[f" forward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# fzf
[ -f "$ZSH_CONF_DIR/.fzf.zsh" ] && source "$ZSH_CONF_DIR/.fzf.zsh"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"
if command -v fd &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Kitty Random Theme Switcher
# source "$ZSH_CONF_DIR/.zshrc-theme"
alias kt='/Users/bogusdeck/.config/kitty/theme_switcher.sh'
alias kt='/Users/bogusdeck/.config/kitty/theme_switcher.sh'


# Added by Antigravity CLI installer
export PATH="/Users/bogusdeck/.local/bin:$PATH"
alias zed-leetcode='zed /Users/bogusdeck/leetcode'

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit && compinit -C
# <<< grok installer <<<

# ============================================================
# Local AI: Ollama + coding tool providers
# ============================================================

# Ollama daemon location (server is launched via `brew services start ollama`)
export OLLAMA_HOST="http://127.0.0.1:11434"

# Default local model — change here to switch all tools at once
export LOCAL_MODEL="qwen2.5-coder:7b"

# OpenAI-compatible envs (for Kilo, Codex, and any tool that mimics the OpenAI API)
export OPENAI_BASE_URL="$OLLAMA_HOST/v1"
export OPENAI_API_KEY="ollama"   # dummy, ollama ignores it

# Gemini via OpenRouter (for tools that support OpenAI-compatible API)
export OPENAI_BASE_URL_GEMINI="https://openrouter.ai/api/v1"
# Source local uncommitted secrets
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
export OPENAI_MODEL_GEMINI="google/gemini-2.0-flash-exp:free"

# Codex — point at local Ollama
export CODEX_PROVIDER="ollama"
export CODEX_MODEL="$LOCAL_MODEL"


# Convenience aliases
alias ai="ollama run \$LOCAL_MODEL"
alias models="ollama list"
alias serve-ai="brew services start ollama"
alias stop-ai="brew services stop ollama"
alias ai-status="curl -s \$OLLAMA_HOST/api/tags | python3 -m json.tool 2>/dev/null | head -30"

alias pd-httpx="$(brew --prefix httpx)/bin/httpx"

alias assignment="cd ~/Projects/assignment && ./start.sh"
alias cph='eval "$(fc -ln -1)" | pbcopy'
export NODE_OPTIONS="--disable-warning=DEP0205"
export OLLAMA_ORIGINS="*"

# UV Aliases
alias uvr="uv run"
