#Region Get-FileOwner

<#
.Synopsis
    Display the owner of an item(s)

.Description
    This Function lists file owners within a given path

.PARAMETER Path
    Specify the file / directory path to query.

.PARAMETER Recursive
    Search recursively.

.Example
    PS> Get-FileOwner C:\Users

    Description
    -----------
    This will list file owners recursively for this directory.

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
Function Get-FileOwner {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string] $Path,

        [switch]$Recursive
    )

    $LastWrite = @{
        Name       = 'Last Write Time'
        Expression = { $_.LastWriteTime.ToString('u') }
    }
    $Owner = @{
        Name       = 'File Owner'
        Expression = { (Get-Acl $_.FullName).Owner }
    }
    $HostName = @{
        Name       = 'Host Name'
        Expression = { $env:COMPUTERNAME }
    }

    Get-ChildItem @PSBoundParameters |
    Select-Object $HostName, $Owner, Name, Directory, $LastWrite, Length
}
#EndRegion Get-FileOwner