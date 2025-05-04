<#
.SYNOPSIS
The PowerShell script modifies the registry to disable the saving of passwords in the Remote Desktop Client by setting the DisablePasswordSaving value to 1 in the specified registry path. This configuration helps prevent unauthorized users from establishing remote desktop sessions using saved credentials, thereby enhancing system security.

.NOTES
    Author          : Kevin Mumaw
    LinkedIn        : linkedin.com/in/kevin-mumaw-10/
    GitHub          : github.com/kevin-mumaw
    Date Created    : 2025-05-03
    Last Modified   : 2025-05-03
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000270

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000270).ps1 

#>

# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$valueName = "DisablePasswordSaving"
$valueData = 1

# Check if the registry path exists
if (-Not (Test-Path $registryPath)) {
    # Create the registry path if it does not exist
    New-Item -Path $registryPath -Force
}

# Set the registry value to disable password saving in the Remote Desktop Client
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Output the result
if ((Get-ItemProperty -Path $registryPath -Name $valueName).$valueName -eq $valueData) {
    Write-Host "Saving passwords in the Remote Desktop Client has been successfully disabled."
} else {
    Write-Host "Failed to disable saving passwords in the Remote Desktop Client."
}