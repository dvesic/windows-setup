## Maps local Windows Terminal settings folder to cloud one
## Destructive operation! Make sure to backup $WinTermPath before, just in case

$WinTermPath = "$Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
$CloudTarget = "G:\My Drive\Projects\Win.Terminal"

Remove-Item -Force -Recurse -Path $WinTermPath
New-Item -ItemType SymbolicLink -Path $WinTermPath -Target $CloudTarget