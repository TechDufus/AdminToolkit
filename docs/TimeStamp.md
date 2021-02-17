# TimeStamp

## SYNOPSIS
This is a filter used to place colorized timestamps on any output messages.

## SYNTAX

```
TimeStamp [[-color] <Object>] [[-NoNewLine] <Object>]
```

## DESCRIPTION
The function \`TimeStamp\` is a colorized version of this command \`DateStamp\`, but \`TimeStamp\` output cannot be written to a file.
You will want to use \`DateStamp\` if you are going to output your messages into a log or txt file.

## EXAMPLES

### EXAMPLE 1
```
"ERROR: Something bad happened on this line of the script" | TimeStamp
```

\[08/04/2020 11:55:39\] : ERROR: Something bad happened on this line of the script

Description
-----------
This line will place a time stamp at the beginning of the line that can only be written to the console and not to a file.

### EXAMPLE 2
```
"ERROR: Something bad happened on this line of the script" | TimeStamp Red
```

\[08/04/2020 11:56:40\] : ERROR: Something bad happened on this line of the script

Description
-----------
This will colorize the timestamp, and turn the provided string red.
You can provide any color usable by Write-Host -ForegroundColor.

### EXAMPLE 3
```
"ERROR: " | TimeStamp Red NoNewLine;"Something bad happened on this line fo the script"
```

\[08/04/2020 11:58:54\] : ERROR: Something bad happened on this line fo the script

Description
-----------
This will colorize the TimeStamp, and make "ERROR: " Red, and with \`NoNewLine\` provided, you can add additional non-colorized text to the same line.

## PARAMETERS

### -color
Specify the color to display the message text.
See \`\[System.ConsoleColor\].GetEnumNames()\` for full list of colors.

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

### -NoNewLine
Specify this to change the color of the first segment of text, and not the rest.
See Example #3.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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
