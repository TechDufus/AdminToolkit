# AdminToolkit
PowerShell Module to assist Windows Admins. This contains many useful administration and utility functions.

[![Build Status](https://dev.azure.com/matthewjdegarmo/AdminToolkit/_apis/build/status/matthewjdegarmo.AdminToolkit?branchName=master)](https://dev.azure.com/matthewjdegarmo/AdminToolkit/_build/latest?definitionId=1&branchName=master)
[![PSGallery](https://img.shields.io/powershellgallery/v/AdminToolkit?color=G&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/AdminToolkit/)
[![Downloads](https://img.shields.io/powershellgallery/dt/AdminToolkit?label=Downloads)](https://www.powershellgallery.com/packages/AdminToolkit/)
[![License](https://img.shields.io/github/license/matthewjdegarmo/AdminToolkit?color=g&label=License)](https://github.com/matthewjdegarmo/AdminToolkit/blob/master/LICENSE)
![CodeSize](https://img.shields.io/github/languages/code-size/matthewjdegarmo/AdminToolkit?label=Code%20Size)
<!--
[![Known Vulnerabilities](https://snyk.io/test/github/dwyl/hapi-auth-jwt2/badge.svg)](https://snyk.io/test/github/matthewjdegarmo/HelpDesk)
-->
## Install from PowerShell Gallery
```powershell
Install-Module AdminToolkit
```
##Update from PowerShell Gallery
```powershell
Update-Module AdminToolkit
```

## Installing with Git
### For Windows PowerShell 5.1 ###
```powershell
# For CurrentUser scope
git clone https://github.com/matthewjdegarmo/AdminToolkit.git ($env:PSModulePath -split ';')[0]

# For AllUsers scope. Must be Admin.
git clone https://github.com/matthewjdegarmo/AdminToolkit.git ($env:PSModulePath -split ';')[2]
```
### For PowerShell 6.0+ ###
```powershell
# For CurrentUser scope
git clone https://github.com/matthewjdegarmo/AdminToolkit.git $PSGetPath.CurrentUserModules

# For AllUsers scope. Must be Admin.
git clone https://github.com/matthewjdegarmo/AdminToolkit.git $PSGetPath.AllUsersModules
```

PowerShell will now Auto-Load the commands in this module.

## Updating with Git
Navigate into the cloned AdminToolkit folder and run `git pull` to pull the current main (master) branch.
### For Windows PowerShell 5.1 ###
```powershell
# For CurrentUser scope
Set-Location (Join-Path -Path ($env:PSModulePath -split ';')[0] -ChildPath AdminToolkit)
git pull

# For AllUsers scope. Must be Admin.
Set-Location (Join-Path -Path ($env:PSModulePath -split ';')[2] -ChildPath AdminToolkit)
git pull
```
### For PowerShell 6.0+ ###
```powershell
# For CurrentUser scope
Set-Location (Join-Path -Path $PSGetPath.CurrentUserModules -ChildPath AdminToolkit)
git pull

#For AllUsers scope. Must be Admin
Set-Location (Join-Path -Path $PSGetPath.AllUsersModules -ChildPath AdminToolkit)
git pull
```
