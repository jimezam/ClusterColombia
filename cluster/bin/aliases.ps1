# Aliases

Write-Output "Setting ClusterColombia local vm handling aliases ... "

Set-Alias -Name cs -Value "bin/status.sh"

Set-Alias -Name cmu -Value "bin/cm.sh up"
Set-Alias -Name cmh -Value "bin/cm.sh halt"
Set-Alias -Name cmd -Value "bin/cm.sh destroy"
Set-Alias -Name cms -Value "bin/cm.sh ssh"

Set-Alias -Name snu -Value "bin/sn.sh up"
Set-Alias -Name snh -Value "bin/sn.sh halt"
Set-Alias -Name snd -Value "bin/sn.sh destroy"
Set-Alias -Name sns -Value "bin/sn.sh ssh"

Set-Alias -Name e1u -Value "bin/en.sh up en1.clustercolombia.com"
Set-Alias -Name e1h -Value "bin/en.sh halt en1.clustercolombia.com"
Set-Alias -Name e1d -Value "bin/en.sh destroy en1.clustercolombia.com"
Set-Alias -Name e1s -Value "bin/en.sh ssh en1.clustercolombia.com"

Set-Alias -Name e2u -Value "bin/en.sh up en2.clustercolombia.com"
Set-Alias -Name e2h -Value "bin/en.sh halt en2.clustercolombia.com"
Set-Alias -Name e2d -Value "bin/en.sh destroy en2.clustercolombia.com"
Set-Alias -Name e2s -Value "bin/en.sh ssh en2.clustercolombia.com"
