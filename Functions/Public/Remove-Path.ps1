#Region Remove-Path

<#
.Synopsis
    Deletes folder recursively, so be careful. If -Include is empty, it will delete all files, otherwise it will delete only the ones you -Include.

.DESCRIPTION
    This command deletes all files recursively in a path that match the included filename.

.PARAMETER Path
    Specify the path to recursively delete.

.PARAMETER Include
    Restrict the deletion to specific file names, types, etc.. by specifying them in this parameter.
    See `Get-Help Get-ChildItem -Parameter Include` for more information.

.EXAMPLE
    PS>Remove-Path C:\temp

    Description
    -----------
    Specify the parent folder from which the command runs and specify file names to include. Wildcards are supported.

    Remove-Path -path c:\Folder -include "*.logs"

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @TechDufus

    You can either submit a [PR](https://github.com/TechDufus/AdminToolkit/pulls)
        or create an [Issue](https://github.com/TechDufus/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/TechDufus/AdminToolkit
#>
Function Remove-Path() {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]$Path,
        [Parameter(Mandatory = $true)]$Include
    )

    Get-ChildItem -path "$Path" -Include "$Include" -Recurse -force | Remove-Item -force -Recurse
}
#EndRegion Remove-Path
