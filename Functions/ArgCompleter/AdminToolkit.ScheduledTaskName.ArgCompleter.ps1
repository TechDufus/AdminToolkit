#Region $AdminToolkitScheduledTaskNameArgCompleter
$AdminToolkitScheduledTaskNameArgCompleter = {
    param ($CommandName, $ParameterName, $StringMatch)
    $Tasks = (Get-ScheduledTask | Where-Object { $_.TaskName -match "$StringMatch" }).TaskName
    $QuotedTasks = foreach ($Task in $Tasks) {
        $QuotedTask = "`"$Task`""
        $QuotedTask
    }
    return $QuotedTasks
}
Register-ArgumentCompleter -CommandName Push-LocalScheduledTask -ParameterName TaskName -ScriptBlock $AdminToolkitScheduledTaskNameArgCompleter
#EndRegion $AdminToolkitScheduledTaskNameArgCompleter