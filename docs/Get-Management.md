# Get-Management

## SYNOPSIS
Open Computer management

## SYNTAX

```
Get-Management [[-ComputerName] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Opens Computer management connected for a PC, local or remote.
Default is local.

## EXAMPLES

### EXAMPLE 1
```
Get-Management Test-999999-H
```

Description
-----------
This will open computer management for this remote PC, if you are an admin on that PC.

## PARAMETERS

### -ComputerName
Specify a remote computer to run against.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $env:ComputerName
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
