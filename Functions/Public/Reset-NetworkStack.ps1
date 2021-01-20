#Region Reset-NetworkStack

<#
.SYNOPSIS
    Reset Network Stack. Will require a reboot.
.DESCRIPTION
    Resets the TCP/IP and Winsock Stacks
.EXAMPLE
    PS> Reset-NetworkStack
    
    Description
    -----------
    This will reset the winsock and ip, ipv4, and ipv6 interfaces.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/HelpDesk/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk

    Change Log:
    Version: 1.0 - Function Creation.
#>
Function Reset-NetworkStack {
    [CmdletBinding()]
    param (
    )

    netsh.exe winsock reset
    netsh.exe int ip reset
    netsh.exe int ipv4 reset reset.log
    netsh.exe int ipv6 reset reset.log
    Write-Output "[-] You will need to restart this computer."
}
#EndRegion Reset-NetworkStack