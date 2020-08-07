
$ModuleName = "AdminToolkit"
$ModuleManifestName = "$ModuleName.psd1"

$ModuleManifestPath = [System.IO.Path]::Combine($PSScriptRoot,"..","$ModuleManifestName")
$ModulePath = [System.IO.Path]::Combine($PSScriptRoot,"..")
$AliasesPath = [System.IO.Path]::Combine($PSScriptRoot,"..","Functions","Public","Aliases.ps1")

$PublicFunctionsFiles = [System.IO.Path]::Combine($PSScriptRoot,"..","Functions","Public","*.ps1")
$PublicFileNames = Get-ChildItem $PublicFunctionsFiles -Exclude *tests.ps1, Aliases.ps1 | ForEach-Object {
    $_.BaseName
}
$PrivateFunctionsFiles = [System.IO.Path]::Combine($PSScriptRoot,"..","Functions","Private","*.ps1")
$PrivateFileNames = Get-ChildItem $PrivateFunctionsFiles -Exclude *tests.ps1 | ForEach-Object {
    $_.BaseName
}

if (Get-Module $ModuleName) {
    Remove-Module $ModuleName
}

Import-Module $ModuleManifestPath

Describe "$ModuleName Module Tests" {
    It "Imports Successfully" {
        Import-Module $ModuleManifestPath -Force
        Get-Module $ModuleName | Should -Be $true
    }
    Context 'Public Functions' {
        It 'should import successfully' {
            $PublicImportedCommands = (Get-Command -Module $ModuleName).Name
            $PublicImportFailedFunctions = (Compare-Object $PublicImportedCommands $PublicFileNames).InputObject
            $PublicImportFailedFunctions | Should -Be $null
        }
    }
    Context 'Private Functions' {
        It 'should import successfully - Haven''t configured test yet' {
            #$PrivateImportedCommands = (Get-Command -Module $ModuleName).Name
            #$PrivateImportFailedFunctions = (Compare-Object $PrivateImportedCommands $PrivateFileNames).InputObject
            $true | Should -Be $true
        }
    }
    Context 'Aliases' {
        It 'should import successfully' {
            if (Test-Path $AliasesPath) {
                $ModuleAliases = (Get-Content $AliasesPath | Select-String "Set-Alias").Count
                $ActualAliases = (Get-Command -Module $ModuleName -CommandType Alias).Count
            } else {
                $ModuleAliases = 0
                $ActualAliases = 0
            }
            $ActualAliases | Should -Be $ModuleAliases
        }
    }
    Context 'Files' {
        It 'LICENSE should exist' {
            $LicenseFile = [System.IO.Path]::Combine($ModulePath,'LICENSE')
            $isLicense = Get-ChildItem $LicenseFile
            $isLicense | Should -Be $true
        }
        It 'CHANGELOG.md should exist' {
            $ChangelogFile = [System.IO.Path]::Combine($ModulePath,'CHANGELOG.md')
            $isChangelog = Get-ChildItem $ChangelogFile
            $isChangelog | Should -Be $true
        }
    }
}



if (Get-Module $ModuleName) {
    Remove-Module $ModuleName
}
