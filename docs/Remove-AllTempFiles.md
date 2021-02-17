# Remove-AllTempFiles

## SYNOPSIS
Generic Cleanup of temp files on a computer.

## SYNTAX

```
Remove-AllTempFiles [[-ComputerName] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This Command removes log files, temp files, and empties the recycle bin.
Access denied errors do not indicate a failure of the script.
Run for the local or a remote PC.

## EXAMPLES

### EXAMPLE 1
```
Remove-All
```

Description
-----------
Free up space on the local computer

### EXAMPLE 2
```
Remove-All -Computer Test-PC-01
```

Description
-----------
Free up space on a remote PC.
May be more effective if run locally depending on in place security.

## PARAMETERS

### -ComputerName
Specify a remote computer to run against.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
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
