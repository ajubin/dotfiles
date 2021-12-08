# HOW-TO: Faster ZSH and profiling 
# https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load.html#how-to-test-your-shell-load-time
# https://htr3n.github.io/2018/07/faster-zsh/

export ZSH_DISABLE_COMPFIX=true # disable handle_completion_insecurities in oh-my-zsh

# Add brew
eval "$(/opt/homebrew/bin/brew shellenv)"
# Install oh-my-zsh
source ~/dotfiles/zsh/oh-my-zsh.zsh

## History
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Install fzf
source ~/dotfiles/zsh/fzf.zsh

c(){
  code ./
}
alias grbim='git rebase -i origin/master'
alias zconf='code ~/dotfiles/zsh/zshrc.zsh'
alias reload='source ~/.zshrc' # Relaunch dotbot with ./install in dotfiles dir
alias vconf='vim ~/.vimrc'
alias emul='/Users/ajubin/Library/Android/sdk/emulator/emulator @Nexus_5_API_28 </dev/null &>/dev/null &'
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

alias pr='open "https://github.com/bamlab/healico-server/pulls"'

# fg - see changes by commit
fg() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --reverse --tiebreak=index \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
                FZF-EOF
              "
}
# fr - Select commit to rebase onto
fr() {
  git log --graph --color=always --format="%h%C(#ff69b4)%d%C(reset) %s" "$@" | fzf --ansi --reverse --tiebreak=index | grep -o '[a-f0-9]\{7\}' | awk '{print $1"^"}' | xargs -o git rebase -i
}


export PATH=$PATH:$ANDROID_HOME/emulator

export PATH=$PATH:$HOME/scripts

# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
[[ -f /Users/ajubin/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh ]] && . /Users/ajubin/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/ajubin/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/ajubin/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/ajubin/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/ajubin/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/ajubin/.config/yarn/global/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/ajubin/.config/yarn/global/node_modules/tabtab/.completions/slss.zsh


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$HOME/.fastlane/bin:$PATH"
export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:/Users/ajubin/Library/Python/3.7/bin"
export PATH="$PATH:$HOME/dotfiles/scripts"
source "$HOME/dotfiles/scripts/useful.sh"




export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# Fix asdf issue install with homebrew - https://github.com/asdf-vm/asdf/issues/428
export ASDF_DIR="/opt/homebrew/opt/asdf"


## Issue with npm, was linked to -  /usr/local/bin/npm -> /usr/local/lib/node_modules/npm/bin/npm-cli.js 
## But we wan't to have npm from /Users/ajubin/.asdf/shims/npm
export PATH="$HOME/.asdf/shims:$PATH"

export HOMEBREW_NO_AUTO_UPDATE=1


