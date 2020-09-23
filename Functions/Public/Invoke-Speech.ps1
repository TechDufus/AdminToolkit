#Region Invoke-Speech

<#
.SYNOPSIS
    Translate a string into an audible message.
.DESCRIPTION
    This function calls the SAPI.SPVoice class to invoke audio given a string. This is useful when running long processes, you can audibly be alerted that a task is finished.
.PARAMETER Message
    Specify the message to have voiced.
.EXAMPLE
    PS> Get-SomeDataThatTakesAnHour;Invoke-Speech -Message "Your data is ready, sir."
    
    Description
    -----------
    This will generated audio for the string 'Your data is ready, sir." depending on your volume level.
.NOTES
    Author: Matthew J. DeGarmo
    Site: https://matthewjdegarmo.github.io
#>
function Invoke-Speech {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [string]$Message
    ) 

    begin {
        #Set Variables for the Invoke-Speech Function
        $voice = New-Object -ComObject SAPI.SPVoice
        $voice.Rate = -2
    }

    process {
        $voice.Speak($Message) | out-null;    
    }
}
#EndRegion Invoke-Speech