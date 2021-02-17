# LL

## SYNOPSIS
This is a colorized version of Get-ChildItem (dir, ls).

## SYNTAX

```
LL [[-Directory] <String>] [[-All] <Object>] [<CommonParameters>]
```

## DESCRIPTION
This function will change the color of object names using Get-ChildItem based on the object type or extension.
You can define more extensions and their associated colors if you wish.

## EXAMPLES

### EXAMPLE 1
```
LL C:\Temp
```

Description
-----------
Display a colorized output for \`Get-ChildItem\` at C:\Temp.

### EXAMPLE 2
```
ll
```

Description
-----------
Display a colorized output for \`Get-ChildItem\` at the current working directory.

## PARAMETERS

### -Directory
Specify the directory to get items for.
Default is '.' or current directory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### -All
Essentially this is a \`-Force\` switch on Get-ChildItem.
By default this is set to $false.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
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
