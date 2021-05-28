BeforeDiscovery {
    #Requires -Modules @{ModuleName="Pester";ModuleVersion="5.0.0"}
    Remove-Module AdminToolkit -ErrorAction SilentlyContinue
    Import-Module ([System.IO.Path]::Combine($PSScriptRoot, '..', 'AdminToolkit.psd1')) -Force
}

Describe "AdminToolkit Module Public Tests" {
    BeforeAll {
        $DetectedOS = switch($true) {
            $IsWindows {'Windows'}
            $IsLinux   {'Linux'}
            $IsMacOS   {'MacOS'}
            DEFAULT    {'Windows'}
        }
    
        Switch($DetectedOS) {
            'Windows' {
                $script:ExcludedFunctions = [System.String]::Empty
            }
            DEFAULT {
                $script:ExcludedFunctions = 'SU', 'grep'
            }
        }
    }
    It "Imports Successfully" {
        Get-Module AdminToolkit | Should -Not -BeNullOrEmpty
    }

    Context 'Public Functions' {                
        It 'should import successfully' {
            
            $PublicImportedCommands = (Get-Command -Module AdminToolkit).Name
            $PublicFiles = Get-ChildItem ([System.IO.Path]::Combine($PSScriptRoot, '..', 'Functions', 'Public', '*.ps1')) -Exclude *tests.ps1, Aliases.ps1 | ForEach-Object {
                $_
            }
            $PublicImportFailedFunctions = (Compare-Object $PublicImportedCommands $($PublicFiles).BaseName).InputObject

            $PublicImportFailedFunctions = $PublicImportFailedFunctions | Where-Object {$_ -NotIn $script:ExcludedFunctions}
            $PublicImportFailedFunctions | Should -BeNullOrEmpty
        }
    }
    Context 'Aliases' {
        It 'should import successfully' {
            $AliasesPath = [System.IO.Path]::Combine($PSScriptRoot, '..', 'Functions', 'Public', 'Aliases.ps1')
            if (Test-Path $AliasesPath) {
                $ModuleAliases = (Get-Content $AliasesPath | Select-String "Set-Alias").Count
                $ActualAliases = (Get-Command -Module AdminToolkit -CommandType Alias).Count
            }
            else {
                $ModuleAliases = 0
                $ActualAliases = 0
            }
            $ActualAliases | Should -Match $ModuleAliases
        }
    }
    Context 'Files' {
        It 'LICENSE should exist' {
            $LicenseFile = [System.IO.Path]::Combine($PSScriptRoot, '..', 'LICENSE')
            $isLicense = Get-ChildItem $LicenseFile
            $isLicense | Should -Be $true
        }
        It 'CHANGELOG.md should exist' {
            $ChangelogFile = [System.IO.Path]::Combine($PSScriptRoot, '..', 'CHANGELOG.md')
            $isChangelog = Get-ChildItem $ChangelogFile
            $isChangelog | Should -Be $true
        }
    }
}
<# Currently no private functions defined.
InModuleScope AdminToolkit {
    Describe "AdminToolkit Module Private Tests" {
        Context 'Private Functions' {
            It 'should import successfully' {
                $PrivateImportedCommands = (Get-Command -Module AdminToolkit).Name
                $PrivateFiles = Get-ChildItem ([System.IO.Path]::Combine($PSScriptRoot,'..','Functions','Private','*.ps1')) -Exclude *tests.ps1, Aliases.ps1 | ForEach-Object {
                                    $_
                                }
                $PrivateImportSuccessfulFunctions = Compare-Object $PrivateImportedCommands $PrivateFiles.BaseName -IncludeEqual -ExcludeDifferent
                $PrivateImportSuccessfulFunctions.InputObject | Should -Be $PrivateFiles.BaseName
            }
        }
    }
}#>

