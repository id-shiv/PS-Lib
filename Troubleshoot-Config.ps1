function Get-Inputs {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Data Entry Form'
    $form.Size = New-Object System.Drawing.Size(300,200)
    $form.StartPosition = 'CenterScreen'

    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Point(75,120)
    $OKButton.Size = New-Object System.Drawing.Size(75,23)
    $OKButton.Text = 'OK'
    $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $OKButton
    $form.Controls.Add($OKButton)

    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Point(150,120)
    $CancelButton.Size = New-Object System.Drawing.Size(75,23)
    $CancelButton.Text = 'Cancel'
    $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.CancelButton = $CancelButton
    $form.Controls.Add($CancelButton)

    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(10,20)
    $label.Size = New-Object System.Drawing.Size(280,20)
    $label.Text = 'Please enter the information in the space below:'
    $form.Controls.Add($label)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(10,40)
    $textBox.Size = New-Object System.Drawing.Size(260,20)
    $form.Controls.Add($textBox)

    $form.Topmost = $true

    $form.Add_Shown({$textBox.Select()})
    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        $x = $textBox.Text
        $x
    }
}

function Test-PingFQDN {
    Param 
    (
         [Parameter(Mandatory=$true)]
         [string] $FQDN
    )
    if (Test-Connection -TargetName $FQDN  -Count 1 -Quiet -ErrorAction SilentlyContinue 6> $null) {
        Write-Host "Ping" $FQDN "- SUCCESS"
    }
    else {
        Write-Host "Ping" $FQDN "- FAILED"
    }
}

function Get-Environment {
    $HostName = ([System.Net.Dns]::GetHostByName(($env:computerName))).Hostname
    $OS = $PSVersionTable.Platform + " " + $PSVersionTable.OS

    Write-Host "`n========================"
    Write-Host "Environment"
    Write-Host "========================"
    Write-Host "HostName -" $HostName
    Write-Host "PowerShell -" $PSVersionTable.PSVersion
    Write-Host "OS -" $OS

    return $HostName, $PSVersionTable.PSVersion, $OS
}

function Remote-Command {
    Param 
    (
        [Parameter(Mandatory=$true)]
        [string] $LocalFQDN,

        [Parameter(Mandatory=$true)]
        [string] $AppliancePasswd,

        [Parameter(Mandatory=$true)]
        [string] $ApplianceUser
    )
    $SecurePasswd = ConvertTo-SecureString $AppliancePasswd -AsPlainText -Force
    $Credentials  = New-Object Management.Automation.PSCredential ($ApplianceUser, $SecurePasswd)
    try {
        Invoke-Command -ComputerName $LocalFQDN -ScriptBlock { 'hostname' } -Credential $Credentials 
        #-ErrorAction Stop
    }
    catch [Exception]{
        Write-Host $_.Exception.GetType().FullName, $_.Exception.Message
    }
}

$ApplianceFQDN = 'localhost'
$ApplianceUser = 'root'
$AppliancePasswd = 'iPass1987'

$LocalFQDN, $_, $_ = Get-Environment

Write-Host "`n========================"

Test-PingFQDN -FQDN $LocalFQDN

Write-Host "========================`n"