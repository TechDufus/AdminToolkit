#!/usr/bin/env pwsh

#Dot source all functions in all ps1 files located in the module folder
$PublicFunctionsFiles = [System.IO.Path]::Combine($PSScriptRoot,"Functions","Public","*.ps1")
Get-ChildItem -Path $PublicFunctionsFiles -Exclude *.tests.ps1, *profile.ps1 |
ForEach-Object {
    try {
        . $_.FullName
    } catch {
        # Write-Warning "$($_.Exception.Message)"
    }
}

#This allows the Private functions to access the private ones, but the private ones are note exported in .psd1 file
$PrivateFunctionsFiles = [System.IO.Path]::Combine($PSScriptRoot,"Functions","Private","*.ps1")
Get-ChildItem -Path $PrivateFunctionsFiles -Exclude *.tests.ps1, *profile.ps1 |
ForEach-Object {
    try {
        . $_.FullName
    } catch {
        # Write-Warning "$($_.Exception.Message)"
    }
}

#Dor source all argument completer files for module
$ArgCompleterFunctionsFiles = [System.IO.Path]::Combine($PSScriptRoot,"Functions","ArgCompleter","*.ps1")
Get-ChildItem -Path $ArgCompleterFunctionsFiles -Exclude *.tests.ps1, *profile.ps1 |
ForEach-Object {
    try {
        . $_.FullName
    } catch {
        # Write-Warning "$($_.Exception.Message)"
    }
}


