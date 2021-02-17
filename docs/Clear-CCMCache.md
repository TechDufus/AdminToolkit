# Clear-CCMCache

## SYNOPSIS
Clear local CCM Cache.

## SYNTAX

```
Clear-CCMCache [[-ComputerName] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
This command will clear the local or remote ccm cache.

## EXAMPLES

### EXAMPLE 1
```
Clear-CCMCache
```

Description
-----------
Clear the CCM Cache on the local system.

### EXAMPLE 2
```
Clear-CCMCache -ComputerName Some-Remote-PC
```

Description
-----------
This will attempt to connect and clear the CCM Cache from the computer specified.

### EXAMPLE 3
```
Clear-CCMCache -ComputerName pc1,pc2,pc3,pc4,pc5
```

Description
-----------
This will attempt to connect to each computer listed to clear the local CCM Cache.

## PARAMETERS

### -ComputerName
Specify the remote system to connect to and clear.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $env:COMPUTERNAME
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

You can either submit a \[PR\](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit

## RELATED LINKS
