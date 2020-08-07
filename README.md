# AdminToolkit
PowerShell Module to assist Windows Admins. This contains many useful administration and utility functions.

![License](https://img.shields.io/github/license/matthewjdegarmo/AdminToolkit)
<!--
[![Known Vulnerabilities](https://snyk.io/test/github/dwyl/hapi-auth-jwt2/badge.svg)](https://snyk.io/test/github/matthewjdegarmo/HelpDesk)
-->
## Installing

```powershell
# For CurrentUser scope
git clone https://github.com/matthewjdegarmo/AdminToolkit.git $PSGetPath.CurrentUserModules

# For AllUsers scope. Must be Admin.
git clone https://github.com/matthewjdegarmo/AdminToolkit.git $PSGetPath.AllUsersModules
```

PowerShell will now Auto-Load the commands in this module.

## Updating
Navigate into the cloned AdminToolkit folder and run `git pull` to pull the current main (master) branch.
```powershell
# For CurrentUser scope
Set-Location $PSGetPath.CurrentUserModules
git pull

# For AllUsers scope. Must be Admin.
Set-Location $PSGetPath.AllUsersModules
git pull
```
