
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

function refresh_main
{
  main=$(git branch -l master main | sed 's/^* //')
  master=$(git branch -l master main | sed 's/^* //')
  # Resource this file to adapt the aliases
  source "$ZFA_GIT_ALIASES"
}

alias rfm='refresh_main'

alias gs='git status'
alias gck='git checkout'
alias gckhead='git checkout $(git name-rev HEAD --name-only | fzf -m --height=40% --reverse)'
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' -13 --abbrev-commit" # shows 13 lines
alias gllong="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # show max lines
alias glverb="git log --stat --graph --date=local --pretty=format:'%C(yellow)%h%Cblue %ad%Cgreen %an %Cred%d%n%Creset%x09%s%n'"
alias glfind="git log --color --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -5 --grep"
alias grl="git reflog --format='%C(auto)%h %<|(20)%gd %C(blue)%cr%C(reset) %gs (%s)'"
alias tigrl='bash -c "git reflog --pretty=raw | tig --pretty=raw"'
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

alias gdelete_merged_remote="git branch -r --merged | grep zfa | sed '/>|master/d;/origin/!d;s:origin/::' | xargs --interactive git push origin --delete"

alias gpush="git push origin"
alias gpushf="gpush -f"
alias gsub='git submodule update --init --no-fetch'
alias gsubdeinit='git submodule deinit --all -f'
alias gsubcf='git submodule foreach git clean -fd -f'
alias gsubfix='gsubdeinit && gsub'
alias gm="refresh_main; git checkout master"
alias gpullm='gck master && git pull --prune && git checkout -'
alias gpull='git pull --prune origin $(gcurrentbranch)' #pulls current branch
alias gpullall='git pull --prune origin --all' #pulls current branch
alias gf='git fetch --prune --all --tags --force'

alias grebi='git rebase -i  --autosquash --keep-empty'
alias grebim="refresh_main; git rebase -i --autosquash  --keep-empty master"
alias grebm="refresh_main; git rebase --autosquash  --keep-empty master"
alias gautofixup-on-master="refresh_main; git-autofixup master && grebim"
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
alias gdo='git diff origin/$(gcurrentbranch) $(gcurrentbranch)'
alias gdsub='git diff --submodule=diff'

function gskipci
{
  if [[ -n $(git log --oneline -1 | grep '[skip ci]') ]]
  then
    echo "skip ci commit exists"; return
  else
    git commit --allow-empty -m "[skip ci]"
  fi
}

alias gpushskip="gskipci && gpush"

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

function g_cd_submodule_parent
{
  parent=$(git rev-parse --show-superproject-working-tree)
  [[ -n $parent ]] && cd $parent; return
}

function g_release_contains_commit
{
  product=$2
  commit=$1
  git tag --contains $commit | grep $product
}


function g_release_contains_merge_request
{
  echo "merge request should be in this format 'magellan!233'"
  echo "if no filtering by product wanted give '.'"
  MR="$1"
  product=$2

  #debug // list of merge requests found
  #git log --grep="$MR"

  merge_commits=($(git log --grep="$MR" --format='%H'))
  for i in $merge_commits
  do
    echo treating merge commit $i
    git show -q $i
    g_release_contains_commit $i $product
  done
}

function tsrc_inhale
{
  [[ -z $1 ]] && echo give worktree && return

  for workdir in "$@"
  do
  $ZFA_CONFIGS/git/tsrc_manifest_writer.py -r $workdir -o $ZFA_WORK_TOOLS/git

  manifest=$ZFA_WORK_TOOLS/git/$(basename $workdir)/manifest.yml
  done

  echo "you'll need to commit on $ZFA_WORK_TOOLS"
}

alias t='tsrc'

function tscr_pull_cfg
{
  local group=''
  [[ -z $1 ]] && echo give worktree && return
  workdir=$1
  [[ ! -z $2 ]] && group="-g $2"

  # for some reason groups arent found when tsrc run directlys
  manifest=$ZFA_WORK_TOOLS/git/$(basename $workdir)/manifest.yml
  eval "tsrc init -w $HOME --file $manifest $group"
}

alias t_work_init="tscr_pull_cfg $REPOS"
alias t_perso_init="tscr_pull_cfg $MY_REPOS"
alias t_perso_perso_init="tscr_pull_cfg $MY_REPOS perso"


