<#
.SYNOPSIS
    Open Computer management

.DESCRIPTION
    Opens Computer management connected for a PC, local or remote. Default is local.

.Example
    PS> Get-Management CGO-999999-H

    Description
    -----------
    This will open computer management for this remote PC, if you are an admin on that PC.

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
Function Get-Management {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0)]$ComputerName = $env:ComputerName
    )
    compmgmt.msc /computer:$ComputerName
}


