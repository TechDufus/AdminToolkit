#Region Remove-Application

<#
.Synopsis
    Attempt to Uninstall an application.

.DESCRIPTION
    This command uninstalls an application. Good for when elevated privileges are needed from a user session.

.PARAMETER Application
    Specify the application name to delete.

.EXAMPLE
    Specify the installed application being uninstalled. The full application name must be used.

    Remove-AppName -Application 'App Name has spaces'
    
.EXAMPLE
    Find application using Get-Applications and pipe the correct item into Remove-Application.
    
    Get-Applications | Where-Object { $_.DisplayName -match 'vim' } | Remove-Application

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit

    Change Log:
    Version: 1.0 - Function Creation.
#>
Function Remove-Application {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, ValueFromPipeline)]
        $Application
    )
    Begin {}
    
    Process {
        if ($_ -is [PSCustomObject]) {
            $AppToRemove = $_
        }
        else {
            $AppToRemove = Get-Applications | Where-Object { $_.DisplayName -match $Application }
        }
        
        switch ($true) {
            { $AppToRemove.QuietUninstallString } {
                Write-Output "Running Quiet Uninstall String: $($AppToRemove.QuietUninstallString)"
                & $AppToRemove.QuietUninstallString
            }
            { $AppToRemove.UninstallString } {
                Write-Output "Running Uninstall String: $($AppToRemove.UninstallString)"
                & $AppToRemove.UninstallString
            }
            DEFAULT { Write-Error "No Uninstall String is provided for this application." }
        }
    }
}
#EndRegion Remove-Application
