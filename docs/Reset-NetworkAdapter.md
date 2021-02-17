# Reset-NetworkAdapter

## SYNOPSIS
Reset a network interface.

## SYNTAX

```
Reset-NetworkAdapter [-Interface] <Object> [<CommonParameters>]
```

## DESCRIPTION
Reset a specified interface with -Interface.

## EXAMPLES

### EXAMPLE 1
```
Reset-NetworkAdapter -Interface "Local Area Connection"
```

## PARAMETERS

### -Interface
Specify the name of the network interface name to reset.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

Change Log:
Version: 1.0 - Function Creation.

## RELATED LINKS
