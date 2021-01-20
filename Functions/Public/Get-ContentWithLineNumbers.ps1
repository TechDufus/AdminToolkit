#Region Get-ContentWithLineNumbers

<# 
.Synopsis
    Mimic Unix / Linux tool nl number lines
.Description
    Print file content with numbered lines no original nl options supported
.PARAMETER FileName
    Specify a file to extract and prefix with line numbers.
.PARAMETER InputObject
    Specify an object of text to prefix with line numbers.
.Example
    PS> Get-ContentWithLineNumbers -FileName C:\Foo.txt
    
    Description
    -----------
    This will append line numbers to the begninning of each line in the Foo.txt file.
.NOTES
    Author: Matthew J. DeGarmo
    Site: https://matthewjdegarmo.github.io

    You can either submit a [PR](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit
#>
function Get-ContentWithLineNumbers() {
    [CmdletBinding()]
    param (
        [parameter(mandatory = $true, Position = 0, ValueFromPipeline, ParameterSetName = 'File')]
        [String]$FileName,

        [Parameter(ParameterSetName = 'Input')]
        $InputObject
    )
           
    process {
        if ($PSBoundParameters.ContainsKey('FileName')) {
            If (Test-Path $FileName) {
                $Data = Get-Content $FileName | ForEach-Object { "{0,5} {1}" -f $_.ReadCount, $_ }
            }
            $Data
        }
        elseif ($PSBoundParameters.ContainsKey('Input')) {
            $inData = New-Object -TypeName System.IO.StringReader -ArgumentList $InputObject
            $Data = While ($Line = $InData.ReadLine()) { $Line }
            $Data | ForEach-Object { "{0,5} {1}" -f $_.ReadCount, $_ }
        }
    }
}
#EndRegion Get-ContentWithLineNumbers