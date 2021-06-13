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
.NOTES
    Author: Matthew DeGarmo
    GitHub: https://github.com/matthewjdegarmo
#>
Function Merge-CIDRIpRanges() {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [System.String[]] $CIDRAddresses
    )

    Begin {
        $CIDRAddresses = $CIDRAddresses | Select-Object -Unique
    }

    Process {
        [System.Collections.ArrayList]$RejectedIPs = @()
        [System.Collections.ArrayList]$SurvivingIPs = @()

        $Index = 0
        $CIDRAddresses | ForEach-Object {
            $Index++
            # If ($Index -eq ($CIDRAddresses.Count - 1)) { continue }
            $RootIP = $_
            $IpInfo = Get-IPv4NetworkInfo -CIDRAddress $_

            $ProgressPercent = ($Index / ($CIDRAddresses.count) * 100)
            $Percent = "$([math]::round($ProgressPercent,2))%"

            $Progress = @{
                Activity = "Filtering Overlapping CIDR IP Ranges"
                Status = "Examining IP: [$RootIP] - $Percent"
                CurrentOperation = "IP: $Index of $($CIDRAddresses.Count)"
                Id = 1
                PercentComplete = $ProgressPercent
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
                $CompareIPInfo = Get-IPv4NetworkInfo -CIDRAddress $_
                $NestedProgressPercent = ($NestedIndex / $($CIDRAddresses.Count - 1) * 100)
                $Progress = @{
                    Activity = "Comparing [$RootIP] to full array of CIDR Ranges"
                    Status = "Comparing: [$RootIP] to [$CompareIP]"
                    CurrentOperation = "IP: $NestedIndex of $($CIDRAddresses.Count - $Index)"
                    ParentId = 1
                    PercentComplete = $NestedProgressPercent
                }
                Write-Progress @Progress

                $RangeCompareRootToNested = @{
                    IPAddress    = $CompareIPInfo.IpAddress
                    StartAddress = $IPInfo.NetworkAddress
                    EndAddress   = $IPInfo.BroadcastAddress
                }

                If (IsIpAddressInRange @RangeCompareRootToNested) {
                    Write-Verbose "$($CompareIP) is inside range $($RootIP)"
                    $null = $Survivor.Add($RootIP)
                    $null = $Reject.Add($CompareIP)

                }

                $RangeCompareNestedToRoot = @{
                    IPAddress    = $IPInfo.IpAddress
                    StartAddress = $CompareIPInfo.NetworkAddress
                    EndAddress   = $CompareIPInfo.BroadcastAddress
                }

                If (IsIpAddressInRange @RangeCompareNestedToRoot) {
                    Write-Verbose "$($RootIP) is inside range $($CompareIP)"
                    $null = $Survivor.Add($CompareIP)
                    $null = $Reject.Add($RootIP)
                }
            }

            If ($Survivor -or $Reject) {
                Foreach ($Ip in @($Survivor | Select-Object -Unique)) {
                    Write-Verbose "Adding Survivor: $Ip"
                    $null = $SurvivingIPs.Add($Ip)
                }
                Foreach ($Ip in @($Reject | Select-Object -Unique)) {
                    Write-Verbose "Adding Reject: $Ip"
                    $null = $RejectedIPs.Add($Ip)
                }
            } Else {
                Write-Verbose "No Conflict: $($RootIP)"
                $null = $SurvivingIPs.Add($RootIP)
            }
        }
        Compare-Object $SurvivingIPs $RejectedIPs -PassThru | Where-Object { $_.SideIndicator -eq '<=' }
    }

    End {}
}
#EndRegion Merge-CIDRRanges
