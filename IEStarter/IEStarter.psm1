class IEOperation {

    hidden $Ie
    [string]hidden $Uri
    [string[]]hidden $Headers

    IEOperation([string]$uri, [string[]]$headers) {
        $this.Uri = $uri
        $this.Headers = $headers
        $this.Ie = New-Object -ComObject InternetExplorer.Application
        $this.Ie.Visible = $true
        $this.Ie.Navigate($this.Uri, $null, "_self", $null, $this.Headers -join "`r`n")
    }

    [void] Reload() {
        $this.Ie.Navigate($this.Uri, $null, "_self", $null, $this.Headers -join "`r`n")
    }

    [void] ListHeaders() {
        $this.Headers
    }
}

function Show-Message {
    Write-Host 'Select your behavior'

    Write-Host 'r: reload IE'
    Write-Host 'e: edit custom headers'
    Write-Host 'l: list selected custom headers'
    Write-Host 'q: quit'
}

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
    $ie = [IEOperation]::new($Uri, $Headers)
    do {
        Show-Message
        try {
            [ValidatePattern("[relq]")]$instruction = Read-Host 'Please input'
            switch -Exact ($instruction) {
                "r" {
                    $ie.Reload
                }
                "l" {
                    $ie.ListHeaders
                }
            }
        }
        catch {}
    }
    until ($instruction -eq 'q')
}

Export-ModuleMember -Function Debug-IE
