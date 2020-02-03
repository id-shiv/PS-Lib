# System

## Get-SystemInfo

### SYNOPSIS

Retrieves system information.

### DESCRIPTION

Retrieves system information regardless of Operating System.

### INPUTS

None.  
You cannot pipe objects to Get-SystemInfo.

### OUTPUTS

Returns System.Object  
Get-SystemInfo returns a list with environment details of system.

### NOTES

Author     : Shiva Prasad (id.shiv.prasad@gmail.com)  
Version    : 0.0.1

### EXAMPLE 1

#### Command

Get-SystemInfo

#### Description

Retrieves all environment details

#### Sample Output

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

### EXAMPLE 2

#### Command

(Get-SystemInfo).HostName

#### Description

Retrieves HostName of the system

#### Sample Output

    shivs-macbook-air.local

### LINK

https://github.com/id-shiv/PS-Lib/blob/master/System/System.psm1