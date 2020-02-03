<# 
   .SYNOPSIS 
   Gets environment parameter values of local machine. 

   .DESCRIPTION 
   Gets environment details regardless of Operating System of the local machine.

   .NOTES 
   Author : Shiva Prasad (id.shiv.prasad@gmail.com)
   Version    : 1.0

   .INPUTS
   None. 
   You cannot pipe objects to Get-Environment.

   .OUTPUTS
   Returns System.Array
   Get-Environment returns a list with environment details of local machine.

   HostName          : shivs-macbook-air.local
   OS                : Unix Darwin 18.7.0 Darwin Kernel Version 18.7.0: Tue Aug 20 16:57:14 PDT 2019; root:xnu-4903.271.2~2/RELEASE_X86_64
   PSVersion         : 6.2.4
   CurrentUser       : shiv
   CurrentDirectory  : /Users/shiv/Documents/gitRepositories/PS-Utils
   CurrentDate       : 02/03/2020 10:41:59
   CurrentTimeZone   : Asia/Calcutta (GMT+05:30)
   UpTime            : 0 Days, 13 Hours, 14 Minutes, 42 Seconds
   PSExecutionPolicy : Unrestricted
   HomeDirectory     : /Users/shiv
   UsedSpace         : 37.19 GB
   FreeSpace         : 75.61 GB

   .EXAMPLE 
   Get-Environment 

   .LINK 
   https://github.com/id-shiv/PS-Lib/blob/master/Get-Environment.ps1
#> 
function Get-Environment {
   # Object to hold environment details
   $Environment = New-Object PSObject

   # Retrieve Hostname
   $HostName = ([System.Net.Dns]::GetHostByName(($env:computerName))).Hostname
   $Environment | Add-Member -MemberType NoteProperty -Name HostName -Value $HostName

   # Retrieve Operating System information
   $OS = $PSVersionTable.Platform + " " + $PSVersionTable.OS
   $Environment | Add-Member -MemberType NoteProperty -Name OS -Value $OS

   # Retrieve PowerShell version
   $Environment | Add-Member -MemberType NoteProperty -Name PSVersion -Value $PSVersionTable.PSVersion

   # Retrieve current user
   $Environment | Add-Member -MemberType NoteProperty -Name CurrentUser -Value (whoami)

   # Retrieve current working directory
   $Environment | Add-Member -MemberType NoteProperty -Name CurrentDirectory -Value (Get-Location).Path

   # Retrieve system time
   $Environment | Add-Member -MemberType NoteProperty -Name CurrentDate -Value (Get-Date)

   # Retrieve system time zone
   $TimeZone = ((Get-TimeZone).Id + " (" + (Get-TimeZone).DisplayName + ")")
   $Environment | Add-Member -MemberType NoteProperty -Name CurrentTimeZone -Value $TimeZone

   # Retrieve system uptime
   $UpTime = [string](Get-Uptime).Days + " Days, " + [string](Get-Uptime).Hours + " Hours, " + 
   [string](Get-Uptime).Minutes + " Minutes, " + [string](Get-Uptime).Seconds + " Seconds"
   $Environment | Add-Member -MemberType NoteProperty -Name UpTime -Value $UpTime

   # Retrieve PowerShell execution policy configuration
   $Environment | Add-Member -MemberType NoteProperty -Name PSExecutionPolicy -Value (Get-ExecutionPolicy)

   # Retrieve system home directory
   $Environment | Add-Member -MemberType NoteProperty -Name HomeDirectory -Value (Get-Variable HOME -valueOnly)

   # Retrieve system used and free capacity (in GB)
   $UsedSpace = 0
   $FreeSpace = 0
   foreach($Drive in Get-PSDrive){
      $UsedSpace = $UsedSpace + ((Get-PSDrive $Drive).Used)/(1024*1024*1024)
      $FreeSpace = $FreeSpace + ((Get-PSDrive $Drive).Free)/(1024*1024*1024)
   }
   $Environment | Add-Member -MemberType NoteProperty -Name UsedSpace -Value ([string]([math]::Round($UsedSpace,2)) + " GB")
   $Environment | Add-Member -MemberType NoteProperty -Name FreeSpace -Value ([string] ([math]::Round($FreeSpace,2)) + " GB")

   return ($Environment | Format-List)
}