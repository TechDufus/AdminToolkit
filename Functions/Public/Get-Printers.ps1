#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Get printers for local or remote PC

.Description
    This function will attempt to gather printer information for a local or remote PC.

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
Function Get-Printers {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]$ComputerName
    )

        Get-CimInstance cim_printer -computer $computer | Select-Object Name, Drivername, Portname, Status, SystemName, local, shared, CapabilityDescriptions
}





