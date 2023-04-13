#Region Get-FolderSize

<#
.SYNOPSIS
    Quickly calculate the size of a directory.

.DESCRIPTION
    This function will calculate the disk space used by a specified directory. This uses the current directory by default.
.PARAMETER Folder
    Specify the folder to query. This defaults to the current directory.
.PARAMETER ComputerName
    Specify a remote computer to get the folder size of.
    NOTE: The `-Folder` path will still need to be the local path for the remote computer
    Example:
    Get-FolderSize -ComputerName Some-Remote-PC -Folder C:\Windows\System
.EXAMPLE
    PS> Get-FolderSize

    Description
    -----------
    This will display the folder size of the current folder location `Get-Location`
.EXAMPLE
    PS> Get-FolderSize -ComputerName Some-Remote-PC -Folder C:\Windows\System

    Description
    -----------
    This will get the folder size of the C:\Windows\System folder on the remote pc specified.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @TechDufus

    You can either submit a [PR](https://github.com/TechDufus/AdminToolkit/pulls)
        or create an [Issue](https://github.com/TechDufus/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/TechDufus/AdminToolkit
#>
Function Get-FolderSize() {
    [CmdletBinding()]
    Param (
        [Parameter(
            Position = 0,
            ValueFromPipeline
        )]
        [System.String] $Folder = (Get-Location),

        [Parameter()]
        [System.String] $ComputerName
    )

    Begin {

    }

    Process {
        If ($ComputerName) {
            $Size = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
                (Get-ChildItem $using:Folder -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum
            }
        } Else {
            $Size = (Get-ChildItem $Folder -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum
        }
        switch ($Size) {
            { ($_ -lt '1000000000000000') -and ($_ -ge '1000000000000') } { $TotalSize = "{0:N2} TB" -f ($_ / 1TB) }
            { ($_ -lt '1000000000000') -and ($_ -ge '1000000000') } { $TotalSize = "{0:N2} GB" -f ($_ / 1GB) }
            { ($_ -lt '1000000000') -and ($_ -ge '1000000') } { $TotalSize = "{0:N2} MB" -f ($_ / 1MB) }
            { $_ -lt '1000000' } { $TotalSize = "{0:N2} KB" -f ($_ / 1KB) }
        }
        
        $TotalSize
    }
}
#EndRegion Get-FolderSize
