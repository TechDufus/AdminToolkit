$PSGalleryModule = Find-Module AdminToolkit -Repository PSGallery -ErrorAction SilentlyContinue
$CurrentModule = Test-ModuleManifest -Path ([System.IO.Path]::Combine($PSScriptRoot,'..','AdminToolkit.psd1))

#How to handle INITIAL Publishing?
#Must be able to detect both module versions
#CurrentModule.Version must be -gt PSGalleryModule.Version

if (-Not ($PSGalleryModule)) {
  #NO MODULE EXISTS - FIRST TIME RUN - PUBLISH CURRENT MODULE TO PSGALLERY
} else {
  if ($CurrentModule.Version -gt $PSGalleryModule.Version) {
    #PIPELINE MODULE HAS A NEW MANIFEST VERSION - PUBLISH TO PSGALLERY
  } else {
    Write-Error "Current Module version ($($CurrentModule.Version)) | PSGallery Module version ($($PSGalleryModule.Version)). Pipeline module version is not greater than the Published PSGallery module version."
  }
}
