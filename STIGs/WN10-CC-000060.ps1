<#
.SYNOPSIS
The PowerShell script modifies the registry to ensure that connections to non-domain networks are prohibited when the system is connected to a domain authenticated network. This is achieved by setting the fBlockNonDomain value to 1 in the specified registry path, thereby reducing the risk of additional attack vectors.

.NOTES
    Author: Kevin Mumaw
    LinkedIn: linkedin.com/in/kevin-mumaw-10/
    GitHub: github.com/kevin-mumaw
    Date Created: 2025-05-01
    Last Modified: 2025-05-01
    Version: 1.0
    CVEs: N/A
    Plugin IDs: N/A
    STIG-ID: WN10-CC-000060

.TESTED ON
    Date(s) Tested: 
    Tested By: 
    Systems Tested: 
    PowerShell Ver.: 5.1 Build 26100 Revision 3912

.USAGE
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000060).ps1 
#>
    
# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy"
$valueName = "fBlockNonDomain"
$valueData = 1

# Check if the registry path exists
if (-Not (Test-Path $registryPath)) {
    # Create the registry path if it does not exist
    New-Item -Path $registryPath -Force
}

# Set the registry value to block non-domain connections
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Output the result
if ((Get-ItemProperty -Path $registryPath -Name $valueName).$valueName -eq $valueData) {
    Write-Host "Connections to non-domain networks have been successfully blocked."
} else {
    Write-Host "Failed to block connections to non-domain networks."
}
