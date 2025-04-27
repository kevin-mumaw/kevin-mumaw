<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Kevin Mumaw
    LinkedIn        : linkedin.com/in/kevin-mumaw-10/
    GitHub          : github.com/kevin-mumaw
    Date Created    : 2025-04-25
    Last Modified   : 2024-04-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# Define registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
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
