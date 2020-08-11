$PSGalleryModule = Find-Module AdminToolkit -Repository PSGallery -ErrorAction SilentlyContinue
$CurrentModule = Test-ModuleManifest -Path ([System.IO.Path]::Combine($PSScriptRoot,'..','AdminToolkit.psd1'))

if ($CurrentModule.Version -gt $PSGalleryModule.Version -or (-Not($PSGalleryModule))) {
  #PIPELINE MODULE HAS A NEW MANIFEST VERSION - PUBLISH TO PSGALLERY OR INITIAL PUBLISHING TO PSGALLERY
  #$PWDParentDir = Split-Path $PSScriptRoot -Parent
  #$ManifestPath = [System.IO.Path]::Combine($PWDParentDir,'AdminToolkit.psd1')
  $ManifestPath = Join-Path -Path "AdminToolkit" -ChildPath "AdminToolkit.psd1"
  if (Publish-Module -Path  -Repository PSGallery -NuGetApiKey $PSGallery_API_Key -WhatIf) {
    Publish-Module -Path $ManifestPath -Repository PSGallery -NuGetApiKey $env:PSGallery_API_Key
  }
} else {
  Write-Output "Current Module version ($($CurrentModule.Version)) | PSGallery Module version ($($PSGalleryModule.Version)). Pipeline module version is not greater than the Published PSGallery module version."
}

