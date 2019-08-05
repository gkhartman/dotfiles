# Garret Hartman's .bashrc
# Machine: Oxide (ThinkPad T460s)
# Last updated: 5-3-18

# Set vim keybinding on
set -o vi
set editing-mode vi
set keymap vi-command

# Local directory path
LOCAL_DIR=$HOME/.local

# C compiler env vars
export LD_LIBRARY_PATH=/lib64:/usr/lib:/usr/local/lib:/usr/lib/x86_64-linux-gnu

# Local bin directory
export PATH=$PATH:$LOCAL_DIR/bin

# Set editor var for svn and git commits
export EDITOR=vim

# Wine prefix directory
export WINEPREFIX=~/.wine

# Set bash prompt formatting variable: PS1
#   Special characters:
#       '\u' := Username
#       '\h' := Hostname
#       '\w  := Full path of current working directory 
#       '\W  := Basename of current working directory
#       '\!' := History number of command
#       '\[\033[<color_number>m\]'
user_str="\[\e[0;31;1m\]\u"
host_short_str="\[\e[0;34m\]\h"
base_wd_str="\[\e[0m\]\W"
at_char="\[\e[m\]@"
colon_char="\[\e[0m\]:"
end_char=$'\[\e[0;31;1m\]\xE2\x88\xAE'
end_space="\[\e[0m\] "
PS1="${user_str}${at_char}${host_short_str}${colon_char}${base_wd_str}${end_char}${end_space}"

# Function to extract many archive types
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
           *.xz)        xz -dk -T0 $1  ;;
           *)  echo 'Error: function extract defined in ".bashrc" does not recognise the archive: "$1"...' ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

# Function that counts lines of code in .cc and .h files
count_lines_cpp () {
    find . -type f \( -name \*.cpp -o -name \*.cc -o -name \*.hpp -o -name \*.h \) ! -name pugixml.cpp -exec wc -l {} +
}

######################## ALIASES ###########################
alias vi='vim'
alias grep='grep --line-number --color=auto'
alias ls='ls --color=always'

# List working directory (ls) conents shortcuts
# ls options:
#   F = show '/' after directories
#   a = show all (shows hard/soft links and hidden files)
#   l = long list (one file/directory per line)
alias ll='ls -lhF'   #list long
alias la='ls -ahF'   #list all
alias lla='ls -lahF'  #list all as long list

# Remove files (rm) or directories (rmr)
alias rm='rm -i' #remove but ask always ask first

# Jump directory shortcuts
alias ~='cd $HOME' #goto home directory
alias ~workspace='cd $HOME/workspace/' #goto development workspace directory

# Valgrind shortcuts
alias memgrind='valgrind -v --leak-check=full --show-possibly-lost=yes --undef-value-errors=no'
alias valgrind='valgrind -v --leak-check=full --show-possibly-lost=yes --undef-value-errors=yes'
alias callgrind='valgrind --tool=callgrind'
#################### END OF ALIASES #######################

