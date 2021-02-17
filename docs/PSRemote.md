# PSRemote

## SYNOPSIS
Starts an Enter-PSSession with the specified Server.

## SYNTAX

```
PSRemote [-ComputerName] <String> [[-Credential] <PSCredential>] [-IncludeModule <String[]>]
 [-IncludeProfile <String>] [<CommonParameters>]
```

## DESCRIPTION
PSRemote will attempt to enter a PSSession with a specified host with a specified account.
If no Credential is specified, it will use the currently signed in account to connect.

## EXAMPLES

### EXAMPLE 1
```
PSRemote -ComputerName Computer1 -Credential matthewjd
```

Description
-----------
This will attempt to start a PSSession with Computer1 as matthewjd.
This will prompt for a password for matthewjd.

### EXAMPLE 2
```
PSRemote Computer1 -IncludeModule AdminToolkit
Description
-----------
This will use the currently signed in account to connect to attempt a connection with Computer1 and import the module Helpdesk.
```

## PARAMETERS

### -ComputerName
This parameter specifies what host to attempt an Enter-PSSession with.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
This parameter is used to change the current account for the PSSession.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeModule
This parameter specifies any local installed / imported modules to be defined in the remote scope.
Essentially bringing any local modules with you without installing them on the remote machine.

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

### -IncludeProfile
Specify a local profile to load in the remote session.

```yaml
Type: String
Parameter Sets: (All)
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

### System.String[]
###     You must specify the value for Computername. You cannot pipe a value to this function.
## OUTPUTS

### None
###     There are no outputs except for Write-Host messages.
## NOTES
Author: Matthew J.
DeGarmo
Handle: @matthewjdegarmo

You can either submit a \[PR\](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit

Change Log:
Version: 2.0 - Added -IncludeModule parameter.
This will allow you to import a local module into your remote session.
Version: 1.0 - Function Creation.

## RELATED LINKS
