Write-Host "`n* Get-SystemInfo"
function Get-SystemInfo {
    [CmdletBinding()]
    
    <#
    .SYNOPSIS 
        Retrieves system details

    .DESCRIPTION 
        Retrieves system details regardless of Operating System.

    .INPUTS
        None. 
        You cannot pipe objects to Get-SystemInfo.

    .OUTPUTS
        Returns System.Object
        Get-SystemInfo returns a list with environment details of system.

        IsPublic IsSerial Name                                     BaseType
        -------- -------- ----                                     --------
        True     False    PSCustomObject                           System.Object

    .NOTES 
        Author     : Shiva Prasad (id.shiv.prasad@gmail.com)
        Version    : 1.0

    .EXAMPLE 
        Get-SystemInfo

        Retrieves all environment details

        Sample Output:
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
        (Get-SystemInfo).HostName

        Retrieves HostName of the system

        Sample Output:
            shivs-macbook-air.local

    .LINK 
        https://github.com/id-shiv/PS-Lib/blob/master/Get-Environment.ps1
    #> 


    # Object to hold environment details
    $SystemInfo = New-Object PSObject

    # Retrieve Hostname
    $HostName = ([System.Net.Dns]::GetHostByName(($env:computerName))).Hostname
    $SystemInfo | Add-Member -MemberType NoteProperty -Name HostName -Value $HostName

    # Retrieve Operating System information
    $OS = $PSVersionTable.Platform + " " + $PSVersionTable.OS
    $SystemInfo | Add-Member -MemberType NoteProperty -Name OS -Value $OS

    # Retrieve current user
    $SystemInfo | Add-Member -MemberType NoteProperty -Name CurrentUser -Value (whoami)

    # Retrieve current working directory
    $SystemInfo | Add-Member -MemberType NoteProperty -Name CurrentDirectory -Value (Get-Location).Path

    # Retrieve system home directory
    $SystemInfo | Add-Member -MemberType NoteProperty -Name HomeDirectory -Value (Get-Variable HOME -valueOnly)

    # Retrieve system time
    $SystemInfo | Add-Member -MemberType NoteProperty -Name CurrentDate -Value (Get-Date)

    # Retrieve system time zone
    $TimeZone = ((Get-TimeZone).Id + " (" + (Get-TimeZone).DisplayName + ")")
    $SystemInfo | Add-Member -MemberType NoteProperty -Name CurrentTimeZone -Value $TimeZone

    # Retrieve system uptime
    $UpTime = [string](Get-Uptime).Days + ":" + [string](Get-Uptime).Hours + ":" + 
                [string](Get-Uptime).Minutes + ":" + [string](Get-Uptime).Seconds + " (Days:Hours:Minutes:Seconds)"
    $SystemInfo | Add-Member -MemberType NoteProperty -Name UpTime -Value $UpTime

    # Retrieve PowerShell version
    $SystemInfo | Add-Member -MemberType NoteProperty -Name PSVersion -Value $PSVersionTable.PSVersion

    # Retrieve PowerShell execution policy configuration
    $SystemInfo | Add-Member -MemberType NoteProperty -Name PSExecutionPolicy -Value (Get-ExecutionPolicy)

    # Retrieve system used and free capacity (in GB)
    $UsedSpace = 0
    $FreeSpace = 0
    foreach($Drive in Get-PSDrive){
    $UsedSpace = $UsedSpace + ((Get-PSDrive $Drive).Used)/(1024*1024*1024)
    $FreeSpace = $FreeSpace + ((Get-PSDrive $Drive).Free)/(1024*1024*1024)
    }
    $SystemInfo | Add-Member -MemberType NoteProperty -Name UsedSpace -Value ([string]([math]::Round($UsedSpace,2)) + " GB")
    $SystemInfo | Add-Member -MemberType NoteProperty -Name FreeSpace -Value ([string]([math]::Round($FreeSpace,2)) + " GB")

    return $SystemInfo
}

Write-Host "`n* Test-Module"
function Test-Module {
    Write-Host "Test Success"
}