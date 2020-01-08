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
alias gcomdate="git commit -m \'Updated: \`date +\'%Y-%m-%d %H:%M:%S\'\`"
alias g-hard='git reset --hard'
alias g-hard~='git reset --hard HEAD~'
alias gfixup='git commit --fixup'
alias gap='git add -p'
alias gA='git add -A'
alias grp='git reset -p'
alias gr='git reset'
alias gr^='git reset HEAD^'
alias grp^='git reset -p HEAD^'
alias gcf='git clean -fd -f'
alias gcu='git checkout -- .' # clean unstaged

alias gdelete_merged='git branch --merged| egrep -v "(^\*|master)" | xargs --interactive git branch -d'
alias gdelete_merged_remote="git branch -r --merged | grep zfa | sed '/>|master/d;/origin/!d;s:origin/::' | xargs --interactive git push origin --delete"

alias gpush="git push origin"
alias gpushf="gpush -f"
alias gpushskip="gskipci && gpush"
alias gsub='git submodule update --init --recursive'
alias gsubcf='git submodule foreach git clean -fd -f'
alias gsubfix='git submodule deinit -f --all && gsub'
alias gpullm='gmaster && git pull --prune && gsub && git checkout -'
alias gpull='git pull --prune origin $(gcurrentbranch)' #pulls current branch
alias gf='git fetch --prune --all --tags --force'

alias grebi='git rebase -i  --autosquash --keep-empty'
alias grebim='git rebase -i --autosquash  --keep-empty master && gsub'
alias grebm='git rebase --autosquash  --keep-empty master && gsub'
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
alias gdo='git diff $(gcurrentbranch)'

alias gskipci='git commit --allow-empty -m "[skip ci]"'

grep_blame()
{
    git grep -n $1 | while IFS=: read i j k; do git blame -L $j,$j $i | grep $1; done;
}

alias gbfg="java -jar $ZFA_CONFIGS_TOOLS/bfg-1.13.0.jar"
git_purge_file_from_repo()
{
  target_file=$1
  target_repo=$2
  git rm --cached $target_file -rf
  if [ -d "$target_file" ]; then
    gbfg --no-blob-protection --delete-folders $target_file $target_repo
  else
    gbfg --no-blob-protection --delete-files   $target_file $target_repo
  fi
  git reflog expire --expire=now --all && git gc --prune=now --aggressive
  echo -e "\e[31;47m you might need to 'git push -f origin' \e[m"
}

alias gita='python3 -m gita'
alias gita-super-fetch='gita super fetch'

alias tig='tig --submodule=diff'

# bring given branch tag to HEAD
function gbf
{
  git branch -f $1 HEAD
  git checkout $1
}

# resets current branch to it's origin
function gro
{
  git reset --hard origin/$(gcurrentbranch)
}


function tsrc_inhale
{
  [[ -z $1 ]] && echo give worktree && return

  for workdir in "$@"
  do
  $ZFA_CONFIGS/git/tsrc_manifest_writer.py -i -r $workdir -o $ZFA_WORK_TOOLS/git

  manifest=$ZFA_WORK_TOOLS/git/$(basename $workdir)/manifest.yml
  echo $manifest
  tsrc init --file $manifest
  done
}

alias t='tsrc'

function tscr_pull_cfg
{
  local group=''
  [[ -z $1 ]] && echo give worktree && return
  workdir=$1
  [[ ! -z $2 ]] && group="-g $2"
  $ZFA_CONFIGS/git/tsrc_manifest_writer.py -r $workdir -o $ZFA_WORK_TOOLS/git

  # for some reason groups arent found when tsrc run directlys
  manifest=$ZFA_WORK_TOOLS/git/$(basename $workdir)/manifest.yml
  eval "tsrc init -w $HOME --file $manifest $group"
}

alias t_work_init="tscr_pull_cfg $REPOS"
alias t_perso_init="tscr_pull_cfg $MY_REPOS"
alias t_perso_perso_init="tscr_pull_cfg $MY_REPOS perso"

function t_push_perso_perso
{
  t_perso_perso_init
  tsrc foreach -- git add -A && git commit -m "$(date)" && git push
}
