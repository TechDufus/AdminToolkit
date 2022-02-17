#Region Push-SshKey

<#
.SYNOPSIS
    Setup SSH keys for the current user on a remote system.
.DESCRIPTION
    This command will setup SSH keys for the current user on a remote system.
.PARAMETER GenerateNewKeys
    If set to true, a new SSH key pair will be generated.
.PARAMETER KeyName
    The Basename of the SSH key pair.
.PARAMETER Force
    If set to true, the SSH key pair will be overwritten if it already exists.
.PARAMETER PublicKeyFile
    The path to the public key file.
.PARAMETER Username
    The username on the remote system.
.PARAMETER ComputerName
    The name or IPAddress of the remote computer.
.PARAMETER SshTarget
    Specify the typical user@computer format for the remote computer.
    This parameter cannot be used with the -Username and -ComputerName parameters.
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
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param(
        [Parameter(Mandatory,Position=0,ParameterSetName = 'GenerateKeyswithSshIdentity')]
        [Parameter(Mandatory,Position=0,ParameterSetName = 'DeclaredKeysWithSshIdentity')]
        [System.String]$SshTarget,

        [Parameter(ParameterSetName = 'GenerateKeyswithSshIdentity')]
        [Parameter(ParameterSetName = 'GenerateKeyswithTraditionalIdentity')]
        [Switch]$GenerateNewKeys,

        [Parameter(ParameterSetName = 'GenerateKeyswithSshIdentity')]
        [Parameter(ParameterSetName = 'GenerateKeyswithTraditionalIdentity')]
        [System.String]$KeyName = 'id_rsa',

        [Parameter(ParameterSetName = 'GenerateKeyswithSshIdentity')]
        [Parameter(ParameterSetName = 'GenerateKeyswithTraditionalIdentity')]
        [Switch]$Force,
        
        [Parameter(ParameterSetName = 'DeclaredKeysWithSshIdentity')]
        [Parameter(ParameterSetName = 'DeclaredKeysWithTraditionalIdentity')]
        [ValidateScript({
            Test-Path $_
        })]
        [Alias('i')]
        [System.String] $PublicKeyFile = '~/.ssh/id_rsa.pub',

        [Parameter(ParameterSetName = 'DeclaredKeysWithTraditionalIdentity')]
        [Parameter(ParameterSetName = 'GenerateKeyswithTraditionalIdentity')]
        [System.String]$Username = $env:USERNAME,
        
        [Parameter(Mandatory,ParameterSetName = 'DeclaredKeysWithTraditionalIdentity')]
        [Parameter(Mandatory,ParameterSetName = 'GenerateKeyswithTraditionalIdentity')]
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
            Switch ($PSCmdlet.ParameterSetName) {
                {$_ -eq 'DeclaredKeysWithSshIdentity' -OR $_ -eq 'GenerateKeyswithSshIdentity'} {
                    $Username = $SshTarget.Split('@')[0]
                    $ComputerName = $SshTarget.Split('@')[1]
                }
            }
            
            Write-Host "Pushing SSH key [$KeyName] to $Username@$ComputerName..." -ForegroundColor Cyan -BackgroundColor Black
            Get-Content $Keys.PublicKey | ssh $Username@$ComputerName "mkdir -p ~/.ssh; cat >> .ssh/authorized_keys"
        }
        Catch {
            Throw $_
        }
    }

    End {}
}
#EndRegion Push-SshKey