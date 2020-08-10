#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Quickly launch Print Management MSC Snap-in
.DESCRIPTION
    Opens Print Management for the local PC and one remote PC using -ComputerName
.EXAMPLE
    PS> Get-PrintManagement -ComputerName Computer1

    Description
    -----------
    This will open PrintManagement on the local machine and connect to the remote `Computer1`
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
Function Get-PrintManagement {
    [CmdletBinding()]
    param (
        [string[]]$ComputerName
    )
    printmanagement.msc /computer:$ComputerName
}


