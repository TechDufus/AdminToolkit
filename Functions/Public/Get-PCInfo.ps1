#Region Get-PCInfo

<#
.Synopsis
    Gather useful information from a remote PC.

.Description
    Returns useful informaion on the local endpoint or another.
.EXAMPLE
    PS> Get-PCInfo -ComputerName Computer1

    Description
    -----------
    This will generate information from the remote computer using CIM Instances.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
Function Get-PCInfo {
    [CmdletBinding()]
    Param (
        [string]$ComputerName = $env:ComputerName
    )

    try {
        $SystemEnclosure = Get-CimInstance win32_systemenclosure -computername $ComputerName -ErrorAction Stop
        $OS = Get-CimInstance Win32_OperatingSystem -Computername $ComputerName -ErrorAction Stop
    }
    catch {
        Write-Error "$($_.Exception.Message) - Line Number: $($_.InvocationInfo.ScriptLineNumber)"
        break
    }

    #Creating Hash table from variables
    $PCInfo = @{
        Manufacturer   = $SystemEnclosure.Manufacturer
        PCName         = $OS.CSName
        OS             = $OS.Caption
        Architecture   = $OS.OSArchitecture
        AssetTag       = $systemenclosure.serialnumber;
        OSVersion      = $OS.Version
        InstallDate    = $OS.InstallDate
        LastBootUpTime = $OS.LastBootUpTime
    }

    #Writing to Host
    Write-Host " "
    Write-Host "Computer Info" -Foregroundcolor Cyan
    Write-Host "If not run on a Dell machine AssetTag is the Serial Number" -Foregroundcolor Yellow

    #Display Hash Table
    $PCInfo.getenumerator() | Sort-Object -property name | Format-Table -autosize

    #Writing to Host
    Write-Host "Computer Disk Info" -Foregroundcolor Cyan

    #Display Drives
    Get-CimInstance win32_logicaldisk -filter "drivetype=3" -computer $ComputerName |
    Format-Table -Property DeviceID, Volumename, `
    @{Name = "SizeGB"; Expression = { [math]::Round($_.Size / 1GB) } }, `
    @{Name = "FreeGB"; Expression = { [math]::Round($_.Freespace / 1GB, 2) } }, `
    @{Name = "PercentFree"; Expression = { [math]::Round(($_.Freespace / $_.size) * 100, 2) } }

    #Writing to Host
    Write-Host "Network Information" -Foregroundcolor Cyan

    Get-CimInstance win32_networkadapterconfiguration -computer $ComputerName | Where-Object { $null -ne $_.IPAddress } |
    Select-Object IPAddress, DefaultIPGateway, DNSServerSearchOrder, IPSubnet, MACAddress, Caption, DHCPEnabled, DHCPServer, DNSDomainSuffixSearchOrder |
    Format-List
}
#EndRegion Get-PCInfo