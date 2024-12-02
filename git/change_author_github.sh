WRONG_EMAIL=zakaria.fadli@legrand.com
RIGHT_USERNAME=zakaria1193
RIGHT_EMAIL=zakaria1193@gmail.com

git filter-branch --commit-filter '
        if [ "$GIT_AUTHOR_EMAIL" = "WRONG_EMAIL" ];
        then
                GIT_AUTHOR_NAME="RIGHT_USERNAME";
                GIT_AUTHOR_EMAIL="RIGHT_EMAIL";
                git commit-tree "$@";
        else
                git commit-tree "$@";
        fi' HEAD
