# grep

## SYNOPSIS
Basic version of the linux command \`grep\` on Windows.

## SYNTAX

```
grep [[-regex] <Object>]
```

## DESCRIPTION
This is a windows version of the linux \`grep\` command.
I still need to figure out how to NOT import this command when on a linux system.
This is basically a shorter \`Select-String\`, and does not support other grep flags as on a Linux system.

## EXAMPLES

### EXAMPLE 1
```
Get-Process | grep powershell
```

Description
-----------
This will filter the \`Get-Process\` output with the regex 'powershell'.

## PARAMETERS

### -regex
Specify the regex pattern to filter for.

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
