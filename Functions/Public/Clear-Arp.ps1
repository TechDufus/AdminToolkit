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
#>
function Clear-Arp() {
    [CmdletBinding()]
    param()
    netsh.exe interface ip delete arpcache
}
#EndRegion Clear-Arp