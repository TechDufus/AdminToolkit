#Region Remove-PrintQueue

<#
.Synopsis
    Quickly clear print que from all installed printers.
.DESCRIPTION
    This command clears print queues for all printers, including network printers. If you specify a single printer using -Printer, you will NOT clear all installed printers.
.PARAMETER Printer
    Specify the printer name to clear.
.EXAMPLE
    PS> Remove-PrintQueue -Printer Some_printer_name1
    
    Description
    -----------
    This will delete all of the current print jobs on the network printer 'Some_printer_name1'
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/HelpDesk/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk

    Change Log:
    Version: 1.0 - Function Creation.
#>
Function Remove-PrintQueue {
    [CmdletBinding()]
    param (
        [string]$Printer
    )

    if ($Printer) {
        $Printers = Get-Printer -Name *$Printer*
    }
    else {
        $Printers = Get-Printer 
    }

    foreach ($printer in $printers) {
        $printjobs = Get-PrintJob -PrinterObject $printer
        foreach ($printjob in $printjobs) {
            Remove-PrintJob -InputObject $printjob
        }
    }
}
#EndRegion Remove-PrintQueue