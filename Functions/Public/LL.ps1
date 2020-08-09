#!/usr/bin/env pwsh

<#
.SYNOPSIS
    This is a colorized version of Get-ChildItem (dir, ls).
.DESCRIPTION
    This function will change the color of object names using Get-ChildItem based on the object type or extension.
    You can define more extensions and their associated colors if you wish.
.NOTES
    Author: Matthew J. DeGarmo
    Site: https://matthewjdegarmo.github.io
#>
function LL {
    param ($dir = ".", $all = $false) 
    $originalForeground = $host.ui.rawui.foregroundColor 
    if ( $all ) { $toList = Get-ChildItem -force $dir }
    else { $toList = Get-ChildItem $dir }
    foreach ($Item in $toList) { 
        Switch ($Item.Extension) {
            ".Exe" { $host.ui.rawui.foregroundColor = "Yellow" } 
            ".cmd" { $host.ui.rawui.foregroundColor = "Red" } 
            ".lnk" { $host.ui.rawui.foregroundColor = "Red" }
            ".msh" { $host.ui.rawui.foregroundColor = "Red" } 
            ".vbs" { $host.ui.rawui.foregroundColor = "Red" }
            ".ps1" { $host.ui.rawui.foregroundColor = "Cyan" }
            ".psm1" { $host.ui.rawui.foregroundColor = "Cyan" }
            ".psd1" { $host.ui.rawui.foregroundColor = "Cyan" }
            ".ps1xml" { $host.ui.rawui.foregroundColor = "Cyan" }
            ".txt" { $host.ui.rawui.foregroundColor = "DarkCyan" }
            ".xml" { $host.ui.rawui.foregroundColor = "Magenta" }
            ".cvs" { $host.ui.rawui.foregroundColor = "Magenta" }
            ".doc" { $host.ui.rawui.foregroundColor = "Magenta" }
            ".csv" { $host.ui.rawui.foregroundColor = "Magenta" }
            ".bat" { $host.ui.rawui.foregroundColor = "Yellow" }
            ".docx" { $host.ui.rawui.foregroundColor = "Magenta" }
            ".pdf" { $host.ui.rawui.foregroundColor = "Magenta" }
            ".xls" { $host.ui.rawui.foregroundColor = "Magenta" }
            ".xlsx" { $host.ui.rawui.foregroundColor = "Magenta" }
            ".log" { $host.ui.rawui.foregroundColor = "DarkCyan" }
            Default { $host.ui.rawui.foregroundColor = $originalForeground } 
        } 
        if ($item.Mode.StartsWith("d")) { $host.ui.rawui.foregroundColor = "Green" }
        $item 
    }  
    $host.ui.rawui.foregroundColor = $originalForeground 
}





