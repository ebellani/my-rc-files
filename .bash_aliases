#
#enable vim support in bash
# found it here http://www.themomorohoax.com/2009/02/09/vim-folks-use-bashs-vim-mode
set -o vi 

# increase bash_history size
HISTSIZE=1000000 

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls -lh --color=auto'
    alias dir='ls -h --color=auto --format=vertical'
    alias vdir='ls -h --color=auto --format=long'
    alias la='ls -lA'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#enable bash completion of rake tasks
complete -C ~/Sources/Scripts/rake_completion -o default rake


###########################
## New ones from me and merged with some from Zeke's bash file
###########################

# Remove ~ files
alias rm~="find . -iname '*~' | sed -e 's/ /\\ /g' | xargs rm"

# Getting around to some dirs
alias ..='cd ..'

# Ruby/Rails
alias c='script/console'
alias s='script/server &'
# Stop ruby
alias sr='killall -s9 ruby'
alias s2='script/server -p3010 &'
alias irb='irb --readline -r irb/completion'  
alias gemlist='gem list | egrep -v "^( |$)"'
#alias gs="gem server & sleep 1; open 'http://localhost:8808'" # conflict with Git Status
alias pdoc="open -a Firefox ./doc/plugins/"
alias rdbm="rake db:migrate"
alias rdbb="rake db:bootstrap"
alias rdbreset="rake db:migrate VERSION=0 && rake db:migrate VERSION=0 RAILS_ENV=test && rake db:migrate && rake db:migrate RAILS_ENV=test"

# RSpec & testing
#alias spec='rake spec'
alias spec='./script/spec'

# specm <model_name>
function specm {
  spec ./spec/models/$1_spec.rb
}
# specc <controller_name>
function specc {
  spec ./spec/controllers/$1_controller_spec.rb
}

# Mysql, place here your frequent projects
#alias myfam='mysql -u root cdms_development'

# SVN
alias up='svn up'
alias ci='svn ci'
alias st='svn st'

# Git
alias pull='git pull'
alias push='git push'
alias gb='git branch -a -v'
alias gs='git status'
alias gd='git diff'
# gc message  => git commit -a -m "Message"
function gc {
  git commit -a -m $1
}
# gcp message  => git commit -a -m "Message" ; git push
function gcp {
  git commit -a -m $1; git push
}

# What is my ip?
alias myip='curl "http://www.networksecuritytoolkit.org/nst/cgi-bin/ip.cgi"'

# Build pdflatex project, including new bibtex entries
function lt {
    pdflatex -interaction batchmode $1; pdflatex -interaction batchmode $1; bibtex $1.aux; pdflatex -interaction batchmode $1; pdflatex -interaction batchmode $1; evince $1.pdf & 
    rm *.aux; rm *.bbl; rm *.blg; rm *.out
    clear
}

#same as above, but faster, for something that does not need a bibtex update
function lt-fast {
    pdflatex -interaction batchmode $1; evince $1.pdf & 
    rm *.aux; rm *.bbl; rm *.blg; rm *.out
    clear
}


function stream_save {
    mplayer -dumpstream -dumpfile $1.wmv $2
}

#latex2html to not split the document in several parts
#see http://www.uwo.ca/its/doc/hdi/web/w3-latex2html.html
alias latex2html='latex2html -split 0'

#nice prompts. Taken from 
#http://maketecheasier.com/8-useful-and-interesting-bash-prompts/2009/09/04
PS1="(\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\[\e[32;1m\]\w\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\])--> \[\e[0m\]"

# run ssh-agent when bash starts
# taken from
# http://help.github.com/working-with-key-passphrases/
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
# automatically start agent
if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  #ps ${SSH_AGENT_PID} doesn't work under cywgin
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi


