#Region Clear-Arp

<#
.SYNOPSIS
    Use Netsh to clear ArpCache
.DESCRIPTION
    Clears the local arp table
.EXAMPLE
    PS> Clear-Arp

    Description
    -----------
    This will clear the arpcache on the local machine.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit
#>
function Clear-Arp() {
    [CmdletBinding()]
    param()
    netsh.exe interface ip delete arpcache
}
#EndRegion Clear-Arp