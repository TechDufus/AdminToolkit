# Update-PowerShell

## SYNOPSIS
This will both Install the latest release of PowerShell or update your current PowerShell.

## SYNTAX

```
Update-PowerShell [-Preview] [-Quiet] [<CommonParameters>]
```

## DESCRIPTION
This one-liner is provided by \[Tyler Leonhardt\](https://github.com/TylerLeonhardt).
I have added some parameters to help customize the install of the .MSI

## EXAMPLES

### EXAMPLE 1
```
Update-Powershell -Preview
```

Description
-----------
This will update or install PowerShell with the latest Preview release.

### EXAMPLE 2
```
Update-Powershell -Quiet
```

Description
-----------
This will update or install the latest General Release version of PowerShell.

## PARAMETERS

### -Preview
Specifying this switch will install the latest preview version of PowerShell.
Otherwise this will install / update the latest stable release.

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

### -Quiet
Specifying this switch will install or update quietly with no gui popup, taking all defaults of the install.
You need to run as admin to use this switch.

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

## RELATED LINKS
