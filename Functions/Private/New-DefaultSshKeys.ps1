#Region New-DefaultSshKeys

<#
.SYNOPSIS
    Generate new default keys for the currently running user.
.DESCRIPTION
    Generates new default keys for the currently running user.
.PARAMETER Force
    If true, the keys will be overwritten if they already exist.
.EXAMPLE
    New-DefaultSshKeys

    Description:
    ------------
    Generates new default keys for the currently running user.
.EXAMPLE
    New-DefaultSshKeys -Force

    Description:
    ------------
    Generates new default keys for the currently running user. This will overwrite any existing keys.
.NOTES
    Author:  matthewjdegarmo
    GitHub:  https://github.com/matthewjdegarmo
    Sponsor: https://github.com/sponsors/matthewjdegarmo
#>
Function New-DefaultSshKeys() {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param(
        [Parameter(Mandatory)]
        [System.String]$KeyName,

        [Switch]$Force
    )

    Begin {
        If (-Not(Get-Command 'ssh-keygen')) {
            Throw "SSH-KEYGEN is not installed on this system. Please install it and try again."
        }
    }

    Process {
        Try {
            $NewKeyPath = [System.IO.Path]::Combine($env:USERPROFILE, '.ssh', $KeyName)
            If ((Test-Path $NewKeyPath) -And -Not($Force.IsPresent)) {
                Throw "A key already exists at $NewKeyPath. Use -Force to overwrite."
            }

            $Operation = "You are about to overwrite existing ssh key pairs [$KeyName]. Are you sure you want to do this?"
            If ($Force.IsPresent) {
                If ($PSCmdlet.ShouldProcess("WHERE IS THIS?!","Keys: $NewKeyPath, $NewKeyPath.pub",$Operation)) {
                    If (Test-Path $NewKeyPath) {
                        Write-Host "Removing existing keys at $NewKeyPath" -ForegroundColor Cyan -BackgroundColor Black
                        Remove-Item $NewKeyPath -Force
                        Remove-Item "$NewKeyPath.pub" -Force
                    }
                } Else {
                    break
                }
            }
            Write-Host "Generating new keys at $NewKeyPath" -ForegroundColor Cyan -BackgroundColor Black
            ssh-keygen -b 2048 -t rsa -f "$NewKeyPath" -q -N '""'

            [PSCustomObject]@{
                PrivateKey = (Get-ChildItem $NewKeyPath)
                PublicKey  = (Get-ChildItem "$NewKeyPath.pub")
            }
        }
        Catch {
            Throw $_
        }
    }

    End {}
}
#EndRegion New-DefaultSshKeys