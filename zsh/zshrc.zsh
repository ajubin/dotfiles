# Path to your oh-my-zsh installation.
export ZSH="/Users/antoinejubin/.oh-my-zsh"

ZSH_THEME="robbyrussell"

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
)

source $ZSH/oh-my-zsh.sh

## History
setopt hist_ignore_all_dups
setopt hist_ignore_space


# User configuration


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

zle -N zle-keymap-select

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/[% NORMAL]%}/(main|viins)/[% INSERT]%}"
}


# Golang path
export GOPATH=$HOME/go-workspace
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Install fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/antoinejubin/.sdkman"
[[ -s "/Users/antoinejubin/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/antoinejubin/.sdkman/bin/sdkman-init.sh"
export PATH=$PATH:/Users/antoinejubin/Library/Android/sdk/platform-tools
export PATH=$PATH:/Users/antoinejubin/Library/Android/sdk/tools/bin
eval "$(pyenv init -)"

export ANDROID_HOME=~/Library/Android/sdk
alias grbim='git rebase -i origin/master'
alias zconf='code ~/.zshrc'
alias reload='source ~/.zshrc'
alias vconf='vim ~/.vimrc'
alias emul='/Users/antoinejubin/Library/Android/sdk/emulator/emulator @Nexus_5_API_28 </dev/null &>/dev/null &'
alias rr='adb shell input keyevent 82'
alias albert='emulator @Albert </dev/null &>/dev/null &'
alias ip='ipconfig getifaddr en0'
alias syncAndroid='adb shell date -s `date +%G%m%d.%H%M%S`'
alias gitDelete='git branch --no-color | command grep -vE "^(\*|\s*(master|temp|wip)\s*$)" | command xargs -n 1 git branch -D'
numberOfLines(){
  find $1 -type f -exec wc -l {} + | sort -rn
}
alias pr='open "https://gitlab.com/ekwateur-applications-projects/ruban-app/-/merge_requests"'
export PATH=$PATH:$ANDROID_HOME/emulator

export PATH=$PATH:$HOME/scripts

# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
[[ -f /Users/antoinejubin/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh ]] && . /Users/antoinejubin/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/antoinejubin/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/antoinejubin/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/antoinejubin/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/antoinejubin/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/antoinejubin/.config/yarn/global/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/antoinejubin/.config/yarn/global/node_modules/tabtab/.completions/slss.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$HOME/.fastlane/bin:$PATH"
export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:/Users/antoinejubin/Library/Python/3.7/bin"

# begin appcenter completion
. <(appcenter --completion)
# end appcenter completion


source ~/scripts/useful.sh


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/antoinejubin/Applications/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/antoinejubin/Applications/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/antoinejubin/Applications/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/antoinejubin/Applications/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/usr/local/sbin:$PATH"
