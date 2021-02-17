$ModuleRoot = Split-Path $PSScriptRoot -Parent
$DocsFolder = Join-Path $ModuleRoot 'docs'
$IsInstalled = Get-Module PlatyPS -ListAvailable

If (-Not($IsInstalled)) {
    Write-Host "Installing PlatyPS.."
    Install-Module PlatyPS -Scope CurrentUser -Force
}

Write-Host "Clearing $DocsFolder"
Get-ChildItem $DocsFolder -Recurse -Force | Remove-Item -Recurse -Force

Write-Host "Creating Help Documentation.."
New-MarkdownHelp -Module AdminToolkit -OutputFolder $DocsFolder -NoMetadata -Force