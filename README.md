# Set of PowerShell modules \ helper functions

## Build-Module

### Pre-requisites

* Folder with `<Module Name>` created.  
* Module file with `<Module Name>`.psm1 created with functions.  
* Build-Module.ps1 to be placed and run from folder above `<Module Name>`.  

### Command

`./Build-Module.ps1 -OS 'NonWindows' -ModuleName 'System' -Author 'Shiva Prasad' -Description 'Retrieves System Information' -ModulePath "/Users/shiv/Documents/gitRepositories/PS-Utils/System"`

## System

Import-Module System -Force

### Get-SystemInfo

Retrieve System Information
