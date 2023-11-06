# HOW-TO: Faster ZSH and profiling
# https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load.html#how-to-test-your-shell-load-time
# https://htr3n.github.io/2018/07/faster-zsh/

# make cd case-INsensitive
set completion-ignore-case

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

c() {
  # This comes from https://github.com/microsoft/vscode/issues/122951#issuecomment-1125177485
  # fixing issue to open preview
  code --no-sandbox ./
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
  git checkout $(git rev-list -n 1 --before="$1" master)
}

numberOfLines() {
  find $1 -type f -exec wc -l {} + | sort -rn
}

function todo() {
  # merci https://chat.openai.com/share/5b66a668-ddd2-48ae-afeb-051de7769200
  if [ -z "$1" ]; then
    base_branch="master"
  else
    base_branch="$1"
  fi

  echo "TODO:"
  git diff --name-only $base_branch..$(git branch --show-current) | xargs grep -nH 'TODO' | awk -F: '{print "- " $1 ":" $2}'
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
export PATH=$PATH:$HOME/Documents/ajubin/utils-js

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

# Install fnm (node manager)
eval "$(fnm env)"

export HOMEBREW_NO_AUTO_UPDATE=1

# Java environments https://chamikakasun.medium.com/how-to-manage-multiple-java-version-in-macos-e5421345f6d0
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export HAWAYA_MAVEN_REPOSITORY_PASSWORD=HawayaSecret12345

# npm/make/brew autocompletions are super slow. Disable them so that auto-fu's
# completion doesn't trigger for these
noopt() {}
compdef noopt npm make brew

# enable completion for these commands.
# See https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org#completing-generic-gnu-commands
# compdef _gnu_generic yarn

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ajubin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ajubin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ajubin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ajubin/google-cloud-sdk/completion.zsh.inc'; fi

# bun completions
[ -s "/Users/ajubin/.bun/_bun" ] && source "/Users/ajubin/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/ajubin/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#SPRKL
export SPRKL_PREFIX="/Users/ajubin/.sprkl"
export PATH="$PATH:$SPRKL_PREFIX/bin"

export PATH="$PATH:/Users/ajubin/Library/Python/3.8/bin"

#GO
export PATH="$PATH:$HOME/go/bin"

# Mysql client, needed for pentesting
# Copying info from brew info mysql-client
#
# ==> Caveats
# mysql-client is keg-only, which means it was not symlinked into /opt/homebrew,
# because it conflicts with mysql (which contains client libraries).
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# John the Ripper
# I build from sourcefiles
# Below doesn't work, run it directly from run directory
# export PATH="$PATH:$HOME/Documents/ajubin/hack-the-box/john/run"

# Ok, this is kind of a strange behaviour, a program set NODE_ENV variable but
# I can't identify which one. Even when starting zsh without sourcing anything or even bash
# the NODE_ENV variable is set to "production"
# To identify who called set env, we should run a command like: `sudo dtruss -f -t setenv sh` (eq to strace on unix)
# But it requires to disable SIP on the mac
# - Mac in recovery mode: holding cmd+R at startup
# - Select Terminal from utilities menu
# - csrutil disable
export HOMEBREW_GITHUB_API_TOKEN=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

# Use brew's ruby instead of the one on the system (2.6) that is deprecated
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=$(gem environment gemdir)/bin:$PATH
fi
alias wifi-sncf="sh ~/.wifi-sncf-inoui/wifi-sncf-inoui.sh"
alias wifi-sncf="sh ~/.wifi-sncf-inoui/wifi-sncf-inoui.sh"

alias kubectl="minikube kubectl --"

source ~/.minikube-completion
