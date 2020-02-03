# Set of PowerShell modules \ helper functions

## Build-Module

Builds a module with psm1 file as an input  

* Replace '/' with '\' for Windows Systems  
* Relplace ':' with ';' for Windows Systems

### Pre-requisites

* Folder with `<Module Name>` created.  
* Module file with `<Module Name>`.psm1 created with functions.  
* Build-Module.ps1 to be placed and run from folder above `<Module Name>`.  

## System

Import-Module System -Force

### Get-SystemInfo

Retrieve System Information
