# Pre-requisites
#   * Folder with <Module Name> created.
#   * Module file with <Module Name>.psm1 created with functions
#   * Build-Module.ps1 to be placed and run from folder above <Module Name>

param(
    [Parameter(Mandatory=$True, Position=0, ValueFromPipeline=$false)]
    [System.String]
    $OS,

    [Parameter(Mandatory=$True, Position=1, ValueFromPipeline=$false)]
    [System.String]
    $ModuleName,

    [Parameter(Mandatory=$True, Position=2, ValueFromPipeline=$false)]
    [System.String]
    $Author,

    [Parameter(Mandatory=$True, Position=3, ValueFromPipeline=$false)]
    [System.String]
    $Description,

    [Parameter(Mandatory=$True, Position=4, ValueFromPipeline=$false)]
    [System.String]
    $ModulePath
)

if ($OS -eq "Windows") {
    $PathDelimeter = '\'
    $EnvironmentVariableDelimeter = ';'
}
else {
    $PathDelimeter = '/'
    $EnvironmentVariableDelimeter = ':'
}

if (($ModulePath) -notin ($env:PSModulePath -split $EnvironmentVariableDelimeter)) {
    $env:PSModulePath = $env:PSModulePath + $EnvironmentVariableDelimeter + ($ModulePath)
}
Write-Host "`nPowerShell Modules Path : " $env:PSModulePath

Write-Host "`nRetrieving Available Modules ..."
Get-Module -ListAvailable

Write-Host "`nImporting PowerShell Modules ..."
Import-Module $ModuleName
Write-Host "`nImporting PowerShell Modules complete."

Write-Host "`nCreating Module Manifest file ..."
$manifest = @{
    Path              = $ModulePath + $PathDelimeter + $ModuleName + '.psd1'
    RootModule        = $ModulePath + $PathDelimeter + $ModuleName + '.psm1'
    Author            = $Author
    Description       = $Description
}

New-ModuleManifest @manifest
$ManifestPath = $ModulePath + $PathDelimeter + $ModuleName + ".psd1"
Write-Host "`nManifest file created @ " $ManifestPath
