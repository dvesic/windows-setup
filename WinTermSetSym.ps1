## Maps local Windows Terminal settings folder to cloud one
## Destructive operation! Make sure to backup $WinTermPath before, just in case
##
## Run elevated

# Ensure script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This script requires Administrator privileges. Please run as Admin."
    exit
}

$WinTermPath = "$Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
$CloudTarget = "$Env:OneDriveConsumer\Utils\WindowsTerminal\LocalState"

Remove-Item -Force -Recurse -Path $WinTermPath
New-Item -ItemType SymbolicLink -Path $WinTermPath -Target $CloudTarget