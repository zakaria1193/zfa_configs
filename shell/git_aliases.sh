alias gmaster='git checkout master'

alias gupstream='git rev-parse --abbrev-ref --symbolic-full-name @{u}'
alias gcurrentbranch='git rev-parse --abbrev-ref HEAD'

function git_find_and_replace_in_branch()
{
  from="$1"
  to="$2"
  root_branch="$3"
  if [ -z $root_branch ]
  then
    root_branch='master'
  fi

  command="git grep -l $from | xargs -r sed -i s/$from/$to/g"

  git rebase -i --exec "$command" "$root_branch"
}

root='git merge-base master HEAD'

alias gs='git status'
alias gck='git checkout'
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' -13 --abbrev-commit" # shows 13 lines
alias gllong="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # show max lines
alias glverb="git log --stat --graph --date=local --pretty=format:'%C(yellow)%h%Cblue %ad%Cgreen %an %Cred%d%n%Creset%x09%s%n'"
alias glfind="git log --color --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -5 --grep"
alias grl="git reflog --format='%C(auto)%h %<|(20)%gd %C(blue)%cr%C(reset) %gs (%s)'"
alias gamend='git commit --amend --no-edit'
alias gamendmsg='git commit --amend'
alias gcom='git commit -m'
alias g-hard='git reset --hard'
alias g-hard^='git reset --hard HEAD^'
alias gfixup='git commit --fixup'
alias gap='git add -p'
alias gA='git add -A'
alias grp='git reset -p'
alias gr='git reset'
alias gr^='git reset HEAD^'
alias grp^='git reset -p HEAD^'
alias gcf='git clean -fd'
alias gcu='git checkout -- .' # clean unstaged

alias gpush="git push origin"
alias gpushf="gpush -f"
alias gpushskip="gskipci && gpush"
alias gsub='git submodule update --init --recursive'
alias gsubfix='git submodule deinit -f --all && gsub'
alias gpullm='gmaster && git pull --prune && gsub && git checkout -'
alias gpull='git pull --prune origin $(gcurrentbranch)' #pulls current branch
alias gf='git fetch --prune'

alias grebi='git rebase -i --keep-empty'
alias grebim='git rebase -i --keep-empty master && gsub'
alias grebm='git rebase --keep-empty master && gsub'
alias gautofixup-on-master='git-autofixup master && grebim'
alias gautofixup='git-autofixup'

alias gc='git rebase --continue'
alias gsk='git rebase --skip'
alias ga='git rebase --abort'

alias gst='git stash'
alias gstap='git stash apply'
alias gstsh='git stash show -v'

#       Chery picks         #
alias gch='git cherry-pick'
alias gchc='git cherry-pick --continue'
alias gcha='git cherry-pick --abort'

alias gsh='git show'

alias gd='git diff'
alias gds='git diff --staged'
#       Bitcloud - branches Specific      #
alias grelay='git checkout zfa/relay_driver && gsub'
alias gnlfs='git checkout zfa/drop-sync-stab && gsub'

alias gskipci='git commit --allow-empty -m "[skip ci]"'

grep_blame() {
    git grep -n $1 | while IFS=: read i j k; do git blame -L $j,$j $i | grep $1; done;
}