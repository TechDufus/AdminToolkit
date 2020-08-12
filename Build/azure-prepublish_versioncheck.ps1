$PSGalleryModule = Find-Module AdminToolkit -Repository PSGallery -ErrorAction SilentlyContinue
#$ManifestPath = Get-ChildItem (Join-Path -Path ".." -ChildPath "AdminToolkit.psd1")
#$ManifestPath = Join-Path -Path $PSScriptRoot -ChildPath "AdminToolkit" -AdditionalChildPath "AdminToolkit.psd1"
$CurrentModule = Test-ModuleManifest -Path (Join-Path -Path "AdminToolkit" -ChildPath "AdminToolkit.psd1")

if ($CurrentModule.Version -gt $PSGalleryModule.Version -or (-Not($PSGalleryModule))) {
  if (Publish-Module -Path  -Repository PSGallery -NuGetApiKey $PSGallery_API_Key -WhatIf) {
    Publish-Module -Path $CurrentModule.Path -Repository PSGallery -NuGetApiKey $env:PSGallery_API_Key
  }
} else {
  Write-Output "Current Module version ($($CurrentModule.Version)) | PSGallery Module version ($($PSGalleryModule.Version)). Pipeline module version is not greater than the Published PSGallery module version."
}
