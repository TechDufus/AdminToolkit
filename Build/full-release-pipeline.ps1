[CmdletBinding()]
Param(
    [Parameter()]
    [System.String] $ModuleName,

    [Switch] $DoNotPublish,

    [Switch] $DoNotCleanUp,

    [Parameter(Mandatory)]
    [System.String] $PSGalleryApiKey
)

Begin {
    Import-Module $(Join-Path $PSScriptRoot 'BuildHelpers.psm1') -Force
    

}

Process {
    Write-Status Info "Starting build process.."
    If (Confirm-VCSModuleNewerThanPublished) {
        Write-Status Info "VCS Version is newer than Published Version."
        If (Start-PreBuildTests) {
            Write-Status Success "Passed all PRE-Build Tests."
            Write-Status Info "Building Module."
            Build-Module
            If (Start-PostBuildTests) {
                Write-Status Success "Passed all POST-Build Tests."
                If (-Not($DoNotPublish.IsPresent)) {
                    Write-Status Info "Publishing Module..."
                    Publish-ThisModule -PSGalleryApiKey $PSGalleryApiKey
                    Write-Status Success "Successfully published."
                }
            } Else {
                Write-Status Error "$script:ModuleName did not pass Post-Build Tests."
            }
            If (-Not($DoNotCleanUp.IsPresent)) {
                Write-Status Info "Cleaning up Module Build files."
                Remove-ModuleBuild
                Write-Status Info "Cleaning up leftover .XML test files."
                Remove-TestResultFiles
            }
        } Else {
            Write-Status Error "$script:ModuleName did not pass Pre-Build Tests."
        }
    } Else {
        Write-Status Error "VCS Version does not exceed Published Version."
    }
}
