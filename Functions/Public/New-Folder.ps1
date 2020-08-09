#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Easily create a new folder in the current working directory.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
function New-Folder($FolderName) {
    if (-Not (Test-Path -Path ".\$FolderName")) {
        New-Item -Name $FolderName -ItemType Directory
    }
    else {
        Write-Error "Folder $FolderName already exists at this location."
    }
}





