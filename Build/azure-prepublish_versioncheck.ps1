$PSGalleryModule = Find-Module AdminToolkit -Repository PSGallery -ErrorAction SilentlyContinue
$CurrentModule = Test-ModuleManifest -Path ([System.IO.Path]::Combine("AdminToolkit","AdminToolkit.psd1"))
if ($CurrentModule.Version -gt $PSGalleryModule.Version -or (-Not($PSGalleryModule))) {
  if (Publish-Module -Path $CurrentModule.Path -Repository PSGallery -NuGetApiKey $env:PSGALLERY_API_KEY -WhatIf) {
    Publish-Module -Path $CurrentModule.Path -Repository PSGallery -NuGetApiKey $env:PSGALLERY_API_KEY
  }
} else {
  Write-Output "GitHub Module version ($($CurrentModule.Version)) | PSGallery Module version ($($PSGalleryModule.Version)). Pipeline module version is not greater than the Published PSGallery module version."
}
