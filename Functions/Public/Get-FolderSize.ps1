<#
.SYNOPSIS
    Quickly calculate the size of a directory.

.DESCRIPTION
    This function will calculate the disk space used by a specified directory. This uses the current directory by default.

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
Function Get-FolderSize {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0)]$Folder = (Get-Location)
    )

    $Size = (Get-ChildItem $Folder -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum
    switch ($Size) {
        { ($_ -lt '1000000000000000') -and ($_ -ge '1000000000000') } { $TotalSize = "{0:N2} TB" -f ($_ / 1TB) }
        { ($_ -lt '1000000000000') -and ($_ -ge '1000000000') } { $TotalSize = "{0:N2} GB" -f ($_ / 1GB) }
        { ($_ -lt '1000000000') -and ($_ -ge '1000000') } { $TotalSize = "{0:N2} MB" -f ($_ / 1MB) }
        { $_ -lt '1000000' } { $TotalSize = "{0:N2} KB" -f ($_ / 1KB) }
    }
    
    $TotalSize
}


