# Get-PCUpTime

## SYNOPSIS
Get the amount of time since the last boot-up sequence for a computer.

## SYNTAX

```
Get-PCUpTime [[-ComputerName] <Object>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet uses Get-CimInstance to gather the .LastBootUpTime for the local or remote computer. 
PowerShell 7 comes with a \`Get-Uptime\` cmdlet, so if called from PowerShell, it will simply call or invoke that cmdlet.
otherwise when called from Windows Powershell, it will invoke a CimInstance.

## EXAMPLES

### EXAMPLE 1
```
Get-PCUpTime
```

Description
-----------
This will return the current UpTime value for the local computer.

### EXAMPLE 2
```
Get-PCUpTime Remote-Server
```

Description
-----------
This will query \`Remote-Server\` for it's uptime data.

## PARAMETERS

### -ComputerName
Specify the remote computer to query using CIM.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
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

## RELATED LINKS
