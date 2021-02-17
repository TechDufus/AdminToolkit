# Copy-WithProgress

## SYNOPSIS
This function performs a copy of a specified object recursively to a specified location.

## SYNTAX

```
Copy-WithProgress [-Source] <Object> [-Destination] <Object> [-IncludeACL] [<CommonParameters>]
```

## DESCRIPTION
This function is a glorified Copy-Item in that it will show progress data.
If moving 10,000 files that equal 2GB in size, it will show you what file you are currently on as well as how much data has been moved / what is left using Write-Progress.

## EXAMPLES

### EXAMPLE 1
```
Copy-WithProgress -Source "C:\Scripts\TestFile.ps1" -Destination "C:\Temp\TestFile.ps1"
```

Description
-----------
This will copy the source file to the file specified in Destination.
Note that the filename for Destination can be anything and does not have to match the original.

### EXAMPLE 2
```
Copy-WithProgress -Source .\Folder -Destination .\Folder1 -IncludeACL
```

Description
-----------
This will copy all contents of .\Folder to .\Folder1 and include the Acl / NTFS permissions.

## PARAMETERS

### -Source
Source should specify the object to be copied by name.
This value must be the FullPath and cannot be shortened.
An example would be if you were in the C:\Scripts directory, you could not specify '.\TestFile.ps1' as the source location, you must specify 'C:\Scripts\TestFile.ps1' in this case.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Destination
Destination should specify the target location of the specified Source by name.
This value must be the FullPath and cannot be shortened.
An example would be if you were in the C:\Scripts directory, you could not specify '.\TestFile.ps1' as the Destination location, you must specify 'C:\Scripts\TestFile.ps1' in this case

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeACL
With this present, this will copy the ACL from each source file and apply it to the destination file.

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

### System.String[]
###     This function does not accept pipeline data. The values for all parameters must be specified.
## OUTPUTS

### None
###     This function does not produce output except for the Write-Progress data.
## NOTES
Author: Matthew J.
DeGarmo
Handle: @matthewjdegarmo

You can either submit a \[PR\](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit

## RELATED LINKS
