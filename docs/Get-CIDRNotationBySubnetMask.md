# Get-CIDRNotationBySubnetMask

## SYNOPSIS
Quickly generate the CIDR "slash" notation for a given subnet mask.

## SYNTAX

```
Get-CIDRNotationBySubnetMask [-SubnetMask] <String> [<CommonParameters>]
```

## DESCRIPTION
This will provide the CIDR value for a subnet mask.
This function will also error if the subnet mask is not valid.

## EXAMPLES

### EXAMPLE 1
```
Get-CIDRNotationBySubnetMask 255.255.255.0
```

24
Description
-----------
Providing the SubnetMask, this returns the correct CIDR abreviation.
CIDR is used like this: 192.168.1.0/24

## PARAMETERS

### -SubnetMask
Specify the subnet mask to generate the CIDR Notation for.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Matthew J.
DeGarmo
Site: https://matthewjdegarmo.github.io

You can either submit a \[PR\](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit

## RELATED LINKS
