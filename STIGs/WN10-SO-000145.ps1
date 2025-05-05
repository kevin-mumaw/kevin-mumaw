<#
.SYNOPSIS
This PowerShell script modifies the registry setting to prevent anonymous enumeration of SAM accounts. It specifically sets the RestrictAnonymousSAM registry value to 1, which enables the restriction. By doing so, the script mitigates the risk associated with anonymous logon users being able to list account names, which could expose potential attack vectors. This configuration aligns the system with the STIG requirement WIN10-SO-000145, enhancing overall security by limiting access to sensitive account information.

.NOTES
    Author          : Kevin Mumaw
    LinkedIn        : linkedin.com/in/kevin-mumaw-10/
    GitHub          : github.com/kevin-mumaw
    Date Created    : 2025-05-05
    Last Modified   : 2025-05-05
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000145

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WIN10-SO-000145).ps1 

#>

# Define the registry path and value
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$valueName = "RestrictAnonymousSAM"
$valueData = 1

# Set the registry value to enable restriction on anonymous enumeration
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Output the result
Write-Host "Anonymous enumeration of SAM accounts has been disabled."