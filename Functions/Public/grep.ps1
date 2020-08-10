!#/usr/bin/env pwsh

<#
.SYNOPSIS
    Basic version of the linux command `grep` on Windows.
.DESCRIPTION
    This is a windows version of the linux `grep` command. I still need to figure out how to NOT import this command when on a linux system.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
function grep {
    [CmdletBinding()]
    param(
        $regex
    )

    process {
        $_ | Where-Object { $_ -match $regex }
    }
}
