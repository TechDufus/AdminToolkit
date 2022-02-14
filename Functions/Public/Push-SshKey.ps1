#Region Push-SshKey

<#
.SYNOPSIS
    Setup SSH keys for the current user on a remote system.
.DESCRIPTION
    This command will setup SSH keys for the current user on a remote system.
.PARAMETER GenerateNewKeys
    If set to true, a new SSH key pair will be generated.
.PARAMETER Force
    If set to true, the SSH key pair will be overwritten if it already exists.
.PARAMETER PublicKeyFile
    The path to the public key file.
.PARAMETER Username
    The username on the remote system.
.EXAMPLE
    Push-SshKey -GenerateNewKeys -Force -Username root

    Description:
    ------------
    Generate a new SSH key pair and push it to the remote system under the 'root' user.
.EXAMPLE
    Push-SshKey -PublicKeyFile C;\Users\admin\.ssh\id_rsa.pub -Username root

    Description:
    ------------
    Push the public key file to the remote system under the 'root' user.
.NOTES
    Author:  matthewjdegarmo
    GitHub:  https://github.com/matthewjdegarmo
    Sponsor: https://github.com/sponsors/matthewjdegarmo
#>
Function Push-SshKey() {
    [CmdletBinding()]
    Param(
        [Parameter(ParameterSetName = 'GenerateKeys')]
        [Switch]$GenerateNewKeys,

        [Parameter(ParameterSetName = 'GenerateKeys')]
        [System.String]$KeyName = 'id_rsa',

        [Parameter(ParameterSetName = 'GenerateKeys')]
        [Switch]$Force,
        
        [Parameter(ParameterSetName = 'DeclaredKeys')]
        [ValidateScript({
                Test-Path $_
            })]
        [System.String] $PublicKeyFile,

        [Parameter()]
        [System.String]$Username = $env:USERNAME,

        [Parameter(Mandatory)]
        [System.String]$ComputerName
    )

    Begin {
        If (-Not(Get-Command 'ssh') -or -Not(Get-Command 'ssh-keygen')) {
            Throw "SSH is not installed on this system. Please install it and try again."
        }
    }

    Process {
        Try {
            If ($GenerateNewKeys.IsPresent) {
                $DefaultKeysSplat = @{
                    Force   = [bool]$Force.IsPresent
                    KeyName = $KeyName
                }
                $Keys = New-DefaultSshKeys @DefaultKeysSplat
            }
            Else {
                $Keys = [PSCustomObject] @{
                    PublicKey = Get-ChildItem (Resolve-Path -Path $PublicKeyFile)
                }
            }
            
            Get-Content $Keys.PublicKey | ssh $Username@$ComputerName "mkdir -p ~/.ssh; cat >> .ssh/authorized_keys"
        }
        Catch {
            Throw $_
        }
    }

    End {}
}
#EndRegion Push-SshKey