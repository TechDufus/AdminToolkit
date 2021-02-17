# Remove-OlderThan

## SYNOPSIS
Remove files in a directory recursively based on how many days since the files was changed.
Use negative values for -DaysBack.

## SYNTAX

```
Remove-OlderThan [-Path] <Object> [-DaysBack] <Int32> [-Recurse] [<CommonParameters>]
```

## DESCRIPTION
This scripts function is to delete files and folders older than x days recursively.

## EXAMPLES

### EXAMPLE 1
```
Delete-OlderThan -Path "C:\Folder" -DaysBack 90
```

## PARAMETERS

### -Path
Specify the root path to delete items from.

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

### -DaysBack
Specify the amount of days old since a file was edited to delete.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Recurse
Search recursively for files.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Handle: @matthewjdegarmo

You can either submit a \[PR\](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit

Change Log:
Version: 1.0 - Function Creation.

## RELATED LINKS
