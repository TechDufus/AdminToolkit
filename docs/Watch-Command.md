# Watch-Command

## SYNOPSIS
Loop through a command forever until canceled (Ctrl + C)

## SYNTAX

```
Watch-Command [-Command] <String> [[-WaitSeconds] <Int32>] [-Differences] [<CommonParameters>]
```

## DESCRIPTION
This is meant to be a powershell equivalent to the linux \`watch\` command.

## EXAMPLES

### EXAMPLE 1
```
Watch-Command -Command Get-Process
```

Description
-----------
This will run Get-Process, wait 5 seconds (the default amount of time) and run it again.

### EXAMPLE 2
```
Watch-Command "Get-Process | Select-Object -First 12" -Differences -WaitSeconds 3
```

Description
-----------
This will run the Get-Process command through the pipeline, and monitor for differences every 3 seconds.
Notice this command is treated as a string and \`"wrapped in quotes"\`

## PARAMETERS

### -Command
This parameter takes in a command to evaluate.
This parameter takes in a string, and uses Invoke-Expression to run the command.
This means that complex commands must be wrapped within quotation marks.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WaitSeconds
This parameter takes in an Int (number) which equates to the number of seconds to wait after the completion of the command before executing again.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -Differences
This switch will not overwrite the original text displayed if something in the output has changed.
It will place a timestamp in between the previous output and the current (changed) output.
This also breaks out what items were \`Added\` or \`Removed\` from the previous output to assist with monitoring visually.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Matthew J.
DeGarmo
Handle: @matthewjdegarmo

You can either submit a \[PR\](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit

## RELATED LINKS
