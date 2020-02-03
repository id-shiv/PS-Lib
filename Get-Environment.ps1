
function Get-Environment {
   <# 
   .SYNOPSIS 
      Gets environment parameter values of local machine. 
   .DESCRIPTION 
      Gets environment details regardless of Operating System of the local machine.
   .NOTES 
      Created by: Shiva Prasad (id.shiv.prasad@gmail.com).
   
      Version: 1.0
   .INPUTS
      None. You cannot pipe objects to Get-ENvironment.
   .OUTPUTS
      System.String. Get-Environment returns a list with environment details of local machine.

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
   #> 
   $Environment = New-Object PSObject

   $HostName = ([System.Net.Dns]::GetHostByName(($env:computerName))).Hostname
   $Environment | Add-Member -MemberType NoteProperty -Name HostName -Value $HostName

   $OS = $PSVersionTable.Platform + " " + $PSVersionTable.OS
   $Environment | Add-Member -MemberType NoteProperty -Name OS -Value $OS

   $Environment | Add-Member -MemberType NoteProperty -Name PSVersion -Value $PSVersionTable.PSVersion

   $Environment | Add-Member -MemberType NoteProperty -Name CurrentUser -Value (whoami)

   $Environment | Add-Member -MemberType NoteProperty -Name CurrentDirectory -Value (Get-Location).Path

   $Environment | Add-Member -MemberType NoteProperty -Name CurrentDate -Value (Get-Date)

   $TimeZone = ((Get-TimeZone).Id + " (" + (Get-TimeZone).DisplayName + ")")
   $Environment | Add-Member -MemberType NoteProperty -Name CurrentTimeZone -Value $TimeZone

   $UpTime = [string](Get-Uptime).Days + " Days, " + [string](Get-Uptime).Hours + " Hours, " + 
   [string](Get-Uptime).Minutes + " Minutes, " + [string](Get-Uptime).Seconds + " Seconds"
   $Environment | Add-Member -MemberType NoteProperty -Name UpTime -Value $UpTime

   $Environment | Add-Member -MemberType NoteProperty -Name PSExecutionPolicy -Value (Get-ExecutionPolicy)

   $Environment | Add-Member -MemberType NoteProperty -Name HomeDirectory -Value (Get-Variable HOME -valueOnly)

   $UsedSpace = 0
   $FreeSpace = 0
   foreach($Drive in Get-PSDrive){
      $UsedSpace = $UsedSpace + ((Get-PSDrive $Drive).Used)/(1024*1024*1024)
      $FreeSpace = $FreeSpace + ((Get-PSDrive $Drive).Free)/(1024*1024*1024)
   }
   $Environment | Add-Member -MemberType NoteProperty -Name UsedSpace -Value ([string]([math]::Round($UsedSpace,2)) + " GB")
   $Environment | Add-Member -MemberType NoteProperty -Name FreeSpace -Value ([string] ([math]::Round($FreeSpace,2)) + " GB")

   return ($Environment | Format-List).GetType()
}

# Get local environment details
Get-Environment