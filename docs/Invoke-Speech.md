# Invoke-Speech

## SYNOPSIS
Translate a string into an audible message.

## SYNTAX

```
Invoke-Speech [[-Message] <String>] [<CommonParameters>]
```

## DESCRIPTION
This function calls the SAPI.SPVoice class to invoke audio given a string.
This is useful when running long processes, you can audibly be alerted that a task is finished.

## EXAMPLES

### EXAMPLE 1
```
Get-SomeDataThatTakesAnHour;Invoke-Speech -Message "Your data is ready, sir."
```

Description
-----------
This will generated audio for the string 'Your data is ready, sir." depending on your volume level.

## PARAMETERS

### -Message
Specify the message to have voiced.

```yaml
Type: String
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
Site: https://matthewjdegarmo.github.io

You can either submit a \[PR\](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit

## RELATED LINKS
