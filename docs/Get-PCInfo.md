# Get-PCInfo

## SYNOPSIS
Gather useful information from a remote PC.

## SYNTAX

```
Get-PCInfo [[-ComputerName] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns useful informaion on the local endpoint or another.

## EXAMPLES

### EXAMPLE 1
```
Get-PCInfo -ComputerName Computer1
```

Description
-----------
This will generate information from the remote computer using CIM Instances.

## PARAMETERS

### -ComputerName
Specify a remote computer to generate information for.

```yaml
Type: String
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
