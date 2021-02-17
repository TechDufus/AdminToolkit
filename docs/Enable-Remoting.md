# Enable-Remoting

## SYNOPSIS
Enable PSRemoting via PSEXEC remotely.

## SYNTAX

```
Enable-Remoting [-ComputerName] <String> [-Username] <String> [[-Password] <SecureString>] [<CommonParameters>]
```

## DESCRIPTION
This Command will enable PowerShell Remoting on a remote PC.

## EXAMPLES

### EXAMPLE 1
```
Enable-PSRemoting -computer PCName -username domain\username
```

Description
-----------
This will enable remoting and then prompt for credentials

## PARAMETERS

### -ComputerName
Specify a remote computer to run against.

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

### -Username
Specify a username to use to make the remote connection.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
Specify the respective password to match the Username provided.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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

Change Log:
Version: 1.0 - Function Creation.

This Function requires psexec.
If you do not, download it with the sysinternals suite.
Add psexec to one of your enviroment variable paths.

## RELATED LINKS
