# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh


ZSH_THEME="spaceship"

SPACESHIP_GIT_BRANCH_COLOR="red"
SPACESHIP_GIT_STATUS_COLOR="yellow"
SPACESHIP_GCLOUD_SHOW="false"
SPACESHIP_PACKAGE_SHOW="false"

SPACESHIP_TIME_SHOW="true"
SPACESHIP_TIME_FORMAT="%T"  
SPACESHIP_TIME_COLOR="white"

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  react-native
  z
  zsh-autosuggestions
  fzf-yarn
)

source $ZSH/oh-my-zsh.sh
