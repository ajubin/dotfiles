# HOW-TO: Faster ZSH and profiling 
# https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load.html#how-to-test-your-shell-load-time
# https://htr3n.github.io/2018/07/faster-zsh/

export ZSH_DISABLE_COMPFIX=true # disable handle_completion_insecurities in oh-my-zsh
# Install oh-my-zsh
source ~/dotfiles/zsh/oh-my-zsh.zsh

## History
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Install fzf
source ~/dotfiles/zsh/fzf.zsh


# Golang path
export GOPATH=$HOME/go-workspace
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/antoinejubin/.sdkman"
[[ -s "/Users/antoinejubin/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/antoinejubin/.sdkman/bin/sdkman-init.sh"
export PATH=$PATH:/Users/antoinejubin/Library/Android/sdk/platform-tools
export PATH=$PATH:/Users/antoinejubin/Library/Android/sdk/tools/bin
eval "$(pyenv init -)"

export ANDROID_HOME=~/Library/Android/sdk
alias grbim='git rebase -i origin/master'
alias zconf='code ~/dotfiles/zsh/zshrc.zsh'
alias reload='source ~/.zshrc' # Relaunch dotbot with ./install in dotfiles dir
alias vconf='vim ~/.vimrc'
alias emul='/Users/antoinejubin/Library/Android/sdk/emulator/emulator @Nexus_5_API_28 </dev/null &>/dev/null &'
alias rr='adb shell input keyevent 82'
alias albert='emulator @Albert </dev/null &>/dev/null &'
alias ip='ipconfig getifaddr en0'
alias syncAndroid='adb shell date -s `date +%G%m%d.%H%M%S`'
alias gitDelete='git branch --no-color | command grep -vE "^(\*|\s*(master|temp|wip)\s*$)" | command xargs -n 1 git branch -D'
alias gitResetMaster='git checkout -B master origin/master'
alias resetSound='sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod'
gcodate() {
  git checkout `git rev-list -n 1 --before="$1" master`
}


numberOfLines(){
  find $1 -type f -exec wc -l {} + | sort -rn
}
todo(){
  git diff master..`git branch --show-current` | grep "^+.*TODO"
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


source ~/scripts/useful.sh


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/antoinejubin/Applications/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/antoinejubin/Applications/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/antoinejubin/Applications/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/antoinejubin/Applications/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/usr/local/sbin:$PATH"

# Fix asdf issue install with homebrew - https://github.com/asdf-vm/asdf/issues/428
export ASDF_DIR="/usr/local/opt/asdf"

# Add date on right side of prompt
# export RPROMPT="[%D{%y/%m/%f}|%@]"

# To use php installed via homebrew before default php on macos
export PATH="/usr/local/opt/php@7.4/bin:$PATH"
export PATH="/usr/local/opt/php@7.4/sbin:$PATH"
export PATH="$HOME/.symfony/bin:$PATH"
