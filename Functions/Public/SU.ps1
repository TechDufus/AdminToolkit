#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Windows version of the linux command `SU`
.DESCRIPTION
    Immitate SU on Linux. This creates new PoSH Session as an admin.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
function su() {
    switch ($($PSVersionTable.PSEdition)) {
        "Desktop" { Start-Process Powershell -Verb RunAs }
        "Core" { Start-Process Pwsh -Verb RunAs }
    }
}






