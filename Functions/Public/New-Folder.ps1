#!/usr/bin/env pwsh

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
    if (-Not (Test-Path -Path ".\$FolderName")) {
        New-Item -Name $FolderName -ItemType Directory
    }
    else {
        Write-Error "Folder $FolderName already exists at this location."
    }
}





