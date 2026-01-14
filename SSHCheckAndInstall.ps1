<#
.SYNOPSIS
    Checks for OpenSSH Client and SSH Agent status. Enables them if missing.
    
.DESCRIPTION
    1. Checks if the 'OpenSSH.Client' Windows Capability is installed.
       If not, it installs it via Add-WindowsCapability.
    2. Checks if the 'ssh-agent' service is set to Automatic and Running.
       If not, it configures and starts it.
    
.NOTES
    Run as Administrator.
#>

# Ensure script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This script requires Administrator privileges. Please run as Admin."
    exit
}

Write-Host "--------------------------------------------------------" -ForegroundColor Cyan
Write-Host " OpenSSH Client & Agent Setup" -ForegroundColor Cyan
Write-Host "--------------------------------------------------------"

# 1. Check OpenSSH Client Capability
$sshCapabilityName = "OpenSSH.Client~~~~0.0.1.0"
$sshCapability = Get-WindowsCapability -Online | Where-Object { $_.Name -eq $sshCapabilityName }

if ($sshCapability.State -eq 'Installed') {
    Write-Host " [OK] OpenSSH Client is already installed." -ForegroundColor Green
}
else {
    Write-Host " [..] OpenSSH Client not found. Installing..." -ForegroundColor Yellow
    try {
        Add-WindowsCapability -Online -Name $sshCapabilityName | Out-Null
        Write-Host " [OK] OpenSSH Client installed successfully." -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to install OpenSSH Client. Error: $_"
        exit
    }
}

# 2. Check SSH Agent Service (Critical for Git keys)
$agentService = Get-Service -Name "ssh-agent" -ErrorAction SilentlyContinue

if ($agentService) {
    # Check Startup Type
    $startType = $agentService.StartType
    if ($startType -ne 'Automatic') {
        Write-Host " [..] Setting ssh-agent StartupType to Automatic..." -ForegroundColor Yellow
        Set-Service -Name "ssh-agent" -StartupType Automatic
    }
    
    # Check Running Status
    if ($agentService.Status -ne 'Running') {
        Write-Host " [..] Starting ssh-agent service..." -ForegroundColor Yellow
        Start-Service -Name "ssh-agent"
        Write-Host " [OK] ssh-agent is now Running." -ForegroundColor Green
    }
    else {
        Write-Host " [OK] ssh-agent is configured and running." -ForegroundColor Green
    }
}
else {
    Write-Error " [!!] ssh-agent service not found! This is unexpected on Windows 10/11."
}

# 3. Final Verification
if (Get-Command ssh -ErrorAction SilentlyContinue) {
    $version = (ssh -V 2>&1)
    Write-Host "`nVerification Complete:" -ForegroundColor Cyan
    Write-Host " $version" -ForegroundColor Gray
}