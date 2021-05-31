#if [ -n "`synclient -l 2> /dev/null`" ] ; then 
#    synclient VertEdgeScroll=0 HorizEdgeScroll=0 VertTwoFingerScroll=1 HorizTwoFingerScroll=1 TapAndDragGesture=0 TapButton1=0 TapButton2=0 TapButton3=0 EmulateTwoFingerMinW=15
#fi

if [ "${OSTYPE:0:6}" == "darwin" ] ; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    alias find='/usr/local/bin/gfind'
    alias xargs='/usr/local/bin/gxargs'
    export LS_COLORS='rs=0:di=00;34:ln=00;36:mh=00:pi=40;33:so=00;35:do=00;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=00;32:*.tar=00;31:*.tgz=00;31:*.arc=00;31:*.arj=00;31:*.taz=00;31:*.lha=00;31:*.lz4=00;31:*.lzh=00;31:*.lzma=00;31:*.tlz=00;31:*.txz=00;31:*.tzo=00;31:*.t7z=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.dz=00;31:*.gz=00;31:*.lrz=00;31:*.lz=00;31:*.lzo=00;31:*.xz=00;31:*.bz2=00;31:*.bz=00;31:*.tbz=00;31:*.tbz2=00;31:*.tz=00;31:*.deb=00;31:*.rpm=00;31:*.jar=00;31:*.war=00;31:*.ear=00;31:*.sar=00;31:*.rar=00;31:*.alz=00;31:*.ace=00;31:*.zoo=00;31:*.cpio=00;31:*.7z=00;31:*.rz=00;31:*.cab=00;31:*.jpg=00;35:*.jpeg=00;35:*.gif=00;35:*.bmp=00;35:*.pbm=00;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=00;35:*.svg=00;35:*.svgz=00;35:*.mng=00;35:*.pcx=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.m2v=00;35:*.mkv=00;35:*.webm=00;35:*.ogm=00;35:*.mp4=00;35:*.m4v=00;35:*.mp4v=00;35:*.vob=00;35:*.qt=00;35:*.nuv=00;35:*.wmv=00;35:*.asf=00;35:*.rm=00;35:*.rmvb=00;35:*.flc=00;35:*.avi=00;35:*.fli=00;35:*.flv=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.yuv=00;35:*.cgm=00;35:*.emf=00;35:*.axv=00;35:*.anx=00;35:*.ogv=00;35:*.ogx=00;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
    alias ls='ls --color=auto'
    alias chrome="/usr/bin/open -a '/Applications/Google Chrome.app'"
else
    alias psa='ps auxf | less -Si'
    export PATH=$PATH:/usr/local/go/bin
fi

# Attribute codes:
# 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# Text color codes:
# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Background color codes:
# 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
g='\[\033[00;32m\]'
b='\[\033[00;34m\]'
m='\[\033[00;35m\]'
n='\[\033[00m\]'
PS1="\D{%Y-%m-%d %H:%M:%S} $g\u$b@$m\h $b\w $g\$$n "
# If this is an xterm make the tab title the working directory.
case "$TERM" in
xterm*|rxvt*)
    # The \a is critical
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\w\a\]$PS1"
    ;;
*)
    ;;
esac

export EDITOR=vim
export PATH=$HOME/bin:$PATH
export GOPATH=$HOME/dev/go
export PATH=$GOPATH/bin:$PATH

set -o vi
shopt -s histappend cmdhist globstar
HISTCONTROL=ignorespace
HISTFILESIZE=10000
HISTSIZE=500
HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S    "

alias ta='tmux attach'
alias ds='dropbox status'
# alias gnon='sudo mtpfs -o allow_other /media/GalaxyNexus/'
# alias gnoff='sudo umount /media/GalaxyNexus'

alias sr='svn diff -x -w > diff.txt && vi diff.txt commit.txt'

alias gst='git status'
alias grv='git remote -v'
# alias gd='git diff --color'
# alias gdc='git diff --color --cached'
alias gb='git branch'
alias gco='git checkout'
alias gsl='git stash list'
alias gup='git pull --rebase'
function gd { git diff -b --color $* | less -R; }
function gdc { git diff -b --cached --color $* | less -R; }
function gl { git log --name-status --color $* | less -R; }
alias gr='git diff --cached -w > .diff && vi .diff .commit'
function gg { git log --graph --format=format:"%h %d %s [%cn]" --color --full-history --sparse $* | less -RSi; }
alias gga='git log --graph --format=format:"%h %d %s [%cn]" --all --color --full-history --sparse | lss -R'

