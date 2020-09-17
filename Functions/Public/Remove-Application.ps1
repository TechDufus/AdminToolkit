#Region Remove-Application

<#
.Synopsis
    Attempt to Uninstall an application.

.DESCRIPTION
    This command uninstalls an application. Good for when elevated privileges are needed from a user session.

.EXAMPLE
    Specify the installed application being uninstalled. The full application name must be used.

    Remove-AppName -Application 'App Name has spaces'
    
.EXAMPLE
    Find application using Get-Applications and pipe the correct item into Remove-Application.
    
    Get-Applications | Where-Object { $_.DisplayName -match 'vim' } | Remove-Application

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    Change Log:
    Version: 1.0 - Function Creation.
#>
Function Remove-Application {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory,ValueFromPipeline)]
        $Application
    )
    Begin {}
    
    Process {
        if ($_ -is [PSCustomObject]) {
            $AppToRemove = $_
        } else {
            $AppToRemove = Get-Applications | Where-Object {$_.DisplayName -match $Application}
        }
        
        switch ($true) {
            {$AppToRemove.QuietUninstallString} { & $AppToRemove.QuietUninstallString}
            {$AppToRemove.UninstallString} { & $AppToRemove.UninstallString}
            DEFAULT { Write-Error "No Uninstall String is provided for this application." }
        }
    }
    #WMIC.exe product where name="$AppName" call uninstall
}
#EndRegion Remove-Application
