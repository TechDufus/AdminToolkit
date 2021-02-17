# Get-PrintManagement

## SYNOPSIS
Quickly launch Print Management MSC Snap-in

## SYNTAX

```
Get-PrintManagement [[-ComputerName] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Opens Print Management for the local PC and one remote PC using -ComputerName

## EXAMPLES

### EXAMPLE 1
```
Get-PrintManagement -ComputerName Computer1
```

Description
-----------
This will open PrintManagement on the local machine and connect to the remote \`Computer1\`

## PARAMETERS

### -ComputerName
Specify the remote computer to open Print Management against.

```yaml
Type: String[]
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
Handle: @matthewjdegarmo

You can either submit a \[PR\](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit

## RELATED LINKS
