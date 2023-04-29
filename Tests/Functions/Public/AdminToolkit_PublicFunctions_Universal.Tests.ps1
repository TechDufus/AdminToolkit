BeforeDiscovery {
    #! Finish nested path splitting.
    $ModuleRoot =   Split-Path (
                        Split-Path (
                            Split-Path $PSScriptRoot -Parent
                        ) -Parent
                    ) -Parent
    Remove-Module AdminToolkit -Force -ErrorAction SilentlyContinue
    Import-Module $ModuleRoot -Force
    $PublicFunctionsPath = Join-Path $ModuleRoot 'Functions' 'Public' '*.ps1'

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
    $PublicFunctions = Get-ChildItem $PublicFunctionsPath -Exclude Aliases.ps1 | Where-Object {$_.BaseName -notin $script:ExcludedFunctions}
}

Describe "Function: <_.BaseName>" -ForEach $PublicFunctions {
    BeforeDiscovery {
        $Command = Get-Command $_.BaseName -ErrorAction SilentlyContinue
        $Parameters = $Command.Parameters.Keys 
            | Where-Object { 
                $_ -notin ([System.Management.Automation.PSCmdlet]::CommonParameters) -and 
                $_ -notin ([System.Management.Automation.PSCmdlet]::OptionalCommonParameters) 
            }
    }

    BeforeAll {
        $CurrentFunction = $_
        . $CurrentFunction.FullName
    }

    Context "Parameter - <_>" -ForEach $Parameters {
        BeforeAll {
            $Parameter = $_
        }
        It "Should have .PARAMETER help for each defined parameter" {
            $CurrentFunction.FullName | Should -FileContentMatch ".PARAMETER $Parameter"
        }
    }

    It "Should register command with Get-Command" -ForEach @{ Command = $Command } {
        $Command | Should -BeOfType [System.Management.Automation.CommandInfo]
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
    It "Should have NOTES section in help" {
        $CurrentFunction.FullName | Should -FileContentMatch '.NOTES'
    }
    It 'Should be an advanced function' -Skip:($Command.CommandType -ne 'Function' -or $Command.Name -in 'grep') -ForEach @{ Command = $Command } {
        $Command.CmdletBinding | Should -BeTrue
    }
    It "Should have Begin and End Regions" {
        $CurrentFunction.FullName | Should -FileContentMatch "#Region"
        $CurrentFunction.FullName | Should -FileContentMatch "#EndRegion"
    }
    It "Should be valid PowerShell code" {
        $FileContent = Get-Content -Path $CurrentFunction.FullName -ErrorAction Stop
        $Errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($FileContent, [ref]$errors)
        $errors.Count | Should -be 0
    }
}
