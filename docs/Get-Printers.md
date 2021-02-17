# Get-Printers

## SYNOPSIS
Get printers for local or remote PC

## SYNTAX

```
Get-Printers [[-ComputerName] <String>] [<CommonParameters>]
```

## DESCRIPTION
This function will attempt to gather printer information for a local or remote PC.

## EXAMPLES

### EXAMPLE 1
```
Get-Printers
```

Description
-----------
This will generate local printer information.

### EXAMPLE 2
```
Get-Printers -ComputerName Some-Remote-Computer1
```

Description
-----------
This will generate printer information for the remote computer \`Some-Remote-Computer1' via a Cim Instance.

## PARAMETERS

### -ComputerName
Specify the remote computer to query.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

## RELATED LINKS