function gsp { if [[ -z "$1" ]] ; then echo "gsp <stash id>"; else git stash pop stash@{$1} ; fi ; }
function gsa { if [[ -z "$1" ]] ; then echo "gsa <stash id>"; else git stash apply stash@{$1} ; fi ; }
function gss { if [[ -z "$1" ]] ; then echo "gss <stash id>"; else git stash show -p stash@{$1} --color | less -R ; fi ; }

alias vi=vim
alias vip='ps aux | grep "\bvim\?\b"'
alias hl='history | less +G'
alias hs='history >> $HOME/history.log'
alias lsh='ls -lt | head'
alias lss='less -Si'
alias lsg='less -Si +G'
alias db='psql -U postgres -W -h localhost checkbox'
function whois { /usr/bin/whois $* | less ; }

alias ..='cd ..'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'
alias ..7='cd ../../../../../../../..'
alias ..8='cd ../../../../../../../../..'
alias ..9='cd ../../../../../../../../../..'

# find+grep
function fing {
    local grepOpts=""
    if [[ "$1" =~ ^- ]] ; then
        grepOpts="$1"
        shift
    fi
    exp=${@: -1:1} # substring expansion - last element of @
    find_opts='! -path *\/.svn\/* ! -path *\/.git\/* -print0'
    if [[ $# > 1 ]] ; then
        name=${@: -2:1}
        if [[ $# > 2 ]] ; then
            dirs="${@:1:$#-2}"
            find $dirs -name "$name" -type f $find_opts | xargs -0 grep $grepOpts "$exp" 
        else
            find -name "$name" -type f $find_opts | xargs -0 grep $grepOpts "$exp" 
        fi
    else
        find -type f $find_opts | xargs -0 grep $grepOpts "$exp" 
    fi
}

function txt2pdf {
    font_sz=${1#-s}
    if [ "$font_sz" != "$1" ] ; then
        # the first param is a font size spec; skip it
        shift
    else
        font_sz=8
    fi
    while [[ -n "$1" && -f "$1" ]] ; do
        txtfile=$1
        line_count=`wc -l $txtfile | cut -d ' ' -f 1`
        basefile="${1%.txt}"
        pdffile="${basefile}.pdf"
        # OPTS='--margins=36:36:48:36 --word-wrap'
        # OPTS='--margins=0:0:0:24 --word-wrap';
        OPTS='--margins=24:24:24:24 --word-wrap';
        if (( $line_count > 75 )) ; then
            OPTS="-2 -r $OPTS"
        fi
        FONT="NewCenturySchlbk-Roman$font_sz"
        enscript $OPTS -o $basefile.ps -f $FONT -F $FONT $txtfile && ps2pdf $basefile.ps && rm $basefile.ps
        shift
    done
}

# Set up ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initializing new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# Battery status
function bs {
    upower --dump | grep "time to \(empty\|full\):\|percentage:\|on-battery:"
}

# Mail a memo to my work address
function mm {
    if [ -z "$1" ] ; then
        echo "Usage: mm <subject>"
    else
        # create this file with: echo 'passphrase' | gpg -e -r 'Colin MacDonald <colin@bluegraybox.com>' -a
        pass=`cat $HOME/dotfiles/pwd-email.gpg | gpg -d`
        echo "Subject: $1"
        echo "Message body:"
        local addr='colin@bluegraybox.com'
        env MAILRC=/dev/null from=$addr smtp=smtps://mail.bluegraybox.com ssl-verify=ignore smtp-auth-user=$addr smtp-auth-password="$pass" smtp-auth=login mailx -n -s "$1" colin.macdonald@capitalone.com
    fi
}

# Lynx Google
function lg {
    if [ -z "$1" ] ; then
        echo "Usage: lg <search terms>"
        exit 1
    fi
    # echo "Googling for $*"
    # sleep 1
    lynx -cookies "http://www.google.com/search?q=$*"
}

# Lynx Wikipedia
function lw {
    if [ -z "$1" ] ; then
        echo "Usage: lw <search terms>"
        exit 1
    fi
    # echo "Searching Wikipedia for $*"
    # sleep 1
    lynx -cookies "https://en.wikipedia.org/w/index.php?search=$*&title=Special%3ASearch&fulltext=Search"
}

# Start Hugo server, capture URL, open in browser
function hugosrv {
    hugo serve -D | while read line ; do
        url_prefix="Web Server is available at " 
        echo "$line"
        if [[ "${line:0:27}" == "$url_prefix" ]] ; then
            url=${line#$url_prefix}
            url=${url%% *}
            open "$url"
        fi
    done
}
