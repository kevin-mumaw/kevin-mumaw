<#
.SYNOPSIS
The PowerShell script modifies the registry to disable Windows Game Recording and Broadcasting by setting the AllowGameDVR value to 0 in the specified registry path. Disabling this feature helps prevent the potential exposure of sensitive data through inadvertent recording of screen content by the Game DVR feature.

.NOTES
    Author          : Kevin Mumaw
    LinkedIn        : linkedin.com/in/kevin-mumaw-10/
    GitHub          : github.com/kevin-mumaw
    Date Created    : 2025-05-03
    Last Modified   : 2025-05-03
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000252

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000252).ps1 

#>

# This script configures the system to disable IP source routing for security compliance.

# Define registry path and value
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
$valueName = "DisableIPSourceRouting"
$desiredValue = 2

# Check if the registry path exists
if (-not (Test-Path $registryPath)) {
    # Create the registry path if it doesn't exist
    New-Item -Path $registryPath -Force
}

# Get the current value
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

# Check if the DisableIPSourceRouting value exists and if it's less than the desired value
if (-not $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    # Set the DisableIPSourceRouting value to the desired value
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Host "The DisableIPSourceRouting value has been set to $desiredValue (highest protection)."
} else {
    Write-Host "The DisableIPSourceRouting value is already set to $($currentValue.$valueName) (highest protection)."
}