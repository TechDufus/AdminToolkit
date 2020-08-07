<#
.SYNOPSIS
    Get the amount of time since the last boot-up sequence for a computer.
.DESCRIPTION
    This cmdlet uses Get-CimInstance to gather the .LastBootUpTime for the local or remote computer. 
    PowerShell 7 comes with a `Get-Uptime` cmdlet, so if called from PowerShell, it will simply call or invoke that cmdlet. otherwise when called from Windows Powershell, it will invoke a CimInstance.
.PARAMETER ComputerName
    Specify the remote computer to query using CIM.
.EXAMPLE
    PS> Get-PCUpTime

    Description
    -----------
    This will return the current UpTime value for the local computer.
.EXAMPLE
    PS> Get-PCUpTime Remote-Server

    Description
    -----------
    This will query `Remote-Server` for it's uptime data.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
function Get-PCUpTime() {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        $ComputerName
    )

    begin {
        $Version = $PSVersionTable.PSEdition
    }
    process {
        try {
            switch($Version) {
                'Desktop' {
                    if ($null -ne $ComputerName) {
                        $SplatMe = @{
                            ClassName = 'Win32_OperatingSystem'
                            ComputerName = $ComputerName}
                    } else {
                        $SplatMe = @{
                            ClassName = 'Win32_OperatingSystem'
                        }
                    }
                
                    $Now = Get-Date
                    $LastBootUpTime = (Get-CimInstance @SplatMe).LastBootUpTime
                    $Return = $Now - $LastBootUpTime | Select-Object Days,Hours,Minutes,Seconds,@{Name='Date';Expression={$LastBootUpTime}}
                    return $Return
                }
    
                'Core' {
                    if ($null -ne $ComputerName) {
                        $params = @{
                            ComputerName = $ComputerName
                            ScriptBlock = {Get-Uptime}
                        }
                        Invoke-Command @params
                    } else {
                        Get-Uptime
                    }
                }
    
                DEFAULT {}
            }
        } catch {
            Write-Error "$($_.Exception.Message)"
        }
    }
}






