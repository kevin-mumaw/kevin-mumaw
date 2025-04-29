<#
.SYNOPSIS
This PowerShell script is designed to configure the System event log size to 32,768 KB (32 MB) or greater, in compliance with the STIG requirement WN10-AU-000510. It checks the registry setting located at HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog\System. If the MaxSize value does not exist or is set to a value less than 32,768 KB, the script creates the registry key (if necessary) and updates the MaxSize value accordingly. This ensures that the System event log is adequately sized to prevent it from filling up quickly, which could lead to the loss of important audit events and require frequent administrative attention.

.NOTES
    Author          : Kevin Mumaw
    LinkedIn        : linkedin.com/in/kevin-mumaw-10/
    GitHub          : github.com/kevin-mumaw
    Date Created    : 2025-04-29
    Last Modified   : 2025-04-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000510

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000510).ps1 
#>

# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System"
$valueName = "MaxSize"
$desiredValue = 32768

# Check if the registry path exists
if (-not (Test-Path $registryPath)) {
    # Create the registry path if it doesn't exist
    New-Item -Path $registryPath -Force
}

# Get the current value
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

# Check if the MaxSize value exists and if it's less than the desired value
if (-not $currentValue -or $currentValue.$valueName -lt $desiredValue) {
    # Set the MaxSize value to the desired value
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Host "The MaxSize value has been set to $desiredValue KB."
} else {
    Write-Host "The MaxSize value is already set to $($currentValue.$valueName) KB or greater."
}
