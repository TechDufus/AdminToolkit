#Requires -Modules @{ModuleName="Pester";ModuleVersion="5.0.0"}

Describe "AdminToolkit Manifest Tests" {
    $ManifestInfo = Test-ModuleManifest -Path ([System.IO.Path]::Combine($PSScriptRoot,'..','AdminToolkit.psd1'))
    $PSDefaultParameterValues = @{
        "It:TestCases" = @{ ManifestInfo = $ManifestInfo }
    }
    It 'Passes Test-ModuleManifest' {
        $ManifestInfo | Should -Be $true
    }
    It 'Exports Functions' {
        $ExportedFunctions = $ManifestInfo.ExportedCommands
        $ExportedFunctions | Should -Be $true
    }
    It 'Has a Version Number' {
        $Version = $ManifestInfo.Version
        $Version | Should -Be $true
    }
    It 'Has an Author' {
        $Author = $ManifestInfo.Author
        $Author | Should -Be $true
    }
    It 'Has a Description' {
        $Description = $ManifestInfo.Description
        $Description | Should -Be $true
    }
    It 'Has correct RootModule' {
        $RootModule = $ManifestInfo.RootModule
        $RootModule | Should -Match "AdminToolkit.psm1"
    }
}

