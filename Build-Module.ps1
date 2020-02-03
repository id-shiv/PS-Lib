########################################################
#
#  Replace '/' with '\' for Windows Systems
#  Relplace ':' with ';' for Windows Systems
#
########################################################

# Pre-requisites :
#   * Folder with <Module Name> created.
#   * Module file with <Module Name>.psm1 created with functions
#   * Build-Module.ps1 to be placed and run from folder above <Module Name>

$Path = '/Users/shiv/Documents/gitRepositories/PS-Utils'  # Root path above <Module Name> folder
$ModuleName = 'System'
$Author = 'Shiva Prasad'
$Description = 'PowerShell Modules for Systems Management'
$FeaturesToExport = "Get-SystemInfo", "Test-Module"

$ModulePath = $Path + '/' + $ModuleName


if ((pwd) -notin ($env:PSModulePath -split ':')) {
    $env:PSModulePath = $env:PSModulePath + ':' + (pwd)
}
Write-Host "`nPowerShell Modules Path : " $env:PSModulePath

Write-Host "`nRetrieving Available Modules ..."
Get-Module -ListAvailable

Write-Host "`nImporting PowerShell Modules ..."
Import-Module ./$ModuleName -Force
Write-Host "`nImporting PowerShell Modules complete."

Write-Host "`nCreating Module Manifest file ..."
$manifest = @{
    Path              = $ModulePath + '/' + $ModuleName + '.psd1'
    RootModule        = $ModulePath + '/' + $ModuleName + '.psm1'
    Author            = $Author
    Description       = $Description
}
New-ModuleManifest @manifest
Write-Host "`nManifest file created @ "$ModulePath'/'$ModuleName'.psd1'

