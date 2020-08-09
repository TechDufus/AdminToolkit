#!/usr/bin/env pwsh

<#
.SYNOPSIS
    This function performs a copy of a specified object recursively to a specified location.
.DESCRIPTION
    This function is a glorified Copy-Item in that it will show progress data. If moving 10,000 files that equal 2GB in size, it will show you what file you are currently on as well as how much data has been moved / what is left using Write-Progress.
.PARAMETER Source
    Source should specify the object to be copied by name. This value must be the FullPath and cannot be shortened. An example would be if you were in the C:\Scripts directory, you could not specify '.\TestFile.ps1' as the source location, you must specify 'C:\Scripts\TestFile.ps1' in this case.
.PARAMETER Destination
    Destination should specify the target location of the specified Source by name. This value must be the FullPath and cannot be shortened. An example would be if you were in the C:\Scripts directory, you could not specify '.\TestFile.ps1' as the Destination location, you must specify 'C:\Scripts\TestFile.ps1' in this case
.INPUTS
    System.String[]
        This function does not accept pipeline data. The values for all parameters must be specified.
.OUTPUTS
    None
        This function does not produce output except for the Write-Progress data.
.EXAMPLE
    PS>Copy-WithProgress -Source "C:\Scripts\TestFile.ps1" -Destination "C:\Temp\TestFile.ps1"
    Description
    -----------
    This will copy the source file to the file specified in Destination. Note that the filename for Destination can be anything and does not have to match the original.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
function Copy-WithProgress() {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)]
        $Source,
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 1)]
        $Destination
    )

    Write-Progress -Activity "Gathering data from $Source"
    $Source = $Source.tolower()
    $Destination = $Destination.tolower()
    $Filelist = Get-Childitem $Source -Recurse
    $Total = $Filelist.count
    $Position = 0
    $Size = ($Filelist | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
    
    Write-Progress -Activity "Gathering data from $Source" -Completed
    foreach ($File in $Filelist) {
        switch ($Size) {
            { $_ -ge '1000000000' } { $TotalSize = "{0:N2} GB" -f ($_ / 1GB) }
            { ($_ -lt '1000000000') -and ($_ -ge '10000000') } { $TotalSize = "{0:N2} MB" -f ($_ / 1MB) }
            { $_ -lt '1000000' } { $TotalSize = "{0:N2} KB" -f ($_ / 1KB) }
        }

        $FileSize = ($File | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
        $Filename = $File.Fullname.ToLower().Replace($Source, '')
        $DestinationFile = ($Destination + $Filename)
        $Position++
        $Percent = [int]$(($Position / $Total) * 100)
        Write-Progress -Activity "Copying data from '$Source' to '$Destination'" -Status "Copying File $Position of $total -  $TotalSize remaining..." -PercentComplete (($Position / $total) * 100) -CurrentOperation "$Percent% complete"
        #$null = New-Item -Name $File.FullName -Path $DestinationFile -ItemType File -Force
        Copy-Item $File.FullName -Destination $DestinationFile -Force -ErrorAction SilentlyContinue -Container | Out-Null
        $Size = ($Size - $FileSize)               
    }
    Write-Progress -Activity "Moving data from '$Source' to '$Destination'" -Completed 
}



