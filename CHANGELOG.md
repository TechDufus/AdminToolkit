# Changelog for AdminToolkit

## v1.0.3 🐱‍🚀
+ **Get-PCUpTime**: Now works when calling from PowerShell to a remote computer running Windows PowerShell.
  + This likewise would fix a Windows PowerShell instance running against a remote PowerShell instance.
+ **Get-CIDRNotationBySubnetMask**: Now gives targeted error message if an improperly formatted SubnetMask is supplied.
  + EXAMPLE: Get-CIDRNotationBySubnetMask 255.253.255.0
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
