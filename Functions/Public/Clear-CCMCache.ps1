#Region Clear-CCMCache

<#
.SYNOPSIS
    Clear local CCM Cache.
.DESCRIPTION
    This command will clear the local or remote ccm cache.
.PARAMETER ComputerName
    Specify the remote system to connect to and clear.
.EXAMPLE
    PS> Clear-CCMCache

    Description
    -----------
    Clear the CCM Cache on the local system.
.EXAMPLE
    PS> Clear-CCMCache -ComputerName Some-Remote-PC

    Description
    -----------
    This will attempt to connect and clear the CCM Cache from the computer specified.
.EXAMPLE
    PS> Clear-CCMCache -ComputerName pc1,pc2,pc3,pc4,pc5

    Description
    -----------
    This will attempt to connect to each computer listed to clear the local CCM Cache.
.NOTES
    Author: Matthew J DeGarmo
#>
function Clear-CCMCache() {
    [CmdletBinding()]
    param(
        [Parameter()]
        [System.String[]] $ComputerName = $env:COMPUTERNAME
    )

    begin {}

    process {
        try {
            Invoke-Command -ComputerName $ComputerName -ScriptBlock {
                Write-Output "Clearing CCM Cache on $($env:COMPUTERNAME)"
                ## Initialize the CCM resource manager com object
                [__comobject]$CCMComObject = New-Object -ComObject 'UIResource.UIResourceMgr'
                ## Get the CacheElementIDs to delete
                $CacheInfo = $CCMComObject.GetCacheInfo().GetCacheElements()
                ## Remove cache items
                ForEach ($CacheItem in $CacheInfo) {
                    $null = $CCMComObject.GetCacheInfo().DeleteCacheElement([string]$($CacheItem.CacheElementID))
                }
            }
        } catch {
            Write-Error "$($_.Exception.Message)"
        }
    }

    end {}
}
#EndRegion Clear-CCMCache