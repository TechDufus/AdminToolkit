# Changelog for AdminToolkit

## v1.0.8
+ `Copy-WithProgress`
  + `-Destination` parameter now creates destination path properly.
    + **BUG**: if you did not include a trailing '\' at the end of the destination path, it would copy your files one directory higher, and any 1st level folders copied would turn into a folder named after the parent folder and the nested folder name.
+ Added GitHub Project link information to the .NOTES section of every public function.
+ 
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
