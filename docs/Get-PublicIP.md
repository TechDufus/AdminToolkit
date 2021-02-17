# Get-PublicIP

## SYNOPSIS
Generates your current Public IP Information

## SYNTAX

```
Get-PublicIP [[-IP] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Returns WhoIS public IP info for your location or any specified public IP.
By Default, returns your current public IP info.

## EXAMPLES

### EXAMPLE 1
```
Get-PublicIP
```

Description
-----------
Returns local Public IP Info

Get-PublicIP

### EXAMPLE 2
```
Get-PublicIP -IP 8.8.8.8
```

Description
-----------
Returns Public IP Info for 8.8.8.8

Get-PublicIP -IP 8.8.8.8

## PARAMETERS

### -IP
Specify the IP Address to look up information for.
This uses your current public IP by default.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
