# Get-ContentWithLineNumbers

## SYNOPSIS
Mimic Unix / Linux tool nl number lines

## SYNTAX

### File
```
Get-ContentWithLineNumbers [-FileName] <String> [<CommonParameters>]
```

### Input
```
Get-ContentWithLineNumbers [-InputObject <Object>] [<CommonParameters>]
```

## DESCRIPTION
Print file content with numbered lines no original nl options supported

## EXAMPLES

### EXAMPLE 1
```
Get-ContentWithLineNumbers -FileName C:\Foo.txt
```

Description
-----------
This will append line numbers to the begninning of each line in the Foo.txt file.

## PARAMETERS

### -FileName
Specify a file to extract and prefix with line numbers.

```yaml
Type: String
Parameter Sets: File
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -InputObject
Specify an object of text to prefix with line numbers.

```yaml
Type: Object
Parameter Sets: Input
Aliases:

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
Site: https://matthewjdegarmo.github.io

You can either submit a \[PR\](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit

## RELATED LINKS
