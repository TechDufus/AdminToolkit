# Get-RebootLogs

## SYNOPSIS
Get the System Event logs for reboot ID 1074.

## SYNTAX

```
Get-RebootLogs [[-ComputerName] <String>] [<CommonParameters>]
```

## DESCRIPTION
This will pull system event logs for the local or remote computer.

## EXAMPLES

### EXAMPLE 1
```
Get-RebootLogs
```

Description
-----------
This will generate a list of all System Reboot log events with ID 1074 on the local system.

### EXAMPLE 2
```
Get-RebootLogs -ComputerName Some-Remote-Computer | Select -First 5
```

Description
-----------
This will get the System Reboot logs from \`Some-Remote-Computer\` and only show the first 5 results.

## PARAMETERS

### -ComputerName
Specify a remote computer to pull logs from.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $env:COMPUTERNAME
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
Site: https://matthewjdegarmo.com

You can either submit a \[PR\](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit

## RELATED LINKS
