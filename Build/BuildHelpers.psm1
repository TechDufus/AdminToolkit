#Region Write-Status

Function Write-Status() {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory,Position=0)]
        [ValidateSet('Info','Warning','Success','Error')]
        $Type,

        [Parameter(Mandatory,Position=1)]
        $Message
    )

    Process {
        $Status = Switch($Type) {
            'Info' {
                @{
                    Symbol = '-'
                    Color = 'Yellow'
                }
            }
            'Warning' {
                @{
                    Symbol = '!'
                    Color = 'DarkYellow'
                }
            }
            'Success' {
                @{
                    Symbol = '+'
                    Color = 'Green'
                }
            }
            'Error' {
                @{
                    Symbol = 'X'
                    Color = 'Red'
                }
            }
        }

        Write-Host "[$($Status.Symbol)] $Message" -ForegroundColor $Status.Color
    }
}
#EndRegion Write-Status

#Region Confirm-VCSModuleNewerThanPublished

Function Confirm-VCSModuleNewerThanPublished() {
    [CmdletBinding()]
    [OutputType([bool])]
    Param()

    Begin {
        #Region Ensure PSRepository is Registered
        If (-Not(Get-PSRepository -Name 'PSGallery')) {
            Write-Status Warning "PSGallery PSRepository is not registered. Registering..."

            $registerPSRepositorySplat = @{
                Default = $true
                InstallationPolicy = 'Trusted'
            }

            Register-PSRepository @registerPSRepositorySplat
            Write-Status Success "Repository registered successfully."
        }
        #EndRegion Ensure PSRepository is Registered
    }

    Process {
        $script:VCSModuleVersion = (Test-ModuleManifest -Path (Join-Path $script:MyRoot "$script:ModuleName.psd1")).Version
        $PublishedModuleVersion = (Find-Module -Repository 'PSGallery' -Name $script:ModuleName).Version

        Write-Status Info "Published Version: $PublishedModuleVersion"
        Write-Status Info "VCS Version: $script:VCSModuleVersion"

        If ($script:VCSModuleVersion -gt $PublishedModuleVersion) {
            $true
        } Else {
            $false
        }
    }
}
#EndRegion Confirm-VCSModuleNewerThanPublished

#Region Start-PreBuildTests

Function Start-PreBuildTests() {
    [CmdletBinding()]
    Param()

    Process {
        $PesterModule = Get-Module -Name Pester -ListAvailable
        if (-Not($PesterModule.Version -gt '5.0.0')) {
            Write-Status Info "Installing Pester."
            Install-Module -Name Pester -MinimumVersion 5.0.0 -Force -SkipPublisherCheck
            Write-Status Success "Pester installed successfully."
        }
        $TestsPath = [System.IO.Path]::Combine($script:MyRoot,'Tests')

        $Result = Invoke-Pester $TestsPath -PassThru -OutputFile 'Pre-Build_testResults.xml' -OutputFormat NUnitXml

        Switch($Result.Result) {
            'Passed' {
                $true
            }
            'Failed' {
                $false
            }
        }
    }
}
#EndRegion Start-PreBuildTests

#Region Build-Module

Function Build-Module() {
    [CmdletBinding()]
    Param()

    Process {
        $ModuleBuildName = "$script:ModuleName`_Build"
        $ModuleRoot = Split-Path $PSScriptRoot -Parent
        $ModuleBuildPath = [System.IO.Path]::Combine($ModuleRoot,$ModuleBuildName)
        $ModuleTargetFile = [System.IO.Path]::Combine($ModuleBuildPath,$script:ModuleName,"$script:ModuleName.psm1")
        $ManifestPathSource = [System.IO.Path]::Combine($ModuleRoot,"$script:ModuleName.psd1")
        $ManifestPathTarget = [System.IO.Path]::Combine($ModuleBuildPath,$script:ModuleName,"$script:ModuleName.psd1")

        $ScriptsPath = [System.IO.Path]::Combine($ModuleRoot,"Functions",'*.ps1')
        $ScriptFunctions = @( Get-ChildItem -Path $ScriptsPath -ErrorAction SilentlyContinue -Recurse )
        Write-Status Info "Functions to build module:"
        $ScriptFunctions

        $null = New-Item -Name "$script:ModuleName" -Path $ModuleBuildPath -ItemType Directory -Force

        foreach ($FilePath in $ScriptFunctions) {
            $Results = [System.Management.Automation.Language.Parser]::ParseFile($FilePath, [ref]$null, [ref]$null)
            $Functions = $Results.Extent.Text
            Write-Status Info "Adding content from $($FilePath.Name) to module $ModuleTargetFile"
            $Functions | Add-Content -Path $ModuleTargetFile -Force
        }

        Write-Status Info "Copying original Manifest from $ManifestPathSource to $ManifestPathTarget"
        Copy-Item -Path $ManifestPathSource $ManifestPathTarget -Force

    }
}
#EndRegion Build-Module

#Region Start-PostBuildTests

Function Start-PostBuildTests() {
    [CmdletBinding()]
    Param()

    Process {
        $BuildModuleRoot = [System.IO.Path]::Combine($script:MyRoot, "$script:ModuleName`_Build", $script:ModuleName)

        $copyItemSplat = @{
            Path = [System.IO.Path]::Combine($script:MyRoot, 'Build', 'build_tests')
            Destination = [System.IO.Path]::Combine($BuildModuleRoot, 'build_tests')
            Force = $true
            Recurse = $true
        }
        Write-Status Info "Copying POST-Build tests to Build module.."
        Copy-Item @copyItemSplat

        Write-Status Info "Starting POST-Build Tests.."
        $Result = Invoke-Pester (Join-Path $BuildModuleRoot 'build_tests') -PassThru -OutputFile 'Post-Build_testResults.xml' -OutputFormat NUnitXml

        $removeItemSplat = @{
            Force = $true
            Recurse = $true
            Path = $copyItemSplat.Destination
        }
        Write-Status Info "Removing tests from Build Module.."
        Remove-Item @removeItemSplat

        Switch($Result.Result) {
            'Passed' {
                $true
            }
            DEFAULT {
                $false
            }
        }
    }
}
#EndRegion Start-PostBuildTests

#Region Publish-Module

Function Publish-ThisModule() {
    [CmdletBinding()]
    Param(
        $Repository = 'PSGallery',
        $PSGalleryApiKey = $PSGalleryApiKey
    )

    Process {
        $BuiltModulePath = [System.IO.Path]::Combine($script:MyRoot, "$script:ModuleName`_Build", $script:ModuleName)

        $publishModuleSplat = @{
            Path = $BuiltModulePath
            Repository = 'PSGallery'
            NuGetApiKey = $PSGalleryApiKey #This references Azure Secret imported by Azure task.
        }
        Publish-Module @publishModuleSplat
    }

}
#EndRegion Publish-Module

#Region Remove-ModuleBuild

Function Remove-ModuleBuild() {
    [CmdletBinding()]
    Param()

    Process {
        Write-Status Info "Cleaning up Module Build..."
        $BuildModulePath = [System.IO.Path]::Combine($script:MyRoot, "$script:ModuleName`_Build")
        Get-ChildItem $BuildModulePath -Recurse | Remove-Item -Force -Recurse
        Remove-Item $BuildModulePath -Force -Recurse
    }
}
#EndRegion Remove-ModuleBuild

#Region Get-LatestChangeLogSection

Function Get-LatestChangeLogSection() {
    [CmdletBinding()]
    Param(
        # Specifies a path to one or more locations.
        [Parameter(Position=0,
                ParameterSetName="Path",
                ValueFromPipeline=$true,
                ValueFromPipelineByPropertyName=$true,
                HelpMessage="Path to ChangeLog file.")]
        [Alias("PSPath")]
        [System.String] $Path = (Join-Path $script:MyRoot 'CHANGELOG.md'),

        [version] $Version = (Test-ModuleManifest -Path (Join-Path $script:MyRoot "$script:ModuleName`.psd1")).Version,

        [System.String] $ModuleName = $script:ModuleName
    )

    Begin {}

    Process {
        $FileContent = Get-Content -Path $Path
        $VersionHeading = '## v'
        $LatestChangeLogVersion = (($FileContent | Select-String -Pattern $VersionHeading)[0] -Split 'v')[-1]

        #Only grab the latest changelog section if it's actually relevant to the version being published.
        If ($LatestChangeLogVersion -eq $Version) {
            $TerminateFileContentLine = (($FileContent | Select-String -Pattern $VersionHeading)[1].LineNumber) - 2
            $FileContent[0..$TerminateFileContentLine] | Out-String
        } else {
            #TODO: Build Default Markdown to show that is generic. Better than nothing.
            $Markdown = [System.Text.StringBuilder]::new()

            $null = $Markdown.AppendLine("# Changelog for $script:ModuleName")
            $null = $Markdown.AppendLine()
            $null = $Markdown.AppendLine("## v$Version")
            $null = $Markdown.AppendLine('+ Performance Improvements')
            $null = $Markdown.AppendLine('+ BUG Fixes')
            $null = $Markdown.AppendLine('+ Code Cleanup')

            $Markdown.ToString()
        }
    }
}
#EndRegion Get-LatestChangeLogSection

#Region Remove-TestResultFiles

Function Remove-TestResultFiles() {
    [CmdletBinding()]
    Param()

    Process {
        $RepositoryRoot = Split-Path (Split-Path $script:MyRoot -Parent) -Parent
        $TestXMLFiles = Get-ChildItem (Join-Path $RepositoryRoot '*-Build_testResults.xml')
        If ($TestXMLFiles) {
            $TestXMLFiles | Remove-Item -Force
        }
    }
}
#EndRegion Remove-TestResultFiles

#Region Environment
Write-Status Info 'Setting up environment...'
$script:MyRoot = Split-Path $PSScriptRoot -Parent
$script:ModuleName = "AdminToolkit"
$PesterIsInstalled = Get-Module Pester -ListAvailable

If (-Not($PesterIsInstalled)) {
    Write-Status Warning "DEPENDENCY: Installing Pester Module."
    Install-Module Pester -MinimumVersion 5.0.0 -Scope CurrentUser -Force
}
Import-Module Pester
#EndRegion Environment