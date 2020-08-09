#!/usr/bin/env pwsh

<#
.Synopsis
    Deletes folder recursively, so be careful. If -Include is empty, it will delete all files, otherwise it will delete only the ones you -Include.

.DESCRIPTION
    This command deletes all files recursively in a path that match the included filename.

.EXAMPLE
    PS>Remove-Path C:\temp

    Description
    -----------
    Specify the parent folder from which the command runs and specify file names to include. Wildcards are supported.

    Remove-Path -path c:\Folder -include "*.logs"

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    Change Log:
    Version: 1.0 - Function Creation.
#>
Function Remove-Path {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]$Path,
        [Parameter(Mandatory = $true)]$Include
    )

    Get-ChildItem -path "$Path" -Include "$Include" -Recurse -force | Remove-Item -force -Recurse
}




