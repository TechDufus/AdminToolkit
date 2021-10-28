#Region Get-RebootLogs

<#
.SYNOPSIS
    Get the System Event logs for reboot ID 1074.
.DESCRIPTION
    This will pull system event logs for the local or remote computer.
.PARAMETER ComputerName
    Specify a remote computer to pull logs from.
.EXAMPLE
    PS> Get-RebootLogs

    Description
    -----------
    This will generate a list of all System Reboot log events with ID 1074 on the local system.
.EXAMPLE
    PS> Get-RebootLogs -ComputerName Some-Remote-Computer | Select -First 5

    Description
    -----------
    This will get the System Reboot logs from `Some-Remote-Computer` and only show the first 5 results.
.NOTES
    Author: Matthew J. DeGarmo
    Site: https://matthewjdegarmo.com

    You can either submit a [PR](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit
#>
function Get-RebootLogs() {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string] $ComputerName = $env:COMPUTERNAME,

        [Parameter()]
        [int] $MaxEvents
    )
    begin {}
    
    process {
        try {
            $params = @{
                FilterHashTable = @{
                    LogName = 'System'
                    ID = '1074'
                }
                ComputerName = $ComputerName.ToUpper()
                ErrorAction  = 'SilentlyContinue'
                Verbose      = $VerbosePreference
            }
            If ($MaxEvents) {
                $params['MaxEvents'] = $MaxEvents
            }
            Write-Verbose "Gathering $($params.LogName) logs from $($params.ComputerName) with ID 1074."
            Get-WinEvent @params | Where-Object { $_.ID -eq '1074' }
        }
        catch {
            Write-Error "$($_.Exception.Message)"
        }
    }

    end {}
}
#EndRegion Get-RebootLogs