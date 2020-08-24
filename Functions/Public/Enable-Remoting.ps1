#Region Enable-Remoting

<#
.Synopsis
Enable PSRemoting via PSEXEC remotely.

.Description
This Command will enable PowerShell Remoting on a remote PC.

.EXAMPLE
PS> Enable-PSRemoting -computer PCName -username domain\username

Description
-----------
This will enable remoting and then prompt for credentials

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    Change Log:
    Version: 1.0 - Function Creation.

    This Function requires psexec. If you do not, download it with the sysinternals suite. Add psexec to one of your enviroment variable paths.
#>
Function Enable-Remoting {
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory)]
        [string] $Computer,
        [Parameter(Position = 1, Mandatory)]
        [string] $Username,
        [Parameter(Position = 2)]
        [SecureString] $Password
    )

    #Enabling PSRemoting
    PsExec.exe \\$Computer -s winrm.cmd quickconfig -q
    PsExec.exe \\$Computer -u $Username -p $Password powershell.exe cmd /c "enable-psremoting -force"

    try {
        Test-WSMan $Computer
    }
    catch {
        Write-Error "Failed to enable PSRemoting via PSEXEC"
    }
}
#EndRegion Enable-Remoting