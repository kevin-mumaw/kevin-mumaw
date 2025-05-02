<#
.SYNOPSIS
The PowerShell script modifies the registry to ensure that ECC curves with longer key lengths (specifically NistP384 and NistP256) are prioritized for SSL/TLS communications. This is achieved by setting the EccCurves value in the specified registry path, thereby enhancing the security of encryption algorithms used by the system.
.NOTES
    Author: Kevin Mumaw
    LinkedIn: linkedin.com/in/kevin-mumaw-10/
    GitHub: github.com/kevin-mumaw
    Date Created: 2025-01-05
    Last Modified: 2025-01-05
    Version: 1.0
    CVEs: N/A
    Plugin IDs: N/A
    STIG-ID: WN10-CC-000052

.TESTED ON
    Date(s) Tested: 
    Tested By: 
    Systems Tested: 
    PowerShell Ver.: 5.1 Build 26100 Revision 3912

.USAGE
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000052).ps1 

#>
# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"
$valueName = "EccCurves"
$valueData = "NistP384", "NistP256"  # Use an array for REG_MULTI_SZ

# Check if the registry path exists
if (-Not (Test-Path $registryPath)) {
    # Create the registry path if it does not exist
    New-Item -Path $registryPath -Force
}

# Set the registry value to prioritize ECC curves
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type MultiString

# Output the result
$configuredValue = (Get-ItemProperty -Path $registryPath -Name $valueName).$valueName
if ($configuredValue -eq $valueData) {
    Write-Host "ECC curves have been successfully prioritized."
} else {
    Write-Host "Failed to prioritize ECC curves."
}
