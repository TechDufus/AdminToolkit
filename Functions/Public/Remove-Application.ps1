#Region Remove-Application
<#
.Synopsis
    Attempt to Uninstall an application.

.DESCRIPTION
    This command uninstalls an application. Good for when elevated privileges are needed from a user session.

.EXAMPLE
    Specify the installed application being uninstalled. The full application name must be used.

    Remove-AppName -AppName 'App Name has spaces'

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    Change Log:
    Version: 1.0 - Function Creation.
#>
Function Remove-Application {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]$AppName
    )

    WMIC.exe product where name="$AppName" call uninstall
}
#EndRegion Remove-Application