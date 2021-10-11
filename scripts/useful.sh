# Chechout a git branch
fbr(){
 gwip
 git --no-pager branch --format='%(refname:short)' | fzf |  awk '{print $1}' | xargs -J {} git checkout {}
 gunwip

}
# Delete local git branches (multiselect possible)
fdbr(){
 git --no-pager branch --format='%(refname:short)' | fzf -m | awk '{print $1}' | xargs -J {} git branch -D {}
}

# browse chrome history
chromeHistory(){
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}

# Execute local scripts
yarns(){
 cat package.json | jq -r '.scripts' | sed -e 's/  "\(.*\)":\s*\(.*\)$/\1|\2/' | sed -e '1d;$d' | column -t -c 2 -s '|' | fzf --reverse -n 1 --height=80%| awk '{print $1}' | xargs yarn
}

fjest(){
  find . -path './src/**/*.test.js' | fzf | xargs yarn jest
}


# Create new up to date branch
gnb() {
  git co staging
  git pull
  gbda
  git co -b $1
}

unalias gbda
alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev|staging)\s*$)" | command xargs -n 1 git branch -d'

# TODO: not working
# Get number of lines and total size of snapshots of dir
snap() {
  # diskSize=`find $1/**/*.snap -type f -exec du -ch {} + | grep total$ | awk '{print $1}'`
  echo $(find $PWD/src/**/*.snap -type f)
  echo `wc -l \`find $PWD/src/**/*.snap -type f\` | grep total$ | awk '{print $1}'`
  echo "number of lines: $numberOfLine" 
  echo "diskSize : $diskSize" 
}

c() {
  code $PWD
}

searchgit() {
  STRING_TO_SEARCH=$1
  shift;

  git log -S"$STRING_TO_SEARCH" --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --reverse --tiebreak=index \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
                FZF-EOF
              "
}

biggestFiles() {
  find $1/** -type f -name '*.ts*' -not -name '*.test.ts*' -exec wc -l {} + | sort -rn | head -n 10
}


cleanupGit() {
  # https://devconnected.com/how-to-clean-up-git-branches/#Clean_Up_Local_Git_Branches
  ​
  git fetch --quiet --prune
  ​
  git checkout --quiet master
  ​
  # Make sure git status and others stay fast
  git prune
  git gc
  ​
  # Delete fully merged branches
  git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
  ​
  # Delete squash-and-merged branches
  # https://github.com/not-an-aardvark/git-delete-squashed
  git for-each-ref refs/heads/ "--format=%(refname:short)" |
  while read branch; do
    mergeBase=$(git merge-base master $branch) &&
    [[ $(git cherry master $(git commit-tree $(git rev-parse $branch\^{tree}) -p $mergeBase -m _)) == "-"* ]] &&
    git branch -D $branch
  done
  ​
  # Delete branches that were deleted on origin
  git branch -vv | grep 'origin/.*: disparue]' | awk '{print $1}' | xargs git branch -D
  ​
  echo "🗑  Deleted outdated branches. To recover one of the deleted branches do this:
        git reflog | grep <commit-hash>
        git checkout -b <new-branch-name> HEAD@{X} # with X whatever the reflog output indicates
  "
}
