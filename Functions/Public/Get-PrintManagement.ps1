#Region Get-PrintManagement

<#
.SYNOPSIS
    Quickly launch Print Management MSC Snap-in
.DESCRIPTION
    Opens Print Management for the local PC and one remote PC using -ComputerName
.PARAMETER ComputerName
    Specify the remote computer to open Print Management against.
.EXAMPLE
    PS> Get-PrintManagement -ComputerName Computer1

    Description
    -----------
    This will open PrintManagement on the local machine and connect to the remote `Computer1`
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/HelpDesk/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk
#>
Function Get-PrintManagement {
    [CmdletBinding()]
    param (
        [string[]]$ComputerName = $env:COMPUTERNAME
    )
    printmanagement.msc /computer:$ComputerName
}
#EndRegion Get-PrintManagement