# Changelog for AdminToolkit

## v1.1.2.3

+ `Get-RebootLogs`
  + Significant performance improvement when querying event logs for this cmdlet

## v1.1.2.2

+ `Merge-CIDRIpRanges`
  + Refactor of function provided by [SeidChr](https://github.com/SeidChr).
  + This includes significant performance improvements.

## v1.1.2.1

+ `Merge-CIDRIpRanges`
  + Significant performance improvement to `Merge-CIDRIpRanges` function.

## v1.1.2

+ **New Functions:**
  + **Public**
    + `Merge-CIDRIpRanges`
      + Reduces a list of CIDR IP Ranges to a single list of ranges that do not overlap.
    + `Get-IPv4NetworkInfo`
      + Gets extended information about an IPv4 network.
  + **Private**
    + `Test-IsIpAddressInRange`
      + Test to see if a given IP is between a given start and end address.

## v1.1.1.3

+ `Get-PublicIP`
  + The output of this function is now a PSCustomObject instead of an enumerated hashtable.
+ Tests
  + Upgrading all tests to Pester v5 syntax.

## v1.1.1.2

**BUG FIX:**

+ Correcting variable references that were changed in v1.1.1
+ Using `Join-Path` instead of `[System.IO.Path]::Combine()`, this was buggy.

## v1.1.1

+ `Copy-WithProgress`
  + Changing the `-Source` parameter to `-Path` and adding an alias for `-Source`
    + This is to keep these parameters more aligned with `Copy-Item`.

## v1.1.0

+ `Get-FolderSize`
  + Added `-ComputerName` parameter to get folder sizes from remote machines.
  + The folder path provided needs to be the local path on the remote machine.
+ `SU`
  + Added additional parent process detection.
    + Instead of only launching `powershell.exe` or `pwsh.exe`, this can re-launch WindowsTermainal, VSCode, PowerShell ISE depending on where the command originated from.
+ Tests
  + Added additional logic to account for OS-Specific functions to be tested.
    + Examples:
      + On Linux- the SU and Grep functions are not loaded, and therefore not tested.

## v1.0.9

+ Syntax changes in function definitions
  + This does not contain any features or major code changes.
+ New build process
  + Testing, Building, and Publishing this module now exist exclusively within GitHub (from Azure DevOps)
  + This change is to keep this project in the GitHub ecosystem and have a singular location to handle maintinance.

## v1.0.8

+ `Copy-WithProgress`
  + `-Destination` parameter now creates destination path properly.
    + **BUG**: if you did not include a trailing '\' at the end of the destination path, it would copy your files one directory higher, and any 1st level folders copied would turn into a folder named after the parent folder and the nested folder name.
+ Added GitHub Project link information to the .NOTES section of every public function.

## v1.0.7

+ Misc. code improvements

## v1.0.6 🏈🏈

+ Tests:
  + Added Pester test for '.NOTES' section in all comment-based help for public functions.
+ `Get-Applications`
  + More robust application discovery for 64-bit OS.
+ `Remove-Application`
  + More robust method of uninstalling objects from Get-Applications
+ `Copy-WithProgress`
  + Added '-IncludeACL' switch to move file ACLs.

## v1.0.5

+ New Functions:
  + `Get-RebootLogs`
  + `Clear-CCMCache`
+ Added new functions to AD Argument Completer for their `-ComputerName` parameters.
+ Correctly registered `Push-LocalScheduledTask`'s `-ComputerName` with argument completion.

## v1.0.4

+ Fixing Comment-Based help.
  + Needed a blank line after the #Region declaration or it broke the built-in help.

## v1.0.3 🐱‍🚀

+ `Get-PCUpTime`: Now works when calling from PowerShell to a remote computer running Windows PowerShell.
  + This likewise would fix a Windows PowerShell instance running against a remote PowerShell instance.
+ `Get-CIDRNotationBySubnetMask`: Now gives targeted error message if an improperly formatted SubnetMask is supplied.
  + EXAMPLE: `Get-CIDRNotationBySubnetMask 255.253.255.0`
  + <span style="color:red">Get-CIDRNotationBySubnetMask : Invalid Subnet Mask value: '253' in 255.\[253\].255.0</span>
+ Added Regions to each script file. Should help organize the .psm1 file POST-Build.
+ Added Region detection to Pester tests.

## v1.0.2 🐱‍🏍

+ Adding Build job in Azure.
  + Module will now be installed as core .psd1 and .psm1 files instead of entire raw directory.
+ Removed .gitignore file entirely. Logic to exclude Build folder from module is done in AzurePipeline.

## v1.0.1 🐱‍👤

+ AzurePipelines Build configuration changes. Finally everything works! 🤣
+ Updated LicenseURI in Manifest. 🤦‍♂️
+ Fixed .gitignore syntax for excluding Build. 🤦‍♂️

## v1.0.0 🎉

+ Initial file commit to GitHub Repo.
