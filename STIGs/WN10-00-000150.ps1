<#
.SYNOPSIS
This PowerShell script is designed to enable Structured Exception Handling Overwrite Protection (SEHOP) on Windows 10 systems prior to version 1709. It does this by checking the registry setting located at HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel. Specifically, it verifies the value of DisableExceptionChainValidation, which should be set to 0 (indicating that SEHOP is enabled). If the value is not set correctly, the script updates it to the desired value, ensuring that the system is protected against buffer overflow attacks that exploit structured exception handling mechanisms.

.NOTES
    Author          : Kevin Mumaw
    LinkedIn        : linkedin.com/in/kevin-mumaw-10/
    GitHub          : github.com/kevin-mumaw
    Date Created    : 2025-29-04
    Last Modified   : 2025-29-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000150

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 5.1 Build 26100 Revision 3912

.USAGE
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-00-000150).ps1 
#>
# Define registry path and value
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"
$valueName = "DisableExceptionChainValidation"
$desiredValue = 0

# Check if the registry path exists
if (-not (Test-Path $registryPath)) {
    Write-Host "Registry path does not exist: $registryPath"
    exit
}

# Get the current value
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

# Check if the DisableExceptionChainValidation value exists and if it is set to the desired value
if (-not $currentValue -or $currentValue.$valueName -ne $desiredValue) {
    # Set the DisableExceptionChainValidation value to the desired value
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Host "The DisableExceptionChainValidation value has been set to $desiredValue (enabled SEHOP)."
} else {
    Write-Host "The DisableExceptionChainValidation value is already set to $desiredValue (SEHOP is enabled)."
}
