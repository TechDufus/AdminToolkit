#Region SU
$DetectedOS = switch($true) {
    $IsWindows {'Windows'}
    $IsLinux   {'Linux'}
    $IsMacOS   {'MacOS'}
    DEFAULT    {'Windows'}
}

If ($DetectedOS -eq 'Windows') {
    <#
    .SYNOPSIS
        Windows version of the linux command `SU`
    .DESCRIPTION
        Immitate SU on Linux. This creates new PoSH Session as an admin.
    .PARAMETER NoExit
        Default `su` will close the current session and launch a new one as admin
        Specify `-NoExit` to keep the non-admin shell running.
    .EXAMPLE
        PS> su
        
        Description
        -----------
        Depending on what edition of powershell is running, this will start an elevated process and close the original process.
    .EXAMPLE
        PS> su -NoExit
    
        Description
        -----------
        This will keep the non-admin shell running and you will have two processes open.
    .NOTES
        Author: Matthew J. DeGarmo
        Handle: @matthewjdegarmo
    
        You can either submit a [PR](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
            or create an [Issue](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
            on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit
    #>
    function su() {
        [CmdletBinding()]
        param (
            [Switch] $NoExit
        )
        switch ($($PSVersionTable.PSEdition)) {
            "Desktop" { 
                $Parent = (Get-Process -Id $PID)
                Switch($Parent.ProcessName) {
                    'powershell_ise' {
                        Start-Process $Parent.Path -Verb RunAs 
                    }
                    'Code' {
                        #TODO: Detect VSCode running powershell.exe somehow
                    }
    
                    DEFAULT {
                        Start-Process Powershell -Verb RunAs 
                    }
                }
    
            }
            "Core" {
                $Parent = (Get-Process -Id $PID).Parent
                Switch($Parent.ProcessName) {
                    'WindowsTerminal' {
                        Start-Process wt.exe -Verb RunAs
                        If (-Not($NoExit.IsPresent)) {
                            exit
                        }
                    }
                    'Code' {
                        Start-Process $Parent.Path -Verb RunAs
                    }
                    DEFAULT {
                        Start-Process Pwsh -Verb RunAs
                    }
                }
            }
        }
    }
}

#EndRegion SU