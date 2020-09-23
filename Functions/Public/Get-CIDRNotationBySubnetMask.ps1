#Region Get-CIDRNotationBySubnetMask

<#
.SYNOPSIS
    Quickly generate the CIDR "slash" notation for a given subnet mask.
.DESCRIPTION
    This will provide the CIDR value for a subnet mask. This function will also error if the subnet mask is not valid.
.PARAMETER SubnetMask
    Specify the subnet mask to generate the CIDR Notation for.
.EXAMPLE
    PS> Get-CIDRNotationBySubnetMask 255.255.255.0

    24
    Description
    -----------
    Providing the SubnetMask, this returns the correct CIDR abreviation. CIDR is used like this: 192.168.1.0/24
.NOTES
    Author: Matthew J. DeGarmo
    Site: https://matthewjdegarmo.github.io
#>
function Get-CIDRNotationBySubnetMask() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)]
        [String] $SubnetMask
    )
    $cidr = 0
    $octet = 0 
    $SubnetMask.split(".") | Foreach-Object {
        switch ($_) {
            255 { $cidr += 8 ; $CorrectSubnet += "$_." }
            254 { $cidr += 7 ; $CorrectSubnet += "$_." }
            252 { $cidr += 6 ; $CorrectSubnet += "$_." }
            248 { $cidr += 5 ; $CorrectSubnet += "$_." }
            240 { $cidr += 4 ; $CorrectSubnet += "$_." }
            224 { $cidr += 3 ; $CorrectSubnet += "$_." }
            192 { $cidr += 2 ; $CorrectSubnet += "$_." }
            128 { $cidr += 1 ; $CorrectSubnet += "$_." }
            0 { $cidr += 0 ; $CorrectSubnet += "$_." }
            default { 
                $SplitSubnet = $SubnetMask.Split('.')
                $SplitSubnet[$octet] = "[$($SplitSubnet[$octet])]"
                $ErrorSubnet = $SplitSubnet -join '.'
                Write-Error -Message "Invalid Subnet Mask value: `'$_`' in $ErrorSubnet" `
                    -Category InvalidArgument `
                    -RecommendedAction "Provide a proper SubnetMask" `
                    -ErrorAction Stop
                $BadMask = $true
            }
        }
        $octet++
    }
    if (-Not ($BadMask)) {
        $cidr
    }
}
#EndRegion Get-CIDRNotationBySubnetMask