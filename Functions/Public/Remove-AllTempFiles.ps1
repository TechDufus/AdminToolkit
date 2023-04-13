#Region Remove-AllTempFiles

<#
.Synopsis
    Generic Cleanup of temp files on a computer.

.Description
    This Command removes log files, temp files, and empties the recycle bin. Access denied errors do not indicate a failure of the script. Run for the local or a remote PC.

.PARAMETER ComputerName
    Specify a remote computer to run against.

.EXAMPLE
    PS> Remove-All

    Description
    -----------
    Free up space on the local computer

.EXAMPLE
    PS> Remove-All -Computer Test-PC-01

    Description
    -----------
    Free up space on a remote PC. May be more effective if run locally depending on in place security.

.NOTES
    Author: Matthew J. DeGarmo
    Handle: @TechDufus

    You can either submit a [PR](https://github.com/TechDufus/AdminToolkit/pulls)
        or create an [Issue](https://github.com/TechDufus/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/TechDufus/AdminToolkit
#>
Function Remove-AllTempFiles() {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter()]$ComputerName
    )

    #Statement of Free Space before Cleaning
    Write-Host " "
    Write-Host "Free Space Before Cleaning" -ForegroundColor Yellow
    Get-CimInstance win32_logicaldisk -filter "drivetype=3" -computer $ComputerName |
    Format-Table -Property DeviceID, Volumename, `
    @{Name = "SizeGB"; Expression = { [math]::Round($_.Size / 1GB) } }, `
    @{Name = "FreeGB"; Expression = { [math]::Round($_.Freespace / 1GB, 2) } }, `
    @{Name = "PercentFree"; Expression = { [math]::Round(($_.Freespace / $_.size) * 100, 2) } }

    #Statement that the function is freeing up space
    Write-Host "Freeing up space. Enjoy your Coffee!" -BackgroundColor Black -ForegroundColor Green

    #Free up space on the local or remote computer
    if ($null -ne $ComputerName) {
        $ErrorActionPreference = 'SilentlyContinue'

        Get-Service -ComputerName $ComputerName TrustedInstaller | Stop-Service -Force
        Get-ChildItem -path "\\$ComputerName\C$\windows\logs" -Include '*.log' -Recurse -force | Remove-Item -force -Recurse
        Get-ChildItem -path "\\$ComputerName\C$\windows\logs" -Include '*.cab' -Recurse -force | Remove-Item -force -Recurse
        Get-ChildItem -path "\\$ComputerName\C$\ProgramData\Microsoft\Windows\WER" -Include '*.*' -Recurse -force | Remove-Item -force -Recurse
        Get-ChildItem -path "\\$ComputerName\C$\`$recycle.bin" -Include '*' -Recurse -force | Remove-Item -force -Recurse
        Get-ChildItem -path "\\$ComputerName\C$\Users\*\AppData\Local\Google\Chrome\User Data\Default\Cache\" -include '*.*' -Recurse -force | Remove-Item -force -Recurse
        Get-ChildItem -path "\\$ComputerName\C$\Users\*\AppData\Local\Microsoft\Terminal Server Client\" -include '*.*' -Recurse -force | Remove-Item -force -Recurse
        $tempfolders = @("\\$ComputerName\C$\Windows\Temp\*", "\\$ComputerName\C$\Windows\Prefetch\*", "\\$ComputerName\C$\Documents and Settings\*\Local Settings\temp\*", "\\$ComputerName\C$\Users\*\Appdata\Local\Temp\*")
        Remove-Item $tempfolders -force -recurse -errorAction SilentlyContinue
        $tempinternetfolders = @("\\$ComputerName\C$\Users\*\Appdata\Local\Microsoft\Windows\INetCache\*", "\\$ComputerName\C$\Users\*\Appdata\Local\Microsoft\Windows\Cookies\*", "\\$ComputerName\C$\Users\*\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*")
        Remove-Item $tempinternetfolders -force -recurse -errorAction SilentlyContinue
        Get-Service -ComputerName $ComputerName -Name TrustedInstaller | Start-Service

        $ErrorActionPreference = 'Continue'

        Write-Host " "
        Write-Host "Free Space After Cleaning" -ForegroundColor Yellow
        Get-CimInstance win32_logicaldisk -filter "drivetype=3" -computer $ComputerName |
        Format-Table -Property DeviceID, Volumename, `
        @{Name = "SizeGB"; Expression = { [math]::Round($_.Size / 1GB) } }, `
        @{Name = "FreeGB"; Expression = { [math]::Round($_.Freespace / 1GB, 2) } }, `
        @{Name = "PercentFree"; Expression = { [math]::Round(($_.Freespace / $_.size) * 100, 2) } }
    }

    else {
        $ErrorActionPreference = 'SilentlyContinue'

        Stop-Service TrustedInstaller -Force
        Get-ChildItem -path "C:\windows\" -Include '*.log' -Recurse -force | Remove-Item -force -Recurse
        Get-ChildItem -path "C:\windows\logs" -Include '*.cab' -Recurse -force | Remove-Item -force -Recurse
        Get-ChildItem -path "C:\ProgramData\Microsoft\Windows\WER" -Include '*.*' -Recurse -force | Remove-Item -force -Recurse
        Get-ChildItem -path "c:\`$recycle.bin" -Include '*' -Recurse -force | Remove-Item -force -Recurse
        Get-ChildItem -path "C:\Users\*\AppData\Local\Google\Chrome\User Data\Default\Cache\" -include '*.*' -Recurse -force | Remove-Item -force -Recurse
        Get-ChildItem -path "C:\Users\*\AppData\Local\Microsoft\Terminal Server Client\" -include '*.*' -Recurse -force | Remove-Item -force -Recurse
        $tempfolders = @("C:\Windows\Temp\*", "C:\Windows\Prefetch\*", "C:\Documents and Settings\*\Local Settings\temp\*", "C:\Users\*\Appdata\Local\Temp\*")
        Remove-Item $tempfolders -force -recurse -errorAction SilentlyContinue
        $tempinternetfolders = @("C:\Users\*\Appdata\Local\Microsoft\Windows\INetCache\*", "C:\Users\*\Appdata\Local\Microsoft\Windows\Cookies\*", "C:\Users\*\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*")
        Remove-Item $tempinternetfolders -force -recurse -errorAction SilentlyContinue
        powercfg.exe /hibernate off
        Remove-Item c:\hiberfil.sys -force -ErrorAction SilentlyContinue
        Start-Service TrustedInstaller

        $ErrorActionPreference = 'Continue'

        Write-Host " "
        Write-Host "Free Space After Cleaning" -ForegroundColor Yellow
        Get-CimInstance win32_logicaldisk -filter "drivetype=3" -computer $ComputerName |
        Format-Table -Property DeviceID, Volumename, `
        @{Name = "SizeGB"; Expression = { [math]::Round($_.Size / 1GB) } }, `
        @{Name = "FreeGB"; Expression = { [math]::Round($_.Freespace / 1GB, 2) } }, `
        @{Name = "PercentFree"; Expression = { [math]::Round(($_.Freespace / $_.size) * 100, 2) } }
    }
}
#EndRegion Remove-AllTempFiles
