#Region Locate

<#
.SYNOPSIS
Quickly search a location for a file, folder, hidden file, etc...
This should return the same object that Get-ChildItem returns.

.DESCRIPTION
This function takes a -Filter and applies dual-wildcards for maximum search results.
By default this will search recursively in the local directory, but you can specify 
any custom location.

.PARAMETER Directory [<SwitchParameter>]
Gets directories (folders).

To get only directories, use the Directory parameter and omit the File parameter. To exclude directories, use
the File parameter and omit the Directory parameter.

To get directories, use the Directory parameter.

.PARAMETER File [<SwitchParameter>]
Gets files.

To get only files, use the File parameter and omit the Directory parameter. To exclude files, use the
Directory parameter and omit the File parameter.

To get files, use the File parameter.

.PARAMETER Hidden [<SwitchParameter>]
Gets only hidden files and directories (folders).  By default, Get-ChildItem gets only non-hidden items, but
you can use the Force parameter to include hidden items in the results.

To get only hidden items, use the Hidden parameter. To exclude hidden items, omit the Hidden parameter.

.PARAMETER ReadOnly [<SwitchParameter>]
Gets only read-only files and directories (folders).

To get only read-only items, use the ReadOnly parameter, its "ar" alias, or the ReadOnly value of the
Attributes parameter. To exclude read-only items, use the Attributes parameter.

.PARAMETER System [<SwitchParameter>]
Gets only system files and directories (folders).

To get only system files and folders, use the System parameter.

.PARAMETER Force [<SwitchParameter>]
Gets hidden files and folders. By default, hidden files and folder are excluded. You can also get hidden files
and folders by using the Hidden parameter or the Hidden value of the Attributes parameter.

.PARAMETER Exclude <String[]>
Specifies, as a string array, an item or items that this cmdlet excludes in the operation. The value of this
parameter qualifies the Path parameter. Enter a path element or pattern, such as *.txt. Wildcards are
permitted.

.PARAMETER Include <String[]>
Specifies, as a string array, an item or items that this cmdlet includes in the operation. The value of this
parameter qualifies the Path parameter. Enter a path element or pattern, such as *.txt. Wildcards are
permitted.

The Include parameter is effective only when the command includes the Recurse parameter or the path leads to
the contents of a directory, such as C:\Windows\*, where the wildcard character specifies the contents of the
C:\Windows directory.

.PARAMETER Filter <String>
Specifies a filter in the provider's format or language. The value of this parameter qualifies the Path
parameter. The syntax of the filter, including the use of wildcards, depends on the provider. Filters are more
efficient than other parameters, because the provider applies them when retrieving the objects, rather than
having Windows PowerShell filter the objects after they are retrieved.

.PARAMETER Path <String[]>
Specifies a path to one or more locations. Wildcards are permitted. The default location is the current
directory (.).

.PARAMETER Recurse [<SwitchParameter>]
Indicates that this cmdlet gets the items in the specified locations and in all child items of the locations.

In Windows PowerShell 2.0 and earlier versions of Windows PowerShell, the Recurse parameter works only when
the value of the Path parameter is a container that has child items, such as C:\Windows or C:\Windows\ , and
not when it is an item does not have child items, such as C:\Windows\ .exe.

By Default, this is set to True. Use -Recurse:$false to turn off recursive results.

.EXAMPLE
    PS> Locate AdminToolkit.psd1 -Recurse
    
    Description
    -----------
    This will search from the current working directory for files or folders mathing the filter 'AdminToolkit.psd1'
.EXAMPLE
    PS> locate foo.txt C:\temp
    
    Description
    -----------
    This will search for the file foo.txt in the directory C:\temp.
.EXAMPLE
    PS> locate test -Recurse -Exclude *.tests.*

    Directory: C:\Temp\HelpDesk\Functions\Public

    Mode                 LastWriteTime         Length Name
    ----                 -------------         ------ ----
    -a---            8/5/2020 11:51 AM           6985 Test-Administrator.ps1

    Directory: C:\Temp\HelpDesk

    Mode                 LastWriteTime         Length Name
    ----                 -------------         ------ ----
    d----            8/5/2020  2:07 PM                Tests
    
    Description
    -----------
    This will search recursively using the filter 'test' and exclude files/folders that match '*.tests.*'
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/AdminToolkit/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/AdminToolkit/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/AdminToolkit

    Change Log:
    Version: 1.0 - Function Creation.
#> 
Function Locate() {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [string]$Filter,
        [Parameter(Position = 1)]
        [string]$Path = (Get-Location),
        [string[]]$Include,
        [string[]]$Exclude,
        [switch]$Force,
        [switch]$Recurse,
        [switch]$Directory,
        [switch]$File,
        [switch]$System,
        [switch]$Hidden,
        [switch]$ReadOnly
    )
    if (-Not($PSBoundParameters.Filter)) {
        $PSBoundParameters.Filter = '*'
    } else {
        $PSBoundParameters.Filter = "*$Filter*"
    }

    Get-ChildItem @PSBoundParameters -ErrorAction SilentlyContinue
}
#EndRegion Locate