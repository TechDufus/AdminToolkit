#Region PSRemote

<#
.SYNOPSIS
    Starts an Enter-PSSession with the specified Server.
.DESCRIPTION
    PSRemote will attempt to enter a PSSession with a specified host with a specified account. If no Credential is specified, it will use the currently signed in account to connect.
.PARAMETER ComputerName
    This parameter specifies what host to attempt an Enter-PSSession with.
.PARAMETER Credential
    This parameter is used to change the current account for the PSSession.
.INPUTS
    System.String[]
        You must specify the value for Computername. You cannot pipe a value to this function.
.OUTPUTS
    None
        There are no outputs except for Write-Host messages.
.EXAMPLE
    PS> PSRemote -ComputerName Computer1 -Credential matthewjd
    
    Description
    -----------
    This will attempt to start a PSSession with Computer1 as matthewjd. This will prompt for a password for matthewjd.
.EXAMPLE
    PS> PSRemote Computer1 -IncludeModule AdminToolkit
    Description
    -----------
    This will use the currently signed in account to connect to attempt a connection with Computer1 and import the module Helpdesk.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
    
    Change Log:
    Version: 2.0 - Added -IncludeModule parameter. This will allow you to import a local module into your remote session.
    Version: 1.0 - Function Creation.
#>
function PSRemote() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$ComputerName,
        [Parameter(Mandatory = $false, Position = 1)]
        [PSCredential]$Credential,
        [Parameter(Mandatory = $false)]
        [string[]]$IncludeModule,
        [Parameter(Mandatory = $false)]
        [string]$IncludeProfile
    )

    begin {
        function Import-ModuleRemotely {
            Param (
                [string] $moduleName,
                [System.Management.Automation.Runspaces.PSSession] $session
            )
        
            Import-Module $moduleName -ErrorAction SilentlyContinue
        
            $Script = @"
            if (get-module $moduleName)
            {
                remove-module $moduleName;
            }
        
            New-Module -Name $moduleName { $($(Get-Module $moduleName).Definition) } | Import-Module
"@
        
            Invoke-Command -Session $Session -ScriptBlock {
                Param($Script)
                . ([ScriptBlock]::Create($Script))
                #Get-Module 
            } -ArgumentList $Script
        }
    }

    process {
        try {
            if ($Credential) {
                $Session = New-PSSession -ComputerName $ComputerName -Credential $credential -ErrorAction Stop
            }
            else {
                $Session = New-PSSession -ComputerName $ComputerName -ErrorAction Stop
            }
            if ($PSBoundParameters.ContainsKey('IncludeProfile')) {
                Invoke-Command -FilePath $IncludeProfile -Session $Session -ErrorAction Stop
            }
            if ($IncludeModule) {
                foreach ($Module in $IncludeModule) {
                    Import-ModuleRemotely -moduleName $Module -session $Session
                }
            }
            Enter-PSSession -Session $Session -ErrorAction Stop
        }
        catch {
            Write-Error "$($_.Exception.Message) - Line Number: $($_.InvocationInfo.ScriptLineNumber)"
        }
    }
}
#EndRegion PSRemote