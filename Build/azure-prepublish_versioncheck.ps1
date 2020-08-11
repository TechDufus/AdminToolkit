$PSGalleryModule = Find-Module AdminToolkit -Repository PSGallery -ErrorAction SilentlyContinue
$CurrentModule = Test-ModuleManifest -Path ([System.IO.Path]::Combine($PSScriptRoot,'..','AdminToolkit.psd1'))

#How to handle INITIAL Publishing?
#Must be able to detect both module versions
#CurrentModule.Version must be -gt PSGalleryModule.Version

if ($CurrentModule.Version -gt $PSGalleryModule.Version -or (-Not($PSGalleryModule))) {
  #PIPELINE MODULE HAS A NEW MANIFEST VERSION - PUBLISH TO PSGALLERY OR INITIAL PUBLISHING TO PSGALLERY
  Publish-Module -Path (Join-Path -Path $PSScriptRoot -ChildPath "AdminToolkit") -Repository PSGallery -NuGetApiKey $(PSGallery_Publish_API_Key)
} else {
  Write-Error "Current Module version ($($CurrentModule.Version)) | PSGallery Module version ($($PSGalleryModule.Version)). Pipeline module version is not greater than the Published PSGallery module version."
}

