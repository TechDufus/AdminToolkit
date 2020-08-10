#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Loop through a command forever until canceled (Ctrl + C)
.DESCRIPTION
    This is meant to be a powershell equivalent to the linux `watch` command.
.PARAMETER Command
    This parameter takes in a command to evaluate. This parameter takes in a string, and uses Invoke-Expression to run the command. This means that complex commands must be wrapped within quotation marks.
.PARAMETER WaitSeconds
    This parameter takes in an Int (number) which equates to the number of seconds to wait after the completion of the command before executing again.
.PARAMETER Differences
    This switch will not overwrite the original text displayed if something in the output has changed. It will place a timestamp in between the previous output and the current (changed) output. This also breaks out what items were `Added` or `Removed` from the previous output to assist with monitoring visually.
.EXAMPLE
    PS> Watch-Command -Command Get-Process

    Description
    -----------
    This will run Get-Process, wait 5 seconds (the default amount of time) and run it again.
.EXAMPLE
    PS> Watch-Command "Get-Process | Select-Object -First 12" -Differences -WaitSeconds 3

    Description
    -----------
    This will run the Get-Process command through the pipeline, and monitor for differences every 3 seconds. Notice this command is treated as a string and `"wrapped in quotes"`
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
function Watch-Command() {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string] $Command,

        [Parameter(Position = 1)]
        [int] $WaitSeconds = 5,

        [switch] $Differences
    )
    begin {
        $Output = $null
        $PreviousOutput = $null
        $Difference = $null
        $SaveX = [console]::CursorLeft
        $SaveY = [console]::CursorTop + 1
    }
    process {
        try {                
            Write-Output "Watching command: '$Command' | Interval: $WaitSeconds`s | Time: $([datetime]::Now)"
            While ($true) {
                [console]::SetCursorPosition($SaveX, $SaveY)
                $Output = (Invoke-Expression -Command $Command -ErrorAction SilentlyContinue)
                if ($PreviousOutput -and $Output -and $Differences.IsPresent) {
                    # $Properties = $PreviousOutput | Get-Member -MemberType "*Property*"
                    $Difference = (Compare-Object $PreviousOutput $Output -PassThru)
                    if ($Difference) {
                        ($PreviousOutput | Out-String).Trim()
                        "|-------------------------------| |-----------------|"
                        "There was a change in the output: $([datetime]::Now)"
                        "|-------------------------------| |-----------------|"
                        $AddedDifferences = $Difference | Where-Object { $_.SideIndicator -eq "=>" }
                        $RemovedDifferences = $Difference | Where-Object { $_.SideIndicator -eq "<=" }
                        if ($AddedDifferences) { "Added:"; ($AddedDifferences | Out-String).Trim(); "" }
                        if ($RemovedDifferences) { "Removed:"; ($RemovedDifferences | Out-String).Trim(); "" }
                        # ($Difference | Out-String).Trim()
                        # $Difference = $null
                        # $AddedDifferences = $null
                        # $RemovedDifferences = $null
                        ""; Write-Output "Watching command: '$Command' | Interval: $WaitSeconds`s | Time: $([datetime]::Now)"
                        $SaveX = [console]::CursorLeft
                        $SaveY = [console]::CursorTop
                    }
                }
                if ($Differences.IsPresent) {
                    $PreviousOutput = $Output
                }
                ($Output | Out-String).Trim()
                Start-Sleep -Seconds $WaitSeconds
            }
        }
        finally {
            $SaveX = $null
            $SaveY = $null
            $Output = $null
            $PreviousOutput = $null
            # $Difference = $null
        }
    }
    end {}
}




