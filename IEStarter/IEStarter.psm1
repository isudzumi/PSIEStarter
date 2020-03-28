<#
    .Synopsis
    Add custom headers for IE debugging

    .Description
    You can start up IE with adding or modifying custom HTTP headers interactively.
    This module is for Windows only.

    .Parameter Uri
    Specify the website URL you're heading to.

    .Parameter Headers
    Custom headers you would like to add.

    .Example
    Debug-IE -Uri example.com

#>

function Debug-IE {
param(
    [string] $Uri,
    [string[]] $Headers
    )
    $ie = New-Object -ComObject InternetExplorer.Application
    $ie.Visible = $true
    $ie.Navigate($Uri, $null, "_self", $null, $Headers -join "`r`n")
}

Export-ModuleMember -Function Debug-IE