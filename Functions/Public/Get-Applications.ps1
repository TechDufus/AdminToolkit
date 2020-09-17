#Region Get-Applications

<#
.SYNOPSIS
    List locally installed applications

.DESCRIPTION
    Query local registry for installed applications.
.EXAMPLE
    PS> Get-Applications

    Description
    -----------
    This will generate all installed applications on the local system.
.NOTES
    Author: Matthew J. DeGarmo
    Site: https://matthewjdegarmo.github.io
#>
Function Get-Applications {
    [CmdletBinding()]
    param()
    $RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
    Get-ChildItem -Path $RegPath | Get-ItemProperty |
    Sort-Object DisplayName
}
#EndRegion Get-Applications
