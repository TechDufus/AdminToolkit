#Region $AdminToolkitADComputernameArgCompleter
$AdminToolkitADComputernameArgCompleter = {
    param ($CommandName, $ParameterName, $StringMatch)
    if ($null -eq $StringMatch) {
        $Filter = "*"
    }
    else {
        $Filter = "*$StringMatch*"
    }
    (Get-ADComputer -filter { Name -like $Filter }).Name
}
Register-ArgumentCompleter -CommandName Deploy-LocalScheduledTask -ParameterName ComputerName -ScriptBlock $AdminToolkitADComputernameArgCompleter
#EndRegion $AdminToolkitADComputernameArgCompleter