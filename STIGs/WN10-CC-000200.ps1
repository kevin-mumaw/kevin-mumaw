<#
.SYNOPSIS
This PowerShell script modifies the registry to ensure that administrator accounts are not enumerated when elevating privileges. This is achieved by setting the EnumerateAdministrators value to 0 in the specified registry path. This setting enhances security by requiring users to explicitly enter a username and password to elevate a running application, thereby reducing the risk of unauthorized access.
.NOTES
    Author: Kevin Mumaw
    LinkedIn: linkedin.com/in/kevin-mumaw-10/
    GitHub: github.com/kevin-mumaw
    Date Created: 2025-01-05
    Last Modified: 2025-01-05
    Version: 1.0
    CVEs: N/A
    Plugin IDs: N/A
    STIG-ID: WN10-CC-000200

.TESTED ON
    Date(s) Tested: 
    Tested By: 
    Systems Tested: 
    PowerShell Ver.: 5.1 Build 26100 Revision 3912

.USAGE
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000200).ps1 
#>
# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI"
$valueName = "EnumerateAdministrators"
$valueData = 0

# Check if the registry path exists
if (-Not (Test-Path $registryPath)) {
    # Create the registry path if it does not exist
    New-Item -Path $registryPath -Force
}

# Set the registry value to disable enumeration of administrator accounts
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Output the result
if ((Get-ItemProperty -Path $registryPath -Name $valueName).$valueName -eq $valueData) {
    Write-Host "Administrator accounts enumeration during elevation has been successfully disabled."
} else {
    Write-Host "Failed to disable administrator accounts enumeration during elevation."
}
