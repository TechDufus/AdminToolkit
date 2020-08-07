<#
.SYNOPSIS
    This will both Install the latest release of PowerShell or update your current PowerShell.
.DESCRIPTION
    This one-liner is provided by [Tyler Leonhardt](https://github.com/TylerLeonhardt). I have added some parameters to help customize the install of the .MSI
.PARAMETER Preview
    Specifying this switch will install the latest preview version of PowerShell. Otherwise this will install / update the latest stable release.
.PARAMETER Quiet
    Specifying this switch will install or update quietly with no gui popup, taking all defaults of the install. You need to run as admin to use this switch.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
function Update-Powershell() {
    param(
        [switch] $Preview,
        [switch] $Quiet
    )
    if ($PSBoundParameters.ContainsKey('Preview')) { $PreviewOption = '-Preview' }
    if ($PSBoundParameters.ContainsKey('Quiet')) { $QuietOption = '-Quiet' }
    Invoke-Expression -Command "& {$(Invoke-RestMethod https://aka.ms/install-powershell.ps1)} -UseMSI $PreviewOption $QuietOption"
}






