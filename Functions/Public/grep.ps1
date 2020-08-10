#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Basic version of the linux command `grep` on Windows.
.DESCRIPTION
    This is a windows version of the linux `grep` command. I still need to figure out how to NOT import this command when on a linux system.
    This is basically a shorter `Select-String`, and does not support other grep flags as on a Linux system.
.EXAMPLE
    Get-Process | grep powershell
    
    Description
    -----------
    This will filter the `Get-Process` output with the regex 'powershell'.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
function grep {
    # [CmdletBinding()] # This is to pass the advanced function pester tests.
    param(
        $regex
    )

    process {
        $_ | Where-Object { $_ -match $regex }
    }
}
