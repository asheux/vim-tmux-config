# Home directory
export HOME_PATH=$HOME

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export LAMBDA_MOD_N_DIR_LEVELS=10
export ZSH="$HOME_PATH/.oh-my-zsh"
export TERM="xterm-256color"

# Manually set language environments
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# this specifies how fzf builds list of files
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set python startup to the environment variables
export PYTHONSTARTUP="$HOME_PATH/.pythonstartup"

# Anaconda config
export PATH="$HOME_PATH/anaconda3/bin:$PATH"

# Add python to path
export PATH="$PATH:/usr/lib/python3.8"

eval $(thefuck --alias fuck)

ZSH_THEME="flazz"

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

# Switch to postgres shell
alias psw="sudo -iu"

# Create virtual environment
alias create-venv="python -m venv venv"

# alias python=python
# alias pip=pip3
alias src-venv="source venv/bin/activate"
alias opencv="pkg-config --cflags --libs /usr/local/Cellar/opencv/4.1.1_2/lib/pkgconfig/opencv4.pc"
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias net="netstat | fzf"

# Go commands
alias gb="go build"
alias gm="go mod init"

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME_PATH/.local/bin:$PATH"

export PATH="/usr/local/opt/qt/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/qt/lib"
export CPPFLAGS="-I/usr/local/opt/qt/include"

eval "$(hub alias -s)"
