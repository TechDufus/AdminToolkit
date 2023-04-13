#Region DateStamp
<#
This is to pass the cmdlet exporting pester tests since this is a filter
Function DateStamp() {
#>

<#
.SYNOPSIS
    This is a filter used to place timestamps on any output messages.
.DESCRIPTION
    The function `TimeStamp` is a colorized version of this command `DateStamp`, but `TimeStamp` output cannot be written to a file. You will want to use `DateStamp` if you are going to output your messages into a log or txt file.
.EXAMPLE
    "ERROR: Something bad happened on this line of the script" | DateStamp

    [08/04/2020 11:34:35]: ERROR: Something bad happened on this line of the script

    Description
    -----------
    This line will place a time stamp at the beginning of the line that can be written to a file.
.NOTES
    Author: Matthew J. DeGarmo
    Site: https://TechDufus.github.io

    You can either submit a [PR](https://github.com/TechDufus/AdminToolkit/pulls)
        or create an [Issue](https://github.com/TechDufus/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/TechDufus/AdminToolkit
#>
Filter DateStamp() {
    [CmdletBinding()]
    param()
    process {
        Write-Output "[$(Get-Date -Format "MM/dd/yyyy HH:mm:ss")]: $_"
    }
}
#EndRegion DateStamp
