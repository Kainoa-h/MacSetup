function instagit() {
    git add .
    git commit -a -m "$1"
    git push
}
alias gg="git log --oneline --graph --color --all --decorate"
alias gms="git merge --squash"
alias glog="git log --name-status"
alias gi="cp $HOME/.config/templateGitIgnore.txt ./.gitignore"
alias gst="git status"
alias gca="git commit -all"
alias gcam="git commit -all --message"
alias gb="git branch --all"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gd="git diff"
alias gl="git pull"
alias glr="git pull --rebase"
alias gp="git push"
alias gpf="git push --force-with-lease --force-if-includes"
