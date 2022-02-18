#Region ConvertTo-Emoji

<#
.SYNOPSIS
    Convert the hex character string to an emoji character.
.DESCRIPTION
    ConvertTo-Emoji function converts the hex character string to an emoji 
    character. This conversion works in PowerShell versions 5.1 and 7.2.1 in 
    the Windows operating systems. The hex values for the characters used 
    were collected from the Emojipedia website. The hex code string(s) is 
    first converted to a decimal value and then to a character to display in 
    the console.
.PARAMETER HexStr
    HexStr string parameter contains a hexcode string from the UTF-8 encoding 
    for one or more emojis on the Emojipedia website. The parameter is 
    validated and will only allow Hex Code strings of five or more characters 
    to be used in teh function.
.EXAMPLE
    ConvertTo-Emoji -HexStr "1F600"

    Description:
    ------------
    The hex string, 1F600, is the hex code for the 'Grinning Face' emoji.
.NOTES
    Author:  https://github.com/vbsmbb/PSEmojis/blob/master/PSEmojis.psm1
    GitHub:  https://github.com/matthewjdegarmo
    Sponsor: https://github.com/sponsors/matthewjdegarmo
#>
Function ConvertTo-Emoji() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,Position = 0)]
        [ValidatePattern("[0-9a-fA-F]{4,5}")]
        [string]$HexStr	
    )

    Begin {}

    Process {
        Try {
            $HexStr | Foreach-Object {
                $emojicon = [System.Convert]::toInt32($_, 16)
                Write-Verbose "Emojicon: $emojicon"
                $emoji = [System.Char]::ConvertFromUtf32($emojicon)
                Write-Verbose "Emoji: $emoji"
                Write-Output $emoji
            }
        } Catch {
            Throw $_
        }
    }

    End {}
}
#EndRegion ConvertTo-Emoji