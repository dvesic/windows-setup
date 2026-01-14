<#
.SYNOPSIS
    Symlinks the PowerShell Profile to a Cloud Drive location.
    
.DESCRIPTION
    This script backs up the existing local PowerShell profile (if any)
    and creates a symbolic link to the master profile stored in your
    Cloud Drive (Google Drive/OneDrive).
    
    This ensures that aliases, Oh My Posh themes, and functions
    are instantly synced across all your machines.

.NOTES
    File Name      : PowerShellProfileSym.ps1
    Author         : dvesic
    Prerequisite   : Run as Administrator (required for New-Item -ItemType SymbolicLink)
#>


# 0. Ensure script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This script requires Administrator privileges. Please run as Admin."
    exit
}

# 1. CONFIGURATION
# Adjust this path to match your actual Cloud Drive structure
$CloudProfile = "$Env:OneDriveConsumer\Utils\PowerShell\Microsoft.PowerShell_profile.ps1"

# 2. DEFINITIONS
$LocalProfile = $PROFILE
$LocalProfileDir = Split-Path -Path $LocalProfile

# 3. EXECUTION
Write-Host "--------------------------------------------------------" -ForegroundColor Cyan
Write-Host " PowerShell Profile Symlink Setup" -ForegroundColor Cyan
Write-Host "--------------------------------------------------------"

# Check if Cloud Profile exists
if (-not (Test-Path -Path $CloudProfile)) {
    Write-Warning "Target cloud profile not found at: $CloudProfile"
    Write-Warning "Please check the path or create the file first."
    return
}

# Ensure Local Directory Exists
if (-not (Test-Path -Path $LocalProfileDir)) {
    New-Item -ItemType Directory -Path $LocalProfileDir -Force | Out-Null
    Write-Host "Created directory: $LocalProfileDir" -ForegroundColor DarkGray
}

# Remove existing local profile (Backup logic could be added here if needed)
if (Test-Path -Path $LocalProfile) {
    $item = Get-Item -Path $LocalProfile
    
    # Check if it is already a symlink
    if ($item.LinkType -eq "SymbolicLink") {
        $currentTarget = $item.Target
        if ($currentTarget -eq $CloudProfile) {
            Write-Host "Success: Profile is already symlinked correctly." -ForegroundColor Green
            return
        }
    }
    
    Remove-Item -Force -Path $LocalProfile
    Write-Host "Removed existing local profile." -ForegroundColor Yellow
}

# Create Symlink
try {
    New-Item -ItemType SymbolicLink -Path $LocalProfile -Target $CloudProfile | Out-Null
    Write-Host "Success! Symlink created." -ForegroundColor Green
    Write-Host "Local: $LocalProfile"
    Write-Host "Target: $CloudProfile"
}
catch {
    Write-Error "Failed to create symlink. Ensure you are running as Administrator."
    Write-Error $_.Exception.Message
}