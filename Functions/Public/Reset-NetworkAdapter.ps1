#Region Reset-NetworkAdapter

<#
.SYNOPSIS
    Reset a network interface.

.DESCRIPTION
    Reset a specified interface with -Interface.

.PARAMETER Interface
    Specify the name of the network interface name to reset.

.EXAMPLE
    Reset-NetworkAdapter -Interface "Local Area Connection"

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit

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
#EndRegion Reset-NetworkAdapter