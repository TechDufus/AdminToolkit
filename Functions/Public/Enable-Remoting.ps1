#Region Enable-Remoting

<#
.Synopsis
Enable PSRemoting via PSEXEC remotely.

.Description
This Command will enable PowerShell Remoting on a remote PC.

.PARAMETER ComputerName
    Specify a remote computer to run against.

.PARAMETER Username
    Specify a username to use to make the remote connection.

.PARAMETER Password
    Specify the respective password to match the Username provided.
    
.EXAMPLE
PS> Enable-PSRemoting -computer PCName -username domain\username

Description
-----------
This will enable remoting and then prompt for credentials

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit

    Change Log:
    Version: 1.0 - Function Creation.

    This Function requires psexec. If you do not, download it with the sysinternals suite. Add psexec to one of your enviroment variable paths.
#>
Function Enable-Remoting() {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory)]
        [string] $ComputerName,
        [Parameter(Position = 1, Mandatory)]
        [string] $Username,
        [Parameter(Position = 2)]
        [SecureString] $Password
    )

    #Enabling PSRemoting
    PsExec.exe \\$ComputerName -s winrm.cmd quickconfig -q
    PsExec.exe \\$ComputerName -u $Username -p $Password powershell.exe cmd /c "enable-psremoting -force"

    try {
        Test-WSMan $Computer
    }
    catch {
        Write-Error "Failed to enable PSRemoting via PSEXEC"
    }
}
#EndRegion Enable-Remoting