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

    You can either submit a [PR](https://github.com/matthewjdegarmo/HelpDesk/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk
#>
Function Get-Applications {
    [CmdletBinding()]
    param()
    $RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
    Get-ChildItem -Path $RegPath | Get-ItemProperty |
    Sort-Object DisplayName
}
#EndRegion Get-Applications
