################################################################################
# Prompt
################################################################################

# If the PROMPT_SUBST option is set, the prompt string is first subjected to parameter expansion, command substitution and arithmetic expansion
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
setopt PROMPT_SUBST

# https://zwbetz.com/change-terminal-prompt-on-mac/
format_current_git_branch() {
  local BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ -n ${BRANCH} ]] ; then
    echo "(${BRANCH})"
  fi
}

# https://unix.stackexchange.com/a/126316
export NEWLINE=$'\n'

# The PROMPT must be wrapped in single quotes in order for the current git branch to refresh on each dir change
export PROMPT='%n@%m %F{cyan}%~%F{reset_color} %F{yellow}$(format_current_git_branch)%F{reset_color} ${NEWLINE}%# '

################################################################################
# PATH and Env Vars
################################################################################

# Various tools
export PATH="${HOME}/bin:${PATH}"

# Java
export JAVA_HOME="${HOME}/bin/jdk-17.0.5+8/Contents/Home"
export PATH="${JAVA_HOME}/bin:${PATH}"

# Maven
export PATH="${HOME}/bin/apache-maven-3.8.6/bin:${PATH}"

# Node.js
export PATH="${HOME}/bin/node-v18.12.1-darwin-arm64/bin:${PATH}"

################################################################################
# Aliases
################################################################################

alias ll="ls -alFh"
alias grep="grep --color=auto"

################################################################################
# Functions
################################################################################

change_to_vscode_user_settings_dir() {
  cd "${HOME}/Library/Application Support/Code/User/"
}
