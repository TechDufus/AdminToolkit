#Region Get-Printers

<#
.SYNOPSIS
    Get printers for local or remote PC

.Description
    This function will attempt to gather printer information for a local or remote PC.

.PARAMETER ComputerName
    Specify the remote computer to query.

.EXAMPLE
    PS> Get-Printers
    
    Description
    -----------
    This will generate local printer information.
.EXAMPLE
    PS> Get-Printers -ComputerName Some-Remote-Computer1
    
    Description
    -----------
    This will generate printer information for the remote computer `Some-Remote-Computer1' via a Cim Instance.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @TechDufus

    You can either submit a [PR](https://github.com/TechDufus/AdminToolkit/pulls)
        or create an [Issue](https://github.com/TechDufus/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/TechDufus/AdminToolkit
#>
Function Get-Printers() {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [String] $ComputerName
    )

    $Params = @{
        ClassName = 'CIM_Printer'
    }
    if ($ComputerName) { $Params += @{ComputerName = $ComputerName } }
    Get-CimInstance @Params | Select-Object Name, Drivername, Portname, Status, SystemName, local, shared, CapabilityDescriptions
}
#EndRegion Get-Printers
