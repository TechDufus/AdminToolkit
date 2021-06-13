#Region Test-IsIpAddressInRange

<#
.SYNOPSIS
    Test to see if a given IP is between a given start and end address.
.DESCRIPTION
    Provide the IP Range (Start and End Address) and the IP to check. This function will return True or False.
.PARAMETER IpAddress
    Specify the IP to test if it is in a specific range.
.PARAMETER StartAddress
    Specify the start IP Address for the range you want to test.
.PARAMETER EndAddress
    Specify the end IP Address for the range you want to test.
.EXAMPLE
    Test-IsIpAddressInRange -IpAddress 10.10.0.235 -StartAddress 10.10.0.0 -EndAddress 10.10.120.0

    Description
    -----------
    This will return True, since 10.10.0.235 is within the given Start and End addresses.
.NOTES
    Author: Matthew DeGarmo
    GitHub: https://github.com/matthewjdegarmo
#>
Function Test-IsIpAddressInRange() {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [System.String] $IpAddress,

        [Parameter(Mandatory)]
        [System.String] $StartAddress,

        [Parameter(Mandatory)]
        [System.String] $EndAddress
    )
    
    $ip = [System.Net.IPAddress]::Parse($IpAddress).GetAddressBytes()
    [array]::Reverse($ip)
    $ip = [System.BitConverter]::ToUInt32($ip, 0)

    $Start = [System.Net.IPAddress]::Parse($StartAddress).GetAddressBytes()
    [array]::Reverse($Start)
    $Start = [System.BitConverter]::ToUInt32($Start, 0)

    $End = [System.Net.IPAddress]::Parse($EndAddress).GetAddressBytes()
    [array]::Reverse($End)
    $End = [System.BitConverter]::ToUInt32($End, 0)

    $Start -le $ip -and $ip -le $End
}
#EndRegion Test-IsIpAddressInRange