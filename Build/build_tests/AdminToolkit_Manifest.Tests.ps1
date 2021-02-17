#Requires -Modules @{ModuleName="Pester";ModuleVersion="5.0.0"}

Describe "Given: AdminToolkit Manifest" {
    Context "When: Manifest is being used" {
        $script:ThisRoot = Split-Path $PSScriptRoot -Parent
        $ManifestInfo = Test-ModuleManifest -Path ([System.IO.Path]::Combine($script:MyRoot, 'AdminToolkit.psd1'))
        $PSDefaultParameterValues = @{
            "It:TestCases" = @{ ManifestInfo = $ManifestInfo }
        }
        It 'Then: should pass Test-ModuleManifest' {
            $ManifestInfo | Should -Be $true
        }
        It 'Then: should export functions' {
            $ExportedFunctions = $ManifestInfo.ExportedCommands
            $ExportedFunctions | Should -Be $true
        }
        It 'Then: should have a Version Number' {
            $Version = $ManifestInfo.Version
            $Version | Should -Be $true
        }
        It 'Then: should have an Author' {
            $Author = $ManifestInfo.Author
            $Author | Should -Be $true
        }
        It 'Then: should have a Description' {
            $Description = $ManifestInfo.Description
            $Description | Should -Be $true
        }
        It 'Then: should have the correct RootModule' {
            $RootModule = $ManifestInfo.RootModule
            $RootModule | Should -Match "AdminToolkit.psm1"
        }
    }
}