#Region Get-PublicIP

<#
.SYNOPSIS
    Generates your current Public IP Information

.DESCRIPTION
    Returns WhoIS public IP info for your location or any specified public IP. By Default, returns your current public IP info.

.PARAMETER IP
    Specify the IP Address to look up information for. This uses your current public IP by default.

.EXAMPLE
    PS> Get-PublicIP

    Description
    -----------
    Returns local Public IP Info

    Get-PublicIP

.Example
    PS> Get-PublicIP -IP 8.8.8.8
    
    Description
    -----------
    Returns Public IP Info for 8.8.8.8

    Get-PublicIP -IP 8.8.8.8

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit
#>
Function Get-PublicIP() {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0)]$IP
    )

    try {
        if ($IP) {
            $ipinfo = Invoke-RestMethod http://ipinfo.io/$IP/json
        }
        else {
            $ipinfo = Invoke-RestMethod http://ipinfo.io/json
        }
        [PSCustomObject]@{
            IP           = $ipinfo.ip
            City         = $ipinfo.city
            Region       = $ipinfo.region
            Country      = $ipinfo.country
            Coord        = $ipinfo.loc
            Organization = $ipinfo.org
            Postal       = $ipinfo.Postal
            TimeZone     = $ipinfo.timezone
        }
    }
    catch {
        Write-Error "$($_.Exception.Message)"
    }
}
#EndRegion Get-PublicIP