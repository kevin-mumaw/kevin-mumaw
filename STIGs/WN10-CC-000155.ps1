<#
.SYNOPSIS
This PowerShell script modifies the registry to ensure that solicited remote assistance is not allowed by setting the fAllowToGetHelp value to 0 in the specified registry path. This action helps to prevent unauthorized access to the local session of a user, thereby enhancing the security of the system.

.NOTES
    Author: Kevin Mumaw
    LinkedIn: linkedin.com/in/kevin-mumaw-10/
    GitHub: github.com/kevin-mumaw
    Date Created: 2025-05-01
    Last Modified: 2025-05-01
    Version: 1.0
    CVEs: N/A
    Plugin IDs: N/A
    STIG-ID: WN10-CC-000155

.TESTED ON
    Date(s) Tested: 
    Tested By: 
    Systems Tested: 
    PowerShell Ver.: 5.1 Build 26100 Revision 3912

.USAGE
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000155).ps1 
#>

# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$valueName = "fAllowToGetHelp"
$valueData = 0

# Check if the registry path exists
if (-Not (Test-Path $registryPath)) {
    # Create the registry path if it does not exist
    New-Item -Path $registryPath -Force
}

# Set the registry value to disable solicited remote assistance
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Output the result
if ((Get-ItemProperty -Path $registryPath -Name $valueName).$valueName -eq $valueData) {
    Write-Host "Solicited Remote Assistance has been successfully disabled."
} else {
    Write-Host "Failed to disable solicited Remote Assistance."
}
