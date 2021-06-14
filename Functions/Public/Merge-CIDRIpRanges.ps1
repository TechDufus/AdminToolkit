#Region Merge-CIDRIpRanges

<#
.SYNOPSIS
    Reduces a list of CIDR IP Ranges to a single list of ranges that do not overlap.
.DESCRIPTION
    Given a list of CIDR IP Ranges, this will remove CIDR IP Ranges that overlap / are nested within other ranges in the list.
    When an overlap is found, the CIDR Range that survives the filter is the larger range.

    EXAMPLE: If the provided list contains 3.134.215.0/24 and 3.132.0.0/14 ranges, the range that will be kept is 3.132.0.0/14 since it is the larger range and contains the other.
.PARAMETER CIDRAddresses
    Provide an array of CIDR IP Ranges (IP.Add.Re.SS/## format).
.EXAMPLE
    Merge-CIDRIpRanges -CIDRAddresses $TotalCIDRIps

    Description
    -----------
    This will remove any overlapping IP Ranges from your provided array of CIDR ranges in $TotalCIDRIps
.EXAMPLE
    Merge-CIDRIpRanges -CIDRAddresses (Get-AWSPublicIpAddressRange -Region us-east-2 | ? IpAddressFormat -eq 'Ipv4').IpPrefix

    Description
    -----------
    This AWS Function will return the entire AWS IpRange set for us-east-2. This function will remove any duplicate and overlapping ranges from this provided list.
.NOTES
    Author: Matthew DeGarmo
    GitHub: https://github.com/matthewjdegarmo
.LINK
    https://matthewjdegarmo.com
#>
Function Merge-CIDRIpRanges() {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [ValidateScript( { $_ -match '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/([0-9]|[0-2][0-9]|3[0-2])$' })]
        [System.String[]] $CIDRAddresses
    )

    Begin {
        #Region Get-Ipv4SubnetInfo
        Function Get-Ipv4SubnetInfo() {
            [CmdletBinding()]
            Param(
                [Parameter(ParameterSetName = "CIDR", Mandatory = $true)]
                [ValidateScript( { $_ -match '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/([0-9]|[0-2][0-9]|3[0-2])$' })]
                [System.String]$CIDRAddress
            )
        
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
                }
                else {
                    # bits are less than 8, calculate octet bits and
                    # zero out our $MaskBits variable.
                    $CIDRMask += [byte]255 -shl (8 - $MaskBits)
                    $MaskBits = 0
                }
            }
    
            # Assign our newly created mask to the SubnetMask variable
            $SubnetMask = $CIDRMask -join '.'
        
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

            [pscustomobject]@{
                IPAddress       = $IPAddress
                NetworkAddress   = $NetworkAddress
                BroadcastAddress = $BroadcastAddress
            }
        }
        #EndRegion Get-Ipv4SubnetInfo
        $CIDRAddresses = $CIDRAddresses | Select-Object -Unique
    }

    Process {
        [System.Collections.ArrayList]$RejectedIPs = @()

        $Index = 0
        $CIDRAddresses | ForEach-Object {
            $Index++
            $RootIP = $_
            #When we reach the last entry of the list, there is no nested loop to run, so we can simply end here.
            #Otherwise the nested compare will compare to itself, add to the reject list, and will NEVER survive, even its is a non-overlapping IP.
            If ($Index -eq ($CIDRAddresses.Count)) {
                If ($RootIP -notin $RejectedIPs) {
                    $RootIP
                    break
                }
            }
            $IpInfo = Get-Ipv4SubnetInfo -CIDRAddress $RootIP
            $ProgressPercent = ($Index / ($CIDRAddresses.count) * 100)
            $Percent = "$([math]::round($ProgressPercent,2))%"
            $Progress = @{
                Activity         = "Filtering Overlapping CIDR IP Ranges"
                Status           = "Examining IP: [$RootIP] - $Percent"
                CurrentOperation = "IP: $Index of $($CIDRAddresses.Count)"
                Id               = 1
                PercentComplete  = $ProgressPercent
            }
            Write-Progress @Progress
            Write-Debug "Beginning compare of: [$RootIP]"
            [System.Collections.ArrayList]$Reject = @()
            [System.Collections.ArrayList]$Survivor = @()
            $NestedIndex = 0
            $CIDRAddresses[$Index..$($CIDRAddresses.Count - 1)] | ForEach-Object {
                $NestedIndex++
                $CompareIP = $_
                Write-Debug "Comparing [$RootIP] to [$CompareIP]"
                $CompareIPInfo = Get-Ipv4SubnetInfo -CIDRAddress $CompareIP
                $NestedProgressPercent = ($NestedIndex / $($CIDRAddresses.Count - 1) * 100)
                $Progress = @{
                    Activity         = "Comparing [$RootIP] to full array of CIDR Ranges"
                    Status           = "Comparing: [$RootIP] to [$CompareIP]"
                    CurrentOperation = "IP: $NestedIndex of $($CIDRAddresses.Count - $Index)"
                    ParentId         = 1
                    PercentComplete  = $NestedProgressPercent
                }
                Write-Progress @Progress

                $RangeCompareRootToNested = @{
                    IPAddress    = $CompareIPInfo.IpAddress
                    StartAddress = $IPInfo.NetworkAddress
                    EndAddress   = $IPInfo.BroadcastAddress
                }

                If (Test-IsIpAddressInRange @RangeCompareRootToNested) {
                    Write-Verbose "$($CompareIP) is inside range $($RootIP)"
                    $null = $Survivor.Add($RootIP)
                    $null = $Reject.Add($CompareIP)
                }

                $RangeCompareNestedToRoot = @{
                    IPAddress    = $IPInfo.IpAddress
                    StartAddress = $CompareIPInfo.NetworkAddress
                    EndAddress   = $CompareIPInfo.BroadcastAddress
                }

                If (Test-IsIpAddressInRange @RangeCompareNestedToRoot) {
                    Write-Verbose "$($RootIP) is inside range $($CompareIP)"
                    $null = $Survivor.Add($CompareIP)
                    $null = $Reject.Add($RootIP)
                }
            }

            If ($Reject) {
                Foreach ($Ip in @($Reject | Select-Object -Unique)) {
                    Write-Verbose "Adding Reject: $Ip"
                    $null = $RejectedIPs.Add($Ip)
                }
            }
            If ($Survivor) {
                Foreach ($Ip in ($Survivor | Select-Object -Unique)) {
                    If ($IP -notin $RejectedIPs) {
                        Write-Debug "[$IP] not in [$RejectedIPs]"
                        $IP
                    }
                }
            }
            Else {
                If ($RootIP -notin $RejectedIPs) {
                    $RootIP
                }
            }
        }
    }

    End {}
}
#EndRegion Merge-CIDRRanges
