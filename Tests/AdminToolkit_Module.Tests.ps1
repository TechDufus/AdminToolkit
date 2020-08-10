#Requires -Modules @{ModuleName="Pester";ModuleVersion="5.0.0"}

Import-Module ([System.IO.Path]::Combine($PSScriptRoot,'..','AdminToolkit.psd1')) -Force
Describe "AdminToolkit Module Public Tests" {
    It "Imports Successfully" {
        Get-Module AdminToolkit | Should -Not -BeNullOrEmpty
    }
    Context 'Public Functions' {
        It 'should import successfully' {
            $PublicImportedCommands = (Get-Command -Module AdminToolkit).Name
            $PublicFiles = Get-ChildItem ([System.IO.Path]::Combine($PSScriptRoot,'..','Functions','Public','*.ps1')) -Exclude *tests.ps1, Aliases.ps1 | ForEach-Object {
                                $_
                            }
            $PublicImportFailedFunctions = (Compare-Object $PublicImportedCommands $($PublicFiles).BaseName).InputObject
            $PublicImportFailedFunctions | Should -BeNullOrEmpty
        }

        Get-ChildItem ([System.IO.Path]::Combine($PSScriptRoot,'..','Functions','Public','*.ps1')) -Exclude *tests.ps1, Aliases.ps1 | ForEach-Object {
            Context "Test File: $($_.BaseName)" {
                $PSDefaultParameterValues = @{
                    "It:TestCases" = @{ CurrentFunction = $_ }
                }
                It "Should have comment-based help block" {
                    $CurrentFunction.FullName | Should -FileContentMatch '<#'
                    $CurrentFunction.FullName | Should -FileContentMatch '#>'
                }
                It "Should have SYNOPSIS section in help" {
                    $CurrentFunction.FullName | Should -FileContentMatch '.SYNOPSIS'
                }
                It "Should have DESCRIPTION section in help" {
                    $CurrentFunction.FullName | Should -FileContentMatch '.DESCRIPTION'
                }
                It "Should have EXAMPLE section in help" {
                    $CurrentFunction.FullName | Should -FileContentMatch '.EXAMPLE'
                }
                It "Should be an advanced function" {
                    $CurrentFunction.FullName | Should -FileContentMatch 'function'
                    $CurrentFunction.FullName | Should -FileContentMatch 'cmdletbinding'
                    $CurrentFunction.FullName | Should -FileContentMatch 'param'
                }
                It "Should be valid PowerShell code" {
                    $FileContent = Get-Content -Path $CurrentFunction.FullName -ErrorAction Stop
                    $Errors = $null
                    $null = [System.Management.Automation.PSParser]::Tokenize($FileContent, [ref]$errors)
                    $errors.Count | Should -be 0
                }
            }
        }
    }
    Context 'Aliases' {
        It 'should import successfully' {
            $AliasesPath = [System.IO.Path]::Combine($PSScriptRoot,'..','Functions','Public','Aliases.ps1')
            if (Test-Path $AliasesPath) {
                $ModuleAliases = (Get-Content $AliasesPath | Select-String "Set-Alias").Count
                $ActualAliases = (Get-Command -Module AdminToolkit -CommandType Alias).Count
            } else {
                $ModuleAliases = 0
                $ActualAliases = 0
            }
            $ActualAliases | Should -Match $ModuleAliases
        }
    }
    Context 'Files' {
        It 'LICENSE should exist' {
            $LicenseFile = [System.IO.Path]::Combine($PSScriptRoot,'..','LICENSE')
            $isLicense = Get-ChildItem $LicenseFile
            $isLicense | Should -Be $true
        }
        It 'CHANGELOG.md should exist' {
            $ChangelogFile = [System.IO.Path]::Combine($PSScriptRoot,'..','CHANGELOG.md')
            $isChangelog = Get-ChildItem $ChangelogFile
            $isChangelog | Should -Be $true
        }
    }
}

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
}

