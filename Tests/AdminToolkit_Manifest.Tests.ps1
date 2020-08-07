
$ModuleName = "AdminToolkit"
$ModuleManifestName ="$ModuleName.psd1"
$ModuleManifestPath = [System.IO.Path]::Combine($PSScriptRoot,"..","$ModuleManifestName")
# $ModuleManifestPath = "$PSScriptRoot\..\$ModuleManifestName"
$ManifestInfo = (Test-ModuleManifest -Path $ModuleManifestPath)

Describe "$ModuleName Manifest Tests" {
    It 'Passes Test-ModuleManifest' {
        $Manifest = $ManifestInfo
        $Manifest | Should Not BeNullOrEmpty
    }
    It 'Exports Functions' {
        $ExportedFunctions = $ManifestInfo.ExportedCommands
        $ExportedFunctions | Should Not BeNullOrEmpty
    }
    It 'Has a Version Number' {
        $Version = $ManifestInfo.Version
        $Version | Should Not BeNullOrEmpty
    }
    It 'Has an Author' {
        $Author = $ManifestInfo.Author
        $Author | Should Not BeNullOrEmpty
    }
    It 'Has a Description' {
        $Description = $ManifestInfo.Description
        $Description | Should Not BeNullOrEmpty
    }
    It 'Has correct RootModule' {
        $RootModule = $ManifestInfo.RootModule
        $RootModule | Should -Be ($ModuleManifestName -Replace 'psd1', 'psm1')
    }
}
