# Locate

## SYNOPSIS
Quickly search a location for a file, folder, hidden file, etc...
This should return the same object that Get-ChildItem returns.

## SYNTAX

```
Locate [[-Filter] <String>] [[-Path] <String>] [-Include <String[]>] [-Exclude <String[]>] [-Force] [-Recurse]
 [-Directory] [-File] [-System] [-Hidden] [-ReadOnly] [<CommonParameters>]
```

## DESCRIPTION
This function takes a -Filter and applies dual-wildcards for maximum search results.
By default this will search recursively in the local directory, but you can specify 
any custom location.

## EXAMPLES

### EXAMPLE 1
```
Locate AdminToolkit.psd1 -Recurse
```

Description
-----------
This will search from the current working directory for files or folders mathing the filter 'AdminToolkit.psd1'

### EXAMPLE 2
```
locate foo.txt C:\temp
```

Description
-----------
This will search for the file foo.txt in the directory C:\temp.

### EXAMPLE 3
```
locate test -Recurse -Exclude *.tests.*
```

Directory: C:\Temp\HelpDesk\Functions\Public

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---            8/5/2020 11:51 AM           6985 Test-Administrator.ps1

Directory: C:\Temp\HelpDesk

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----            8/5/2020  2:07 PM                Tests

Description
-----------
This will search recursively using the filter 'test' and exclude files/folders that match '*.tests.*'

## PARAMETERS

### -Filter
{{ Fill Filter Description }}

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

### -Path
{{ Fill Path Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: (Get-Location)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include
{{ Fill Include Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exclude
{{ Fill Exclude Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
{{ Fill Force Description }}

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

### -Recurse
{{ Fill Recurse Description }}

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

### -Directory
{{ Fill Directory Description }}

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

### -File
{{ Fill File Description }}

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

### -System
{{ Fill System Description }}

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

### -Hidden
{{ Fill Hidden Description }}

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

### -ReadOnly
{{ Fill ReadOnly Description }}

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
