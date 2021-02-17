# Get-Definition

## SYNOPSIS
Gets the back-end definition of a function.

## SYNTAX

```
Get-Definition [-Function] <String> [<CommonParameters>]
```

## DESCRIPTION
This function will export a string of the code that defines a function.

## EXAMPLES

### EXAMPLE 1
```
Get-Definition Get-Definition
```

Description
-----------
This will get the function definitnion for the \`Get-Definition\` command itself.

### EXAMPLE 2
```
Get-Definition glo | Clip
```

Description
-----------
This will get the definition for the \`glo\` aliased command, and pipe it into your clipboard using the clip.exe file.

## PARAMETERS

### -Function
This parameter takes a function name, or an alias name, to generate the function definition.

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
