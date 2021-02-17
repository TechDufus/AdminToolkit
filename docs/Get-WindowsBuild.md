# Get-WindowsBuild

## SYNOPSIS
Gets Windows Build information.

## SYNTAX

```
Get-WindowsBuild [[-ComputerName] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
This will query the local PC OR an array of remote PC's

## EXAMPLES

### EXAMPLE 1
```
ConnectTeams
```

Description
-----------
This will attempt a connection to portal.office.com.
This will prompt you for account information like what password to use.

### EXAMPLE 2
```
ConnectTeams -Credential 'SomeAccount@Email.com'
Description
-----------
This will attempt a connection to portal.office.com. This will prompt you for account information like what password to use.
```

## PARAMETERS

### -ComputerName
Specify the remote computer to query.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $env:COMPUTERNAME
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]
###     You must specify the value for Credential. You cannot pipe a value to this function.
## OUTPUTS

### None
###     There are no outputs.
## NOTES
Author: Matthew J.
DeGarmo
Handle: @matthewjdegarmo

You can either submit a \[PR\](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit

## RELATED LINKS
