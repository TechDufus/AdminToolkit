#Region Get-WindowsBuild

<#
.SYNOPSIS
    Gets Windows Build information.
.DESCRIPTION
    This will query the local PC OR an array of remote PC's 
.PARAMETER ComputerName
    Specify the remote computer to query.
.INPUTS
    System.String[]
        You must specify the value for Credential. You cannot pipe a value to this function.
.OUTPUTS
    None
        There are no outputs.
.EXAMPLE
    PS> ConnectTeams
    
    Description
    -----------
    This will attempt a connection to portal.office.com. This will prompt you for account information like what password to use.
.EXAMPLE
    PS> ConnectTeams -Credential 'SomeAccount@Email.com'
    Description
    -----------
    This will attempt a connection to portal.office.com. This will prompt you for account information like what password to use.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/HelpDesk/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk
#>
function Get-WindowsBuild() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            ValueFromPipeline = $true
        )]
        [string[]]$ComputerName = $env:COMPUTERNAME
    )

    begin {
        $Table = New-Object System.Data.DataTable
        $Table.Columns.AddRange(@("ComputerName", "Windows Edition", "Version", "OSBuild"))
    }

    process {
        Foreach ($Computer in $ComputerName) {
            $Code = {
                $ProductName = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name ProductName).ProductName
                try {
                    $Version = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name ReleaseID -ErrorAction Stop).ReleaseID
                }
                catch {
                    $Version = "N/A"
                }
                $CurrentBuild = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name CurrentBuild).CurrentBuild
                $UBR = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name UBR).UBR
                $OSVersion = $CurrentBuild + "." + $UBR
    
                $TempTable = New-Object System.Data.DataTable
                $TempTable.Columns.AddRange(@("ComputerName", "Windows Edition", "Version", "OSBuild"))
                [void]$TempTable.Rows.Add($env:COMPUTERNAME, $ProductName, $Version, $OSVersion)
            
                return $TempTable
            }
    
            if ($Computer -eq $env:COMPUTERNAME) {
                $Result = Invoke-Command -ScriptBlock $Code
                [void]$Table.Rows.Add($Result.Computername, $Result.'Windows Edition', $Result.Version, $Result.'OSBuild')
            }
            else {
                if (Test-Connection $Computer -count 1 -ErrorAction SilentlyContinue) {
                    try {
                        $Result = Invoke-Command -ComputerName $Computer -ScriptBlock $Code -ErrorAction Stop
                        [void]$Table.Rows.Add($Result.Computername, $Result.'Windows Edition', $Result.Version, $Result.'OSBuild')
                    }
                    catch {
                        $_
                    }
                }
                else {
                    [void]$Table.Rows.Add($Computer, "OFFLINE", "OFFLINE", "OFFLINE")
                }
            }
        }
    }
    end {
        Return $Table
    }
}
#EndRegion Get-WindowsBuild