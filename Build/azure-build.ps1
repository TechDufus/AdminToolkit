$ModuleName = "AdminToolkit"
$ModulePathTarget = "$ModuleName`_Build"
$ModuleTargetFile = [System.IO.Path]::Combine($ModulePathTarget,$ModuleName,"$ModuleName.psm1")
$ManifestPathSource = [System.IO.Path]::Combine($ModuleName,"$ModuleName.psd1")
$ManifestPathTarget = [System.IO.Path]::Combine($ModulePathTarget,$ModuleName,"$ModuleName.psd1")

$ScriptsPath = [System.IO.Path]::Combine($ModuleName,"Functions",'*.ps1')
$ScriptFunctions = @( Get-ChildItem -Path $ScriptsPath -ErrorAction SilentlyContinue -Recurse )
Write-Output "Functions to build module:"
$ScriptFunctions


$null = New-Item -Name "$ModuleName" -Path "$ModulePathTarget" -ItemType Directory -Force

foreach ($FilePath in $ScriptFunctions) {
    $Results = [System.Management.Automation.Language.Parser]::ParseFile($FilePath, [ref]$null, [ref]$null)
    $Functions = $Results.Extent.Text
    Write-Output "Adding content from $($FilePath.Name) to module $ModuleTargetFile"
    $Functions | Add-Content -Path $ModuleTargetFile -Force
}

Write-Output "Copying original Manifest from $ManifestPathSource to $ManifestPathTarget"
Copy-Item -Path $ManifestPathSource $ManifestPathTarget -Force
