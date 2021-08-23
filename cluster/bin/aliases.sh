# Aliases

echo "Setting ClusterColombia local vm handling aliases ... \n"

alias cs="bin/status.sh"

alias cmu="bin/cm.sh up"
alias cmh="bin/cm.sh halt"
alias cmd="bin/cm.sh destroy"
alias cms="bin/cm.sh ssh"

alias snu="bin/sn.sh up"
alias snh="bin/sn.sh halt"
alias snd="bin/sn.sh destroy"
alias sns="bin/sn.sh ssh"

alias e1u="bin/en.sh up en1.clustercolombia.com"
alias e1h="bin/en.sh halt en1.clustercolombia.com"
alias e1d="bin/en.sh destroy en1.clustercolombia.com"
alias e1s="bin/en.sh ssh en1.clustercolombia.com"

alias e2u="bin/en.sh up en2.clustercolombia.com"
alias e2h="bin/en.sh halt en2.clustercolombia.com"
alias e2d="bin/en.sh destroy en2.clustercolombia.com"
alias e2s="bin/en.sh ssh en2.clustercolombia.com"
