<#
.SYNOPSIS
    Basic version of the linux command `grep` on Windows.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
function grep {
    param(
        $regex
    )

    process {
        $_ | Where-Object { $_ -match $regex }
    }
}



