#Region New-Folder

<#
.SYNOPSIS
    Easily create a new folder in the current working directory.
.DESCRIPTION
    This will create a new directory in the current working directory.
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
        [Parameter(Mandatory,Position=0)]
        [string] $FolderName
    )
    Write-Verbose "Checking to see if folder ``$FolderName`` exists at $(Get-Location)"
    if (-Not (Test-Path -Path ".\$FolderName")) {
        Write-Verbose "Folder ``$FolderName`` does not exist. Creating..."
        New-Item -Name $FolderName -ItemType Directory
    }
    else {
        Write-Error "Folder ``$FolderName`` already exists at $(Get-Location)."
    }
}
#EndRegion New-Folder
