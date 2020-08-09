#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Quickly launch Print Management MSC Snap-in

.DESCRIPTION
    Opens Print Management for the local PC and one remote PC using -ComputerName

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



