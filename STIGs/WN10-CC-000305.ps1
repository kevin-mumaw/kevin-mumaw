<#
.SYNOPSIS
This PowerShell script checks for the existence of the specified registry path related to Windows Search settings. If the path does not exist, it creates it. Then, it sets the registry value AllowIndexingEncryptedStoresOrItems to 0 (disabled), ensuring that indexing of encrypted files is turned off, thereby mitigating the risk of exposing sensitive data.

.NOTES
    Author          : Kevin Mumaw
    LinkedIn        : linkedin.com/in/kevin-mumaw-10/
    GitHub          : github.com/kevin-mumaw
    Date Created    : 2025-05-04
    Last Modified   : 2025-05-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000305

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WIN10-CC-000305).ps1 

#>

# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
$valueName = "AllowIndexingEncryptedStoresOrItems"
$valueType = "DWORD"
$valueData = 0

# Check if the registry path exists
if (-not (Test-Path $registryPath)) {
    # Create the registry path if it does not exist
    New-Item -Path $registryPath -Force
}

# Set the registry value to disable indexing of encrypted files
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type $valueType

# Output the result
Write-Host "Indexing of encrypted files has been disabled."