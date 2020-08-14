#Region Get-Printers
<#
.SYNOPSIS
    Get printers for local or remote PC

.Description
    This function will attempt to gather printer information for a local or remote PC.
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
    Handle: @matthewjdegarmo
#>
Function Get-Printers {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [String] $ComputerName
    )

    $Params = @{
        ClassName = 'CIM_Printer'
    }
    if ($ComputerName) {$Params += @{ComputerName = $ComputerName}}
    Get-CimInstance @Params | Select-Object Name, Drivername, Portname, Status, SystemName, local, shared, CapabilityDescriptions
}
#EndRegion Get-Printers