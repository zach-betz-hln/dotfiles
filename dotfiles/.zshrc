################################################################################
# Prompt
################################################################################

# If the PROMPT_SUBST option is set, the prompt string is first subjected to parameter expansion, command substitution and arithmetic expansion
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
setopt PROMPT_SUBST

# https://zwbetz.com/how-to-change-your-zsh-shell-prompt/
format_current_git_branch() {
  BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ -n ${BRANCH} ]] ; then
    echo "${BRANCH}"
  fi
}

# https://unix.stackexchange.com/a/126316
export NEWLINE=$'\n'

# The PROMPT must be wrapped in single quotes in order for the current git branch to refresh on each dir change
export PROMPT='%n@%m %F{cyan}%~%F{reset_color} %F{yellow}$(format_current_git_branch)%F{reset_color} ${NEWLINE}%# '

################################################################################
# PATH
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

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# PDF diff tooling
export PATH="/opt/homebrew/opt/libxml2/bin:${PATH}"
export PATH="/opt/homebrew/opt/libxslt/bin:${PATH}"

# Python
export PATH="${HOME}/Library/Python/3.9/bin:${PATH}"

# Google Cloud
export PATH="${HOME}/bin/google-cloud-sdk/bin:${PATH}"

################################################################################
# Command Completions
################################################################################

# To activate these completions, add the following to your .zshrc:
if type brew &> /dev/null ; then
  FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"
  autoload -Uz compinit
  compinit

  # You may also need to force rebuild `zcompdump`:
  # rm -f ~/.zcompdump
  # compinit

  # Additionally, if you receive "zsh compinit: insecure directories" warnings when attempting to load these completions, you may need to run this:
  # chmod -R go-w /opt/homebrew/share
  # chmod -R go-w /opt/homebrew/share/zsh
fi

################################################################################
# Aliases
################################################################################

alias ll="ls -alFh"

alias grep="grep --color=auto"

################################################################################
# General Functions
################################################################################

change_to_vscode_user_settings_dir() {
  cd "${HOME}/Library/Application Support/Code/User/"
}

change_to_openvpn_profiles_dir() {
  cd "${HOME}/Library/Application Support/OpenVPN Connect/profiles/"
}

pretty_print_path() {
  echo ${PATH} | tr ':' '\n'
}

export_secrets_into_current_shell() {
  SECRETS_FILE="${HOME}/dev/dotfiles/.secrets"
  # grep -v '^#' ${SECRETS_FILE}
  export $(grep -v '^#' ${SECRETS_FILE} | xargs)
}

export_secrets_into_current_shell

################################################################################
# Docker Functions
################################################################################

stop_all_docker_containers() {
  docker ps -a --format "{{.ID}}" | xargs docker stop
}

remove_all_docker_containers() {
  docker ps -a --format "{{.ID}}" | xargs docker rm
}

clean_docker() {
  echo "Pruning unused containers"
  docker container prune -f

  echo "Pruning unused images"
  docker image prune -f

  echo "Pruning unused volumes"
  docker volume prune -f

  echo "Pruning unused data"
  docker system prune -f
}

################################################################################
# Git Functions
################################################################################

delete_all_git_branches_except_current() {
  echo "Before"
  git branch

  echo "Deleting all git branches except current"
  git branch | grep -v '^*' | xargs git branch -D

  echo "Removing any remote-tracking references that no longer exist on the remote"
  git fetch -p

  echo "After"
  git branch
}

################################################################################
# Project Functions
################################################################################

build_mvn() {
  mvn package
}

run_mvn() {
  mvn spring-boot:run
}
