#Region Update-PowerShell

<#
.SYNOPSIS
    This will both Install the latest release of PowerShell or update your current PowerShell.
.DESCRIPTION
    This one-liner is provided by [Tyler Leonhardt](https://github.com/TylerLeonhardt). I have added some parameters to help customize the install of the .MSI
.PARAMETER Preview
    Specifying this switch will install the latest preview version of PowerShell. Otherwise this will install / update the latest stable release.
.PARAMETER Quiet
    Specifying this switch will install or update quietly with no gui popup, taking all defaults of the install. You need to run as admin to use this switch.
.EXAMPLE
    PS> Update-Powershell -Preview
    
    Description
    -----------
    This will update or install PowerShell with the latest Preview release.
.EXAMPLE
    PS> Update-Powershell -Quiet
    
    Description
    -----------
    This will update or install the latest General Release version of PowerShell.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit
#>
Function Update-PowerShell() {
    [CmdletBinding()]
    param(
        [switch] $Preview,
        [switch] $Quiet
    )

    Begin {
        $wid = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $prp = new-object System.Security.Principal.WindowsPrincipal($wid)
        $adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator
        $IsAdmin = $prp.IsInRole($adm)
    }

    Process {
        If ($PSVersionTable.PSVersion.Major -ge 6) {
            Write-Warning "This script is not compatible with PowerShell 6 or greater."
            Write-Warning "Please run [$($myinvocation.mycommand)] from Windows PowerShell"
            if ($PSBoundParameters.ContainsKey('Quiet')) {
                Write-Warning "You specified [-Quiet]. Ensure you launch Windows Powershell AS ADMIN for this to function properly."
            }
        } Else {
            if ($PSBoundParameters.ContainsKey('Preview')) { $PreviewOption = '-Preview' }
            if ($PSBoundParameters.ContainsKey('Quiet')) {
                If ($IsAdmin) {
                    $QuietOption = '-Quiet'
                }
                Write-Warning "[$($myinvocation.mycommand)]: You must be running as an Administrator to specify the [-Quiet] option."
                Write-Warning "[$($myinvocation.mycommand)]: Running without [-Quiet]"
            }
            Invoke-Expression -Command "& {$(Invoke-RestMethod https://aka.ms/install-powershell.ps1)} -UseMSI $PreviewOption $QuietOption"
        }
    }

    End {}
}
#EndRegion Update-PowerShell