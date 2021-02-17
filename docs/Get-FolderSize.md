# Get-FolderSize

## SYNOPSIS
Quickly calculate the size of a directory.

## SYNTAX

```
Get-FolderSize [[-Folder] <Object>] [<CommonParameters>]
```

## DESCRIPTION
This function will calculate the disk space used by a specified directory.
This uses the current directory by default.

## EXAMPLES

### EXAMPLE 1
```
Get-FolderSize
```

Description
-----------
This will display the folder size of the current folder location \`Get-Location\`

## PARAMETERS

### -Folder
Specify the folder to query.
This defaults to the current directory.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: (Get-Location)
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
