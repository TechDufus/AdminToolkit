<#
.SYNOPSIS
    Generates list of ActiveDirectory users who have expired passwords

.DESCRIPTION
    Returns a list of Active Directory Accounts with expired passwords
    
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
Function Get-PasswordExpired {
    [CmdletBinding()]
    param ()

    Search-ADAccount -PasswordExpired | Select-Object name | Sort-Object name | Format-List
}



