<#
.SYNOPSIS
    Reset a network interface.

.DESCRIPTION
    Reset a specified interface with -Interface.

.EXAMPLE
    Reset-NetworkAdapter -Interface "Local Area Connection"

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    Change Log:
    Version: 1.0 - Function Creation.
#>
Function Reset-NetworkAdapter {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]$Interface
    )

    netsh.exe interface set interface $Interface admin=disable
    netsh.exe interface set interface $Interface admin=enable
}






