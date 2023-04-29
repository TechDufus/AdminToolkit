#Region grep
$DetectedOS = switch($true) {
    $IsWindows {'Windows'}
    $IsLinux   {'Linux'}
    $IsMacOS   {'MacOS'}
    DEFAULT    {'Windows'}
}

If ($DetectedOS -eq 'Windows') {

    <#
    .SYNOPSIS
        Basic version of the linux command `grep` on Windows.
    .DESCRIPTION
        This is a windows version of the linux `grep` command. I still need to figure out how to NOT import this command when on a linux system.
        This is basically a shorter `Select-String`, and does not support other grep flags as on a Linux system.
    .PARAMETER Regex
        Specify the regex pattern to filter for.
    .EXAMPLE
        Get-Process | grep powershell
        
        Description
        -----------
        This will filter the `Get-Process` output with the regex 'powershell'.
    .NOTES
        Author: Matthew J. DeGarmo
        Handle: @TechDufus

        You can either submit a [PR](https://github.com/TechDufus/AdminToolkit/pulls)
            or create an [Issue](https://github.com/TechDufus/AdminToolkit/issues/new)
            on this GitHub project at https://github.com/TechDufus/AdminToolkit
    #>
    Function grep() {
        param(
            $regex
        )

        process {
            $_ | Where-Object { $_ -match $regex }
        }
    }
}
#EndRegion grep
