#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Reset Network Stack. Will require a reboot.

.DESCRIPTION
    Resets the TCP/IP and Winsock Stacks

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

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





