Try {
  $PSGalleryModule = Find-Module AdminToolkit -Repository PSGallery -ErrorAction SilentlyContinue
  Write-Output $PSScriptRoot
  $ManifestPath = Join-Path -Path $PSScriptRoot -ChildPath "AdminToolkit" -AdditionalChildPath "AdminToolkit.psd1"
  Write-Output $ManifestPath
  $CurrentModule = Test-ModuleManifest -Path $ManifestPath

  if ($CurrentModule.Version -gt $PSGalleryModule.Version -or (-Not($PSGalleryModule))) {
    if (Publish-Module -Path  -Repository PSGallery -NuGetApiKey $PSGallery_API_Key -WhatIf) {
      Publish-Module -Path $CurrentModule.Path -Repository PSGallery -NuGetApiKey $env:PSGallery_API_Key
    }
  } else {
    Write-Output "Current Module version ($($CurrentModule.Version)) | PSGallery Module version ($($PSGalleryModule.Version)). Pipeline module version is not greater than the Published PSGallery module version."
  }
} Catch {
  Write-Error "$($_.Exception.Message)"
}
