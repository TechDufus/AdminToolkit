[CmdletBinding()]
[OutputType([boolean])]
Param()

Begin {
    Import-Module $(Join-Path $PSScriptRoot 'BuildHelpers.psm1') -Force
}
Process {
    Confirm-VCSModuleNewerThanPublished
}