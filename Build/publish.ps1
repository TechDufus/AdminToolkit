[CmdletBinding()]
[OutputType([boolean])]
Param(
    [Parameter(Mandatory)]
    [System.String] $PSGalleryApiKey
)

Begin {
    Import-Module $(Join-Path $PSScriptRoot 'BuildHelpers.psm1') -Force
}
Process {
    Publish-ThisModule -PSGalleryApiKey $PSGalleryApiKey
}