<#
.SYNOPSIS
Use Netsh to clear ArpCache

.DESCRIPTION
Clears the local arp table

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
function Clear-Arp() {
    netsh.exe interface ip delete arpcache
}




