#Region Get-PCUpTime

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
    Handle: @TechDufus

    You can either submit a [PR](https://github.com/TechDufus/AdminToolkit/pulls)
        or create an [Issue](https://github.com/TechDufus/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/TechDufus/AdminToolkit
#>
Function Get-PCUpTime() {
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
                    $LastBootUpTime = (Get-CimInstance @SplatMe -ErrorAction Stop).LastBootUpTime
                    $Return = $Now - $LastBootUpTime
                    return $Return
                }
    
                'Core' {
                    if ($null -ne $ComputerName) {
                        $PCFunctionDefinition = Get-Definition Get-PCUpTime
                        $Script = @"
                        $PCFunctionDefinition
                        Get-PCUpTime
"@
                        $ScriptBlock = {
                            param ($Script)
                            . ([ScriptBlock]::Create($Script))
                        }
                        $params = @{
                            ComputerName = $ComputerName
                            ScriptBlock = $ScriptBlock
                            ArgumentList = $Script
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
#EndRegion Get-PCUpTime
