<#
.SYNOPSIS
    Translate a string into an audible message.
.DESCRIPTION
    This function calls the SAPI.SPVoice class to invoke audio given a string. This is useful when running long processes, you can audibly be alerted that a task is finished.
.NOTES
    Author: Matthew J. DeGarmo
    Site: https://matthewjdegarmo.github.io
#>
function Invoke-Speech {
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



