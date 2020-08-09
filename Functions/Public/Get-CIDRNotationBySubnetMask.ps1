#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Quickly generate the CIDR "slash" notation for a given subnet mask.
.DESCRIPTION
    This will provide the CIDR value for a subnet mask. This function will also error if the subnet mask is not valid.
.EXAMPLE
    PS> Get-CIDRNotationBySubnetMask 255.255.255.0

    24
    Description
    -----------
    Providing the SubnetMask, this returns the correct CIDR abbreviation. CIDR is used like this: 192.168.1.0/24
.NOTES
    Author: Matthew J. DeGarmo
    Site: https://matthewjdegarmo.github.io
#>
function Get-CIDRNotationBySubnetMask([string]$SubnetMask) {
    $cidr = 0
    $SubnetMask.split(".") | Foreach-Object {
        switch ($_) {
            255 { $cidr += 8 }
            254 { $cidr += 7 }
            252 { $cidr += 6 }
            248 { $cidr += 5 }
            240 { $cidr += 4 }
            224 { $cidr += 3 }
            192 { $cidr += 2 }
            128 { $cidr += 1 }
            0 { $cidr += 0 }
            default { 
                Write-Error "Invalid Subnet Mask value: `'$_`'"
                $BadMask = $true
            }
        }
    }
    if (-Not ($BadMask)) {
        return $cidr
    }
}



