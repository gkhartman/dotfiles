# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh (OMZ) installation.
export ZSH="$HOME/.oh-my-zsh"


# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify
bindkey -v
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

# End of lines added by compinstall
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="maran"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.zsh_custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# Set Golang install directory.
export GOPATH="$HOME/.local/gopath"

# Add local bin directories to PATH.
# Note: Export PATH before sourcing oh-my-zsh.sh, so
#       plugins have access to full PATH at start up.
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.pyenv/bin"
PATH="$PATH:$HOME/.local/go/bin"
PATH="$PATH:$GOPATH/bin"
export PATH

# Add local man directories to PATH.
export MANPATH="$HOME/.local/man:$MANPATH"

# Set language env.
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='vim'
fi

# Zsh plugins.
plugins=(
  docker
  colorize
  git
  man
  pip
  python
  themes
  tmux
  virtualenv
  vi-mode
)

# Load omz.
source $ZSH/oh-my-zsh.sh

# Load zsh fzf fuzzy finder (if installed).
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Function to extract many archive types.
extract () {
    if [ -f $1 ] ; then
        case $1 in 
           *.tar.bz2)   tar xvfj $1    ;;
           *.tar.gz)    tar xvfz $1    ;;
           *.tar.xz)    tar xvfJ $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *.jar)       jar xf $1      ;;
           *)  echo 'Error: function extract defined in ".zshrc" does not recognise the archive: "$1"...' ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

# Show unix os info.
lsunix () {
    # Print full uname (POSIX) standard.
    echo "Unix name (uname -a): "
    uname -a
    echo " "
    
    # Print hostnamectl status if found.
    if [ -x "$(command -v hostnamectl)" ]; then
        echo "Hostname info (hostnamectl status):"
        hostnamectl status
        echo " "
    fi

    # Check common platform enumeration file for RHEL/Centos/Fedora.
    rhel_release_file_path="/etc/system-release-cpe"
    if [ -f "$rhel_release_file_path" ]; then
        echo "Redhat common platform enumeration file info "$rhel_release_file_path":"
        cat "$rhel_release_file_path"
    fi
}

# Function that counts lines of code in .cc and .h files.
count_lines_cpp () {
    find . -type f \( -name \*.cpp -o -name \*.cc -o -name \*.hpp -o -name \*.h \) ! -name pugixml.cpp -exec wc -l {} +
}

# Get zulu time string.
ztime () {
    date --utc +%Y-%m-%dT%TZ
}

# Get last modified dir.
#lm () {
#    ls -td $1/* | head -n 1
#}

# Format json file in place.
inplace_format () {
    jq -M . "$1" > "$1.tmp" && mv "$1.tmp" "$1"
}

# Recursively find the last modified file in a dir.
lastmod() {
    # find $1 -type f -exec stat --format '%Y :%y %n' "{}" \; | sort -nr | cut -d: -f2- | head
    find $1 -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -nr | cut -d: -f2- | head
}

######################## ALIASES ###########################
alias grep='grep --line-number --color=auto'
alias rgrep='grep --line-number --color=auto -R'
alias psu="ps -v -U $USER"

# List working directory (ls) conents shortcuts.
# ls options:
#   F = show '/' after directories
#   a = show all (shows hard/soft links and hidden files)
#   l = long list (one file/directory per line)
alias ls='ls --color=always'
alias ll='ls -lhF'            # Long list.
alias la='ls -ahF'            # List w/ all info.
alias lla='ls -lahF'          # Long list w/ all info.
alias lt='ls -ltF'            # Time sorted long list.

# Remove files (rm) or directories (rmr).
alias rm='rm -i' # Remove but ask always ask first
alias rmr='rm -ir' # Remove recursive

# Valgrind common command shortcuts.
alias memgrind='valgrind -v --leak-check=full --show-possibly-lost=yes --undef-value-errors=no'
alias valgrind='valgrind -v --leak-check=full --show-possibly-lost=yes --undef-value-errors=yes'
alias callgrind='valgrind --tool=callgrind'

# Nvim swap management.
alias ls_swap="ls -la $HOME/.local/share/nvim/swap"
alias clean_swap="rm -f $HOME/.local/share/nvim/swap/*.swp"

# JSON linter (python required).
alias jsonf="$PYTHON -m json.tool"

# Get list of all users.
alias lsgroups='cut -d: -f1 /etc/group | sort'

# List all users on the system.
alias lsusers='cut -d: -f1 /etc/passwd | sort'
alias dc='docker-compose'

# Upgrade all pip packages.
#alias pipup="pip list --outdated --format=freeze | /bin/grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"

# Show outdated pip packages.
alias pipcheckup='pip list --outdated --format=freeze'
#################### END OF ALIASES #######################

# Source host specific .zshrc file if found.
[ -f ~/.zshrc.local ] && source $HOME/.zshrc.local

# END .zshrc
