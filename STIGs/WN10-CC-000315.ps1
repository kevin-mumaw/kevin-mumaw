<#
.SYNOPSIS
This PowerShell script checks for the existence of the registry path required to configure the Windows Installer settings. If the specified registry path does not exist, it creates it. The script then sets the AlwaysInstallElevated registry value to 0, which disables the option for the Windows Installer to install applications with elevated privileges. This is crucial for maintaining system security, as it prevents standard user accounts from gaining elevated privileges that could be exploited by malicious software, thus aligning with the requirements of STIG WIN10-CC-000315.




.NOTES
    Author          : Kevin Mumaw
    LinkedIn        : linkedin.com/in/kevin-mumaw-10/
    GitHub          : github.com/kevin-mumaw
    Date Created    : 2025-05-04
    Last Modified   : 2025-05-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000315

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WIN10-CC-000315).ps1 

#>

# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$valueName = "AlwaysInstallElevated"
$valueData = 0  # Disable elevated privileges

# Check if the registry path exists; if not, create it
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value to disable elevated privileges for Windows Installer
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Output the result
Write-Host "The registry value for AlwaysInstallElevated has been set to 0 (Disabled)."