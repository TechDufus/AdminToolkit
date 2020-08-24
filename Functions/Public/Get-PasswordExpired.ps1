#Region Get-PasswordExpired

<#
.SYNOPSIS
    Generates list of ActiveDirectory users who have expired passwords

.DESCRIPTION
    Returns a list of Active Directory Accounts with expired passwords
.EXAMPLE
    PS> Get-PasswordExpired

    Description
    -----------
    This will get all of the current accounts with expired passwords.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
Function Get-PasswordExpired {
    [CmdletBinding()]
    param ()

    Search-ADAccount -PasswordExpired
}
#EndRegion Get-PasswordExpired