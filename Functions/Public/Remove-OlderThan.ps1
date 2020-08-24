#Region Remove-OlderThan

<#
.Synopsis
    Remove files in a directory recursively based on how many days since the files was changed. Use negative values for -DaysBack.

.Description
    This scripts function is to delete files and folders older than x days recursively.

.Example
    Delete-OlderThan -Path "C:\Folder" -DaysBack 90

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    Change Log:
    Version: 1.0 - Function Creation.
#>
Function Remove-OlderThan {
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