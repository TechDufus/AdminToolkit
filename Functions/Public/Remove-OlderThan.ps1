#Region Remove-OlderThan

<#
.Synopsis
    Remove files in a directory recursively based on how many days since the files was changed. Use negative values for -DaysBack.

.Description
    This scripts function is to delete files and folders older than x days recursively.

.PARAMETER Path
    Specify the root path to delete items from.
.PARAMETER DaysBack
    Specify the amount of days old since a file was edited to delete.
.PARAMETER Recurse
    Search recursively for files.

.Example
    Delete-OlderThan -Path "C:\Folder" -DaysBack 90

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @TechDufus

    You can either submit a [PR](https://github.com/TechDufus/AdminToolkit/pulls)
        or create an [Issue](https://github.com/TechDufus/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/TechDufus/AdminToolkit

    Change Log:
    Version: 1.0 - Function Creation.
#>
Function Remove-OlderThan() {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]$Path,
        [Parameter(Mandatory = $true)][ValidateScript( { $_ -gt 0 })][int]$DaysBack,
        [Parameter(Mandatory = $false)][Switch]$Recurse
    )
    
    $CurrentDate = Get-Date
    $DatetoDelete = $CurrentDate.AddDays("-$Daysback")
    Get-ChildItem $Path | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item -Force
}
#EndRegion Remove-OlderThan
