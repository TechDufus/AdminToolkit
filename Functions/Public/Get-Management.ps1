#Region Get-Management

<#
.SYNOPSIS
    Open Computer management

.DESCRIPTION
    Opens Computer management connected for a PC, local or remote. Default is local.

.PARAMETER ComputerName
    Specify a remote computer to run against.

.Example
    PS> Get-Management Test-999999-H

    Description
    -----------
    This will open computer management for this remote PC, if you are an admin on that PC.

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @TechDufus

    You can either submit a [PR](https://github.com/TechDufus/AdminToolkit/pulls)
        or create an [Issue](https://github.com/TechDufus/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/TechDufus/AdminToolkit
#>
Function Get-Management() {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0)]$ComputerName = $env:ComputerName
    )
    compmgmt.msc /computer:$ComputerName
}
#EndRegion Get-Management
