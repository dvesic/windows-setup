# Espanso Edit
function ee { espanso edit }

# Touch command
function touch { param($file) New-Item -ItemType File -Path $file -Force | Out-Null }


Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force

# =============================================================================
#
# To initialize zoxide, add this to your configuration (find it by running
# `echo $profile` in PowerShell):
#
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Initialization for oh-my-posh:
oh-my-posh init pwsh --config $env:OneDriveConsumer\Utils\OhMyPosh\config.omp.json | Invoke-Expression