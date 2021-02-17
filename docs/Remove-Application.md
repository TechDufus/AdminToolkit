# Remove-Application

## SYNOPSIS
Attempt to Uninstall an application.

## SYNTAX

```
Remove-Application [-Application] <Object> [<CommonParameters>]
```

## DESCRIPTION
This command uninstalls an application.
Good for when elevated privileges are needed from a user session.

## EXAMPLES

### EXAMPLE 1
```
Specify the installed application being uninstalled. The full application name must be used.
```

Remove-AppName -Application 'App Name has spaces'

### EXAMPLE 2
```
Find application using Get-Applications and pipe the correct item into Remove-Application.
```

Get-Applications | Where-Object { $_.DisplayName -match 'vim' } | Remove-Application

## PARAMETERS

### -Application
Specify the application name to delete.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
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
