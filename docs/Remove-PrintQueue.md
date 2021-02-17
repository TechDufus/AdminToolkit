# Remove-PrintQueue

## SYNOPSIS
Quickly clear print que from all installed printers.

## SYNTAX

```
Remove-PrintQueue [[-Printer] <String>] [<CommonParameters>]
```

## DESCRIPTION
This command clears print queues for all printers, including network printers.
If you specify a single printer using -Printer, you will NOT clear all installed printers.

## EXAMPLES

### EXAMPLE 1
```
Remove-PrintQueue -Printer Some_printer_name1
```

Description
-----------
This will delete all of the current print jobs on the network printer 'Some_printer_name1'

## PARAMETERS

### -Printer
Specify the printer name to clear.

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

Change Log:
Version: 1.0 - Function Creation.

## RELATED LINKS
