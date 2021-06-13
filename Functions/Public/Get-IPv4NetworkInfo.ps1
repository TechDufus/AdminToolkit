#Region Get-IPv4NetworkInfo

<#
.SYNOPSIS
    Gets extended information about an IPv4 network.
.DESCRIPTION
    Gets Network Address, Broadcast Address, Wildcard Mask.
    and usable host range for a network given the
    IP address and Subnet Mask.

.PARAMETER IPAddress
IP Address of any ip within the network
Note: Exclusive from @CIDRAddress

.PARAMETER SubnetMask
Subnet Mask of the network.
Note: Exclusive from @CIDRAddress

.PARAMETER CIDRAddress
CIDR Notation of IP/Subnet Mask (x.x.x.x/y)
Note: Exclusive from @IPAddress and @SubnetMask

.PARAMETER IncludeIPRange
Switch parameter that defines whether or not the script will return an array
of usable host IP addresses within the defined network.
Note: This parameter can cause delays in script completion for larger subnets.

.EXAMPLE
Get-IPv4NetworkInfo -IPAddress 192.168.1.23 -SubnetMask 255.255.255.0

Get network information with IP Address and Subnet Mask

.EXAMPLE
Get-IPv4NetworkInfo -CIDRAddress 192.168.1.23/24

Get network information with CIDR Notation

.NOTES
    File Name  : Get-IPv4NetworkInfo.ps1
    Author     : Ryan Drane
    Date       : 5/10/16
    Requires   : PowerShell v3
.LINK
www.ryandrane.com
#>

Function Get-IPv4NetworkInfo() {
    [CmdletBinding()]
    Param(
        [Parameter(ParameterSetName = "IPandMask", Mandatory = $true)]
        [ValidateScript( { $_ -match [ipaddress]$_ })]
        [System.String]$IPAddress,

        [Parameter(ParameterSetName = "IPandMask", Mandatory = $true)]
        [ValidateScript( { $_ -match [ipaddress]$_ })]
        [System.String]$SubnetMask,

        [Parameter(ParameterSetName = "CIDR", Mandatory = $true)]
        [ValidateScript( { $_ -match '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/([0-9]|[0-2][0-9]|3[0-2])$' })]
        [System.String]$CIDRAddress,

        [Switch]$IncludeIPRange
    )

    # If @CIDRAddress is set
    if ($CIDRAddress) {
        # Separate our IP address, from subnet bit count
        $IPAddress, [int32]$MaskBits = $CIDRAddress.Split('/')

        # Create array to hold our output mask
        $CIDRMask = @()

        # For loop to run through each octet,
        for ($j = 0; $j -lt 4; $j++) {
            # If there are 8 or more bits left
            if ($MaskBits -gt 7) {
                # Add 255 to mask array, and subtract 8 bits
                $CIDRMask += [byte]255
                $MaskBits -= 8
            } else {
                # bits are less than 8, calculate octet bits and
                # zero out our $MaskBits variable.
                $CIDRMask += [byte]255 -shl (8 - $MaskBits)
                $MaskBits = 0
            }
        }

        # Assign our newly created mask to the SubnetMask variable
        $SubnetMask = $CIDRMask -join '.'
    }

    # Get Arrays of [Byte] objects, one for each octet in our IP and Mask
    $IPAddressBytes = ([ipaddress]::Parse($IPAddress)).GetAddressBytes()
    $SubnetMaskBytes = ([ipaddress]::Parse($SubnetMask)).GetAddressBytes()

    # Declare empty arrays to hold output
    $NetworkAddressBytes = @()
    $BroadcastAddressBytes = @()
    $WildcardMaskBytes = @()

    # Determine Broadcast / Network Addresses, as well as Wildcard Mask
    for ($i = 0; $i -lt 4; $i++) {
        # Compare each Octet in the host IP to the Mask using bitwise
        # to obtain our Network Address
        $NetworkAddressBytes += $IPAddressBytes[$i] -band $SubnetMaskBytes[$i]

        # Compare each Octet in the subnet mask to 255 to get our wildcard mask
        $WildcardMaskBytes += $SubnetMaskBytes[$i] -bxor 255

        # Compare each octet in network address to wildcard mask to get broadcast.
        $BroadcastAddressBytes += $NetworkAddressBytes[$i] -bxor $WildcardMaskBytes[$i]
    }

    # Create variables to hold our NetworkAddress, WildcardMask, BroadcastAddress
    $NetworkAddress = $NetworkAddressBytes -join '.'
    $BroadcastAddress = $BroadcastAddressBytes -join '.'
    $WildcardMask = $WildcardMaskBytes -join '.'

    # Now that we have our Network, Widcard, and broadcast information,
    # We need to reverse the byte order in our Network and Broadcast addresses
    [array]::Reverse($NetworkAddressBytes)
    [array]::Reverse($BroadcastAddressBytes)

    # We also need to reverse the array of our IP address in order to get its
    # integer representation
    [array]::Reverse($IPAddressBytes)

    # Next we convert them both to 32-bit integers
    $NetworkAddressInt = [System.BitConverter]::ToUInt32($NetworkAddressBytes, 0)
    $BroadcastAddressInt = [System.BitConverter]::ToUInt32($BroadcastAddressBytes, 0)

    #Calculate the number of hosts in our subnet, subtracting one to account for network address.
    $NumberOfHosts = ($BroadcastAddressInt - $NetworkAddressInt) - 1

    # Declare an empty array to hold our range of usable IPs.
    $IPRange = @()

    # If -IncludeIPRange specified, calculate it
    if ($IncludeIPRange) {
        # Now run through our IP range and figure out the IP address for each.
        For ($j = 1; $j -le $NumberOfHosts; $j++) {
            # Increment Network Address by our counter variable, then convert back
            # lto an IP address and extract as string, add to IPRange output array.
            $IPRange += [ipaddress]([convert]::ToDouble($NetworkAddressInt + $j)) | Select-Object -ExpandProperty IPAddressToString
        }
    }

    # Create our output object
    $obj = New-Object -TypeName psobject

    # Add our properties to it
    Add-Member -InputObject $obj -MemberType NoteProperty -Name "IPAddress"           -Value $IPAddress
    Add-Member -InputObject $obj -MemberType NoteProperty -Name "SubnetMask"          -Value $SubnetMask
    Add-Member -InputObject $obj -MemberType NoteProperty -Name "NetworkAddress"      -Value $NetworkAddress
    Add-Member -InputObject $obj -MemberType NoteProperty -Name "BroadcastAddress"    -Value $BroadcastAddress
    Add-Member -InputObject $obj -MemberType NoteProperty -Name "WildcardMask"        -Value $WildcardMask
    Add-Member -InputObject $obj -MemberType NoteProperty -Name "NumberOfHostIPs"     -Value $NumberOfHosts
    Add-Member -InputObject $obj -MemberType NoteProperty -Name "IPRange"             -Value $IPRange

    # Return the object
    return $obj
}
#EndRegion Get-IPv4NetworkInfo
