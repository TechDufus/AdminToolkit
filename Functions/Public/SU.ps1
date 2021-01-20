#Region SU

<#
.SYNOPSIS
    Windows version of the linux command `SU`
.DESCRIPTION
    Immitate SU on Linux. This creates new PoSH Session as an admin.
.EXAMPLE
    PS> su
    
    Description
    -----------
    Depending on what edition of powershell is running, this will start an elevated process.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit
#>
function su() {
    [CmdletBinding()]
    param ()
    switch ($($PSVersionTable.PSEdition)) {
        "Desktop" { Start-Process Powershell -Verb RunAs }
        "Core" { Start-Process Pwsh -Verb RunAs }
    }
}
#EndRegion SU