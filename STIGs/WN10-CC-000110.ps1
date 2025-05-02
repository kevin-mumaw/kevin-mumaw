<#
.SYNOPSIS
This PowerShell script modifies the registry to disable printing over HTTP by setting the DisableHTTPPrinting value to 1 in the specified registry path. This action helps to prevent sensitive information from being sent outside the enterprise and restricts uncontrolled updates to the system.

.NOTES
    Author: Kevin Mumaw
    LinkedIn: linkedin.com/in/kevin-mumaw-10/
    GitHub: github.com/kevin-mumaw
    Date Created: 2025-05-01
    Last Modified: 2025-05-01
    Version: 1.0
    CVEs: N/A
    Plugin IDs: N/A
    STIG-ID: WN10-CC-000110

.TESTED ON
    Date(s) Tested: 
    Tested By: 
    Systems Tested: 
    PowerShell Ver.: 5.1 Build 26100 Revision 3912

.USAGE
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000110).ps1 
#>

# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$valueName = "DisableHTTPPrinting"
$valueData = 1

# Check if the registry path exists
if (-Not (Test-Path $registryPath)) {
    # Create the registry path if it does not exist
    New-Item -Path $registryPath -Force
}

# Set the registry value to disable printing over HTTP
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Output the result
if ((Get-ItemProperty -Path $registryPath -Name $valueName).$valueName -eq $valueData) {
    Write-Host "Printing over HTTP has been successfully disabled."
} else {
    Write-Host "Failed to disable printing over HTTP."
}
