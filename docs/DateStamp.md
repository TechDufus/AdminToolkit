# DateStamp

## SYNOPSIS
This is a filter used to place timestamps on any output messages.

## SYNTAX

```
DateStamp [<CommonParameters>]
```

## DESCRIPTION
The function \`TimeStamp\` is a colorized version of this command \`DateStamp\`, but \`TimeStamp\` output cannot be written to a file.
You will want to use \`DateStamp\` if you are going to output your messages into a log or txt file.

## EXAMPLES

### EXAMPLE 1
```
"ERROR: Something bad happened on this line of the script" | DateStamp
```

\[08/04/2020 11:34:35\]: ERROR: Something bad happened on this line of the script

Description
-----------
This line will place a time stamp at the beginning of the line that can be written to a file.

## PARAMETERS

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
