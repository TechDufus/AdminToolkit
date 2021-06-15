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
    Author: Christian Seidlitz
    Co-Author: Matthew DeGarmo
    GitHub: https://github.com/SeidChr
.LINK
    GitHub: https://github.com/SeidChr
#>
Function Merge-CIDRIpRanges() {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [ValidateScript( { $_ -match '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/([0-9]|[0-2][0-9]|3[0-2])$' })]
        [System.String[]] $CIDRAddresses
    )

    Begin {}

    Process {
        $sortedRanges = $CIDRAddresses | Foreach-Object {
            $range = $_
            $mask, [int]$bits = $range.Split('/')
            $bitMask = $mask -split '\.' | ForEach-Object -Begin { 
                [long]$address = 0
            } -Process { 
                $address = $address -shl 8
                $address += [int]$_
                # Write-Host $_ $address
            } -End { 
                $address
            }
            $bitMaskString = [convert]::tostring($address, 2).PadLeft(32,'0').Substring(0, $bits)
            [PSCustomObject]@{
                Range = $range
                Mask = $mask
                Bits = $bits
                BitMaks = $bitMask
                BitMaskString = $bitMaskString
                Subrange = $false
            }
        } | Sort-Object -Property Bits, BitMaskString -Unique
        $linkedList = [System.Collections.Generic.LinkedList[psobject]]::new()
        foreach ($range in $sortedRanges) {
            $linkedList.AddLast($range) *> $null
        }
        $outerCurrent = $linkedList.First
        $Index = 0
        while ($outerCurrent) {
            $Index++
            $ProgressPercent = ($Index / ($CIDRAddresses.Count) * 100)
            $Progress = @{
                Activity         = "Filtering Overlapping CIDR IP Ranges"
                Status           = "Examining.."
                CurrentOperation = "IP: $Index of $($CIDRAddresses.Count)"
                Id               = 1
                PercentComplete  = $ProgressPercent
            }
            Write-Progress @Progress
            $master = $outerCurrent.Value
            $innerCurrent = $outerCurrent.Next
            while ($innerCurrent) {
                $slave = $innerCurrent.Value
                $next = $innerCurrent.Next
                if ($slave.BitMaskString.StartsWith($master.BitMaskString)) {
                    $linkedList.Remove($innerCurrent)
                }
                $innerCurrent = $next
            }
            $outerCurrent = $outerCurrent.Next
        }
        $LinkedList.Range
    }

    End {}
}
#EndRegion Merge-CIDRRanges
