#Region Get-Definition

<#
.SYNOPSIS
    Gets the back-end definition of a function.
.DESCRIPTION
    This function will export a string of the code that defines a function.
.PARAMETER Function
    This parameter takes a function name, or an alias name, to generate the function definition.
.EXAMPLE
    PS> Get-Definition Get-Definition

    Description
    -----------
    This will get the function definitnion for the `Get-Definition` command itself.
.EXAMPLE
    PS> Get-Definition glo | Clip

    Description
    -----------
    This will get the definition for the `glo` aliased command, and pipe it into your clipboard using the clip.exe file.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
function Get-Definition() {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Function
    )

    $null = Get-Command -Name $Function -ErrorAction SilentlyContinue
    $Alias = (Get-Alias -Name $Function -ErrorAction SilentlyContinue).ResolvedCommand.Name
    if ($Alias) {
        Write-Warning "'$Function' is an alias for '$Alias'. Running 'Get-Definition -Function $Alias'."
        $Function = $Alias
    }
    $FunctionDefinition = (Get-Command -name $Function | Select-Object -ExpandProperty Definition)
    $returnDefinition = [System.Text.StringBuilder]::New()

    $null = $returnDefinition.Append("function $Function`() {")
    $null = $returnDefinition.Append($FunctionDefinition)
    $null = $returnDefinition.Append('}')

    $returnDefinition.ToString()
}
#EndRegion Get-Definition