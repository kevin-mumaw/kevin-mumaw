<#
.SYNOPSIS
This PowerShell script checks for the existence of the registry path required to configure the encryption level for Remote Desktop Services. If the specified registry path does not exist, it creates it. The script then sets the MinEncryptionLevel registry value to 3, which corresponds to "High Level" encryption for Remote Desktop Services connections. This configuration is essential to protect against the interception of sensitive data during remote sessions, aligning with the requirements of STIG WIN10-CC-000290.

.NOTES
    Author          : Kevin Mumaw
    LinkedIn        : linkedin.com/in/kevin-mumaw-10/
    GitHub          : github.com/kevin-mumaw
    Date Created    : 2025-05-04
    Last Modified   : 2025-05-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000290

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WIN10-CC-000290).ps1 

#>

# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$valueName = "MinEncryptionLevel"
$valueData = 3  # High Level encryption

# Check if the registry path exists; if not, create it
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value for minimum encryption level
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Output the result
Write-Host "The registry value for MinEncryptionLevel has been set to 3 (High Level)."