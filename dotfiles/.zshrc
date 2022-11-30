################################################################################
# Prompt
################################################################################

# If the PROMPT_SUBST option is set, the prompt string is first subjected to parameter expansion, command substitution and arithmetic expansion
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
setopt PROMPT_SUBST

# https://zwbetz.com/change-terminal-prompt-on-mac/
current_git_branch() {
  local BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ -n ${BRANCH} ]] ; then
    echo "(${BRANCH})"
  fi
}

# https://unix.stackexchange.com/a/126316
export NEWLINE=$'\n'

# The PROMPT must be wrapped in single quotes in order for current_git_branch to refresh on each dir change
export PROMPT='%n@%m %F{cyan}%~%F{reset_color} %F{yellow}$(current_git_branch)%F{reset_color} ${NEWLINE}%# '

################################################################################
# PATH
################################################################################

export PATH="${HOME}/bin:${PATH}"

################################################################################
# Aliases
################################################################################

alias ll="ls -alFh"
alias grep="grep --color=auto"
