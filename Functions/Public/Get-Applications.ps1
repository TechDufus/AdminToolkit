#!/usr/bin/env pwsh

<#
.SYNOPSIS
    List locally installed applications

.DESCRIPTION
    Query local registry for installed applications.
.NOTES
    Author: Matthew J. DeGarmo
    Site: https://matthewjdegarmo.github.io
#>
Function Get-Applications {
    Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Select-Object DisplayName, DisplayVersion, Publisher, InstallDate |
    Sort-Object DisplayName
}



