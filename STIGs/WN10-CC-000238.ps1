<#
.SYNOPSIS
This PowerShell script checks for the existence of the registry path required to configure Microsoft Edge's security settings related to SSL/TLS certificate errors. If the specified registry path does not exist, it creates it. The script then sets the PreventCertErrorOverrides registry value to 1 (enabled), thereby preventing users from ignoring certificate errors in Microsoft Edge. This configuration aligns with the requirements of the STIG WIN10-CC-000238 to enhance web security by ensuring that users cannot bypass important SSL/TLS warnings.

.NOTES
    Author          : Kevin Mumaw
    LinkedIn        : linkedin.com/in/kevin-mumaw-10/
    GitHub          : github.com/kevin-mumaw
    Date Created    : 2025-05-04
    Last Modified   : 2025-05-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000238

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WIN10-CC-000238).ps1 

#>

# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Internet Settings"
$valueName = "PreventCertErrorOverrides"
$valueData = 1

# Check if the registry path exists; if not, create it
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value to prevent certificate error overrides
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Output the result
Write-Host "The registry value for PreventCertErrorOverrides has been set to 1."