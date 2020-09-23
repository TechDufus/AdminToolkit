#Region New-Folder

<#
.SYNOPSIS
    Easily create a new folder in the current working directory.
.DESCRIPTION
    This will create a new directory in the current working directory.
.PARAMETER Name
    Spedify the name for the new folder.
.EXAMPLE
    PS> New-Folder Foobar
    
    Description
    -----------
    This will create a new folder 'Foobar' if there currently is not a folder of the same name.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
function New-Folder() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)]
        [string] $Name
    )

    process {
        New-Item $FolderName -ItemType Directory
    }
}
#EndRegion New-Folder
