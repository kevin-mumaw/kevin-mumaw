<#
.SYNOPSIS
This PowerShell script checks for the existence of the specified registry path for the WinRM client configuration. If the path does not exist, it creates it. The script then sets the AllowBasic registry value to 0, effectively disabling Basic authentication for the WinRM client. This change mitigates the risk associated with plain text password transmission and aligns the system configuration with the STIG requirement WN10-CC-000330.

.NOTES
    Author          : Kevin Mumaw
    LinkedIn        : linkedin.com/in/kevin-mumaw-10/
    GitHub          : github.com/kevin-mumaw
    Date Created    : 2025-05-05
    Last Modified   : 2025-05-05
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000330

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WIN10-CC-000330).ps1 

#>

# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"
$valueName = "AllowBasic"
$valueData = 0

# Check if the registry path exists
if (-not (Test-Path $registryPath)) {
    # Create the registry path if it does not exist
    New-Item -Path $registryPath -Force
}

# Set the registry value to disable Basic authentication
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Output the result
Write-Host "Basic authentication for WinRM client has been disabled."