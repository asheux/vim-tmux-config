# Home directory
export HOME_PATH=$HOME

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export LAMBDA_MOD_N_DIR_LEVELS=10
export ZSH="$HOME_PATH/.oh-my-zsh"
export TERM="xterm-256color"
export PYTHONPATH="$PYTHONPATH:$HOME_PATH/Projects/Mywork/python"

# MacPorts
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

# Proxy Server
export http_proxy=http://localhost:8118

# Manually set language environments
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# this specifies how fzf builds list of files
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
. "$HOME/.cargo/env"

# Set python startup to the environment variables
export PYTHONSTARTUP="$HOME_PATH/.pythonstartup"

# Anaconda config
export PATH="$HOME_PATH/anaconda3/bin:$PATH"

# Add python to path
# export PATH="$PATH:/usr/lib/python3.8"

eval $(thefuck --alias fuck)

ZSH_THEME="dieter"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git
)

source $ZSH/oh-my-zsh.sh

# Go set up
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin

# export MANPATH="/usr/local/man:$MANPATH"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Anaconda
alias actconda="source /opt/anaconda/bin/activate root"
# alias actconda="conda activate"
alias deconda="source /opt/anaconda/bin/deactivate root"
# alias deconda="conda deactivate"

# Start postgresql
alias psql-start="pg_ctl -D /usr/local/var/postgres start"
alias psql-restart="pg_ctl -D /usr/local/var/postgres restart"
alias psql-stop="pg_ctl -D /usr/local/var/postgres stop"

# In arch linux
alias startme="sudo systemctl start postgresql"
alias stopme="sudo systemctl stop postgresql"
alias restartme="sudo systemctl restart postgresql"
alias checkme="sudo systemctl status postgresql"

# switch git config
alias ashhub="git config --global user.name asheux && git config --global user.email brian.mboya@protonmail.com"
alias syhub="git config --global user.name sycyi && git config --global user.email sycyi@protonmail.com"
alias ashlab="git config --global user.name asheux && git config --global user.email brianashiundu000@gmail.com"
alias gcheck="git config --list"

# Switch to postgres shell
alias psw="sudo -iu"

# Create virtual environment
alias create-venv="python -m venv venv"

alias python=python3
alias pip=pip3
alias src-venv="source venv/bin/activate"
alias opencv="pkg-config --cflags --libs /usr/local/Cellar/opencv/4.1.1_2/lib/pkgconfig/opencv4.pc"
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias net="netstat | fzf"

# Go commands
alias gb="go build"
alias gm="go mod init"

# Vim commands
alias viminstall="vim +PlugInstall +qall"
alias vimupdate="vim +PlugUpdate +qall"
alias vimclean="vim +PlugClean"

# bat
alias ll="ls | bat"
alias tree="tree | bat"
alias gitdiff="git diff --name-only --diff-filter=d | xargs bat --diff"

# Open vim and save the current base directory.
# This is for fxf customized :Files command for preview window
# to always use this directory as the base dir
# You must create $HOME/cronjobs/base_dir.zh as executable
# with contents "cat $HOME/cronjobs/dir.txt" for this to work
function ovim() {
    mkdir -p $HOME/Projects/Configs/vim-tmux-config/cronjobs &&
        echo "$(pwd)" > $HOME/Projects/Configs/vim-tmux-config/cronjobs/dir.txt && vim
}

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME_PATH/.local/bin:$PATH"

export PATH="/usr/local/opt/qt/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/qt/lib"
export CPPFLAGS="-I/usr/local/opt/qt/include"

eval "$(hub alias -s)"
