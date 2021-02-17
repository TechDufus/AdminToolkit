# Remove-Path

## SYNOPSIS
Deletes folder recursively, so be careful.
If -Include is empty, it will delete all files, otherwise it will delete only the ones you -Include.

## SYNTAX

```
Remove-Path [-Path] <Object> [-Include] <Object> [<CommonParameters>]
```

## DESCRIPTION
This command deletes all files recursively in a path that match the included filename.

## EXAMPLES

### EXAMPLE 1
```
Remove-Path C:\temp
```

Description
-----------
Specify the parent folder from which the command runs and specify file names to include.
Wildcards are supported.

Remove-Path -path c:\Folder -include "*.logs"

## PARAMETERS

### -Path
Specify the path to recursively delete.

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

### -Include
Restrict the deletion to specific file names, types, etc..
by specifying them in this parameter.
See \`Get-Help Get-ChildItem -Parameter Include\` for more information.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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
