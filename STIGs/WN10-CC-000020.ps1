<#
.SYNOPSIS
This PowerShell script is designed to configure IPv6 source routing to the highest protection level, in compliance with the STIG requirement WN10-CC-000020. It checks the registry setting located at HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters. If the DisableIpSourceRouting value does not exist or is not set to 2 (which indicates that source routing is completely disabled), the script creates the necessary registry key (if needed) and updates the value accordingly. This configuration protects against packet spoofing by ensuring that IPv6 source routing is disabled, thereby enhancing the security posture of the system.

.NOTES
    Author          : Kevin Mumaw
    LinkedIn        : linkedin.com/in/kevin-mumaw-10/
    GitHub          : github.com/kevin-mumaw
    Date Created    : 2025-04-29
    Last Modified   : 2025-04-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000020

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 5.1 Build 26100 Revision 3912

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000020).ps1 
#>

# Define registry path and value
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$valueName = "DisableIpSourceRouting"
$desiredValue = 2

# Check if the registry path exists
if (-not (Test-Path $registryPath)) {
    # Create the registry path if it doesn't exist
    New-Item -Path $registryPath -Force
}

# Get the current value
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

# Check if the DisableIpSourceRouting value exists and if it's less than the desired value
if (-not $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    # Set the DisableIpSourceRouting value to the desired value
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Host "The DisableIpSourceRouting value has been set to $desiredValue (highest protection)."
} else {
    Write-Host "The DisableIpSourceRouting value is already set to $($currentValue.$valueName) (highest protection)."
}
