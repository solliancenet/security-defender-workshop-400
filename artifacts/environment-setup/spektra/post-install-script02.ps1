Param (
  [Parameter(Mandatory = $true)]
  [string]
  $azureUsername,

  [string]
  $azurePassword,

  [string]
  $azureTenantID,

  [string]
  $azureSubscriptionID,

  [string]
  $odlId,
    
  [string]
  $deploymentId
)

#Disable-InternetExplorerESC
function DisableInternetExplorerESC
{
  $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
  $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
  Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 -Force -ErrorAction SilentlyContinue -Verbose
  Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 -Force -ErrorAction SilentlyContinue -Verbose
  Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green -Verbose
}

#Enable-InternetExplorer File Download
function EnableIEFileDownload
{
  $HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
  $HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
  Set-ItemProperty -Path $HKLM -Name "1803" -Value 0 -ErrorAction SilentlyContinue -Verbose
  Set-ItemProperty -Path $HKCU -Name "1803" -Value 0 -ErrorAction SilentlyContinue -Verbose
  Set-ItemProperty -Path $HKLM -Name "1604" -Value 0 -ErrorAction SilentlyContinue -Verbose
  Set-ItemProperty -Path $HKCU -Name "1604" -Value 0 -ErrorAction SilentlyContinue -Verbose
}

#Create-LabFilesDirectory
function CreateLabFilesDirectory
{
  New-Item -ItemType directory -Path C:\LabFiles -force
  New-Item -ItemType directory -Path C:\temp -force
}

#Create Azure Credential File on Desktop
function CreateCredFile($azureUsername, $azurePassword, $azureTenantID, $azureSubscriptionID, $deploymentId)
{
  $WebClient = New-Object System.Net.WebClient
  $WebClient.DownloadFile("https://raw.githubusercontent.com/solliancenet/azure-synapse-analytics-workshop-400/master/artifacts/environment-setup/spektra/AzureCreds.txt","C:\LabFiles\AzureCreds.txt")
  $WebClient.DownloadFile("https://raw.githubusercontent.com/solliancenet/azure-synapse-analytics-workshop-400/master/artifacts/environment-setup/spektra/AzureCreds.ps1","C:\LabFiles\AzureCreds.ps1")

  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "ClientIdValue", ""} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "AzureUserNameValue", "$azureUsername"} | Set-Content -Path "C:\LabFiles\AzureCreds.txt"
  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "AzurePasswordValue", "$azurePassword"} | Set-Content -Path "C:\LabFiles\AzureCreds.txt"
  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "AzureSQLPasswordValue", "$azurePassword"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "AzureTenantIDValue", "$azureTenantID"} | Set-Content -Path "C:\LabFiles\AzureCreds.txt"
  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "AzureSubscriptionIDValue", "$azureSubscriptionID"} | Set-Content -Path "C:\LabFiles\AzureCreds.txt"
  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "DeploymentIDValue", "$deploymentId"} | Set-Content -Path "C:\LabFiles\AzureCreds.txt"               
  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "ODLIDValue", "$odlId"} | Set-Content -Path "C:\LabFiles\AzureCreds.txt"  
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "ClientIdValue", ""} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "AzureUserNameValue", "$azureUsername"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "AzurePasswordValue", "$azurePassword"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "AzureSQLPasswordValue", "$azurePassword"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "AzureTenantIDValue", "$azureTenantID"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "AzureSubscriptionIDValue", "$azureSubscriptionID"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "DeploymentIDValue", "$deploymentId"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "ODLIDValue", "$odlId"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  Copy-Item "C:\LabFiles\AzureCreds.txt" -Destination "C:\Users\Public\Desktop"
}

Start-Transcript -Path C:\WindowsAzure\Logs\CloudLabsCustomScriptExtension.txt -Append

[Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls" 

mkdir "c:\temp" -ea SilentlyContinue;
mkdir "c:\labfiles" -ea SilentlyContinue;

#download the solliance pacakage
$WebClient = New-Object System.Net.WebClient;
$WebClient.DownloadFile("https://raw.githubusercontent.com/solliancenet/common-workshop/main/scripts/common.ps1","C:\LabFiles\common.ps1")
$WebClient.DownloadFile("https://raw.githubusercontent.com/solliancenet/common-workshop/main/scripts/httphelper.ps1","C:\LabFiles\httphelper.ps1")

#run the solliance package
. C:\LabFiles\Common.ps1
. C:\LabFiles\HttpHelper.ps1

Set-Executionpolicy unrestricted -force

DisableInternetExplorerESC

EnableIEFileDownload

InstallChocolaty

InstallAzPowerShellModule

InstallGit

InstallPostman

InstallPutty

InstallFiddler

InstallChrome
        
InstallAzureCli

Uninstall-AzureRm -ea SilentlyContinue

CreateLabFilesDirectory

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")

cd "c:\labfiles";

CreateCredFile $azureUsername $azurePassword $azureTenantID $azureSubscriptionID $deploymentId $odlId

. C:\LabFiles\AzureCreds.ps1

$userName = $AzureUserName                # READ FROM FILE
$password = $AzurePassword                # READ FROM FILE
$clientId = $TokenGeneratorClientId       # READ FROM FILE
$global:sqlPassword = $AzureSQLPassword          # READ FROM FILE

$securePassword = $password | ConvertTo-SecureString -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $userName, $SecurePassword

Connect-AzAccount -Credential $cred | Out-Null
 
# Template deployment
$rg = (Get-AzResourceGroup | Where-Object { $_.ResourceGroupName -like "*AZDEFEND*-02" });
$resourceGroupName = $rg.ResourceGroupName
$deploymentId =  (Get-AzResourceGroup -Name $resourceGroupName).Tags["DeploymentId"]

$branchName = "main";
$workshopName = "security-defender-workshop-400";

#download the git repo...
Write-Host "Download Git repo." -ForegroundColor Green -Verbose
git clone https://github.com/solliancenet/$workshopName.git $workshopName

cd "./$workshopName/artifacts/environment-setup/automation"

#get the waf public IP
$wafName = "wssecurity" + $deploymentId + "-ag";
$appGW = Get-AzApplicationGateway -name $wafName;
$fipconfig = Get-AzApplicationGatewayFrontendIPConfig -ApplicationGateway $appGW
$pipName = "wssecurity" + $deploymentId + "-pip"
$ip = Get-AzPublicIpAddress -name $pipName
$wafIp = $ip.IpAddress;

#get the app svc url
$webAppName = "wssecurity" + $deploymentId;
$app = Get-AzWebApp -Name $webAppName
$appHost = $app.HostNames[0];
$appUrlFull = "https://" + $app.HostNames[0];

#get the workspace Id
$wsName = "wssecurity" + $deploymentId;
$ws = Get-AzOperationalInsightsWorkspace -Name $wsName -ResourceGroup $resourceGroupName;
$workspaceId = $ws.CustomerId;
$keys = Get-AzOperationalInsightsWorkspaceSharedKey -ResourceGroup $resourceGroupName -Name $wsName;
$workspaceKey = $keys.PrimarySharedKey;

#update the updatedatafiles.ps1
$content = get-content "c:\labfiles\$workshopName\artifacts\environment-setup\automation\updatedatafiles.ps1" -raw
$content = $content.replace("#IN_WORKSHOP_NAME#",$workshopName);
$content = $content.replace("#IN_USERNAME#",$userName);
$content = $content.replace("#IN_PASSWORD#",$password);
$content = $content.replace("#IN_WORKSPACE_NAME#",$wsName);
$content = $content.replace("#IN_STORAGE_ACCOUNT_NAME#",$wsName);
$content = $content.replace("#IN_WORKSPACE_ID#",$workspaceId);
$content = $content.replace("#IN_WORKSPACE_KEY#",$workspaceKey);
$content = $content.replace("#IN_SUBSCRIPTION_ID#",$azureSubscriptionID);
$content = $content.replace("#IN_RESOURCE_GROUP_NAME#",$resourceGroupName);
$content = $content.replace("#IN_DEPLOYMENT_ID#",$deploymentId);
$content = $content.replace("#IN_IP#","192.168.102.2");
$content = $content.replace("#IN_WAF_IP#",$wafIp);
$content = $content.replace("#IN_APP_SVC_URL#",$appHost);

set-content "c:\labfiles\$workshopName\artifacts\environment-setup\automation\updatedatafiles.ps1" $content;

. "c:\labfiles\$workshopName\artifacts\environment-setup\automation\updatedatafiles.ps1"

#install azcopy
$azCopyLink = Check-HttpRedirect "https://aka.ms/downloadazcopy-v10-windows"

if (!$azCopyLink)
{
        $azCopyLink = "https://azcopyvnext.azureedge.net/release20200501/azcopy_windows_amd64_10.4.3.zip"
}

Invoke-WebRequest $azCopyLink -OutFile "azCopy.zip"
Expand-Archive "azCopy.zip" -DestinationPath ".\" -Force
$azCopyCommand = (Get-ChildItem -Path ".\" -Recurse azcopy.exe).Directory.FullName
$azCopyCommand += "\azcopy"

#upload the updated login files to azure storage
$wsName = "wssecurity" + $deploymentId;
$dataLakeStorageBlobUrl = "https://"+ $wsName + ".blob.core.windows.net/"
$dataLakeStorageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -AccountName $wsName)[0].Value
$dataLakeContext = New-AzStorageContext -StorageAccountName $wsName -StorageAccountKey $dataLakeStorageAccountKey
$container = New-AzStorageContainer -Permission Container -name "logs" -context $dataLakeContext;
$destinationSasKey = New-AzStorageContainerSASToken -Container "logs" -Context $dataLakeContext -Permission rwdl

Write-Information "Copying single files from local..."

$singleFiles = @{
  queries = "c:\labfiles\$workshopName\artifacts\day-02\queries.yaml,logs/queries.yaml"
  aad_logons = "c:\labfiles\$workshopName\artifacts\day-02\aad_logons.pkl,logs/aad_logon.pkl"
  host_logins = "c:\labfiles\$workshopName\artifacts\day-02\host_logins.csv,logs/host_logins.csv"
  user_lookup = "c:\labfiles\$workshopName\artifacts\day-02\users.csv,logs/users.csv"
}

foreach ($singleFile in $singleFiles.Keys) 
{
  $vals = $singleFiles[$singleFile].split(",");
  $vals;
  $source = $vals[0]
  $destination = $dataLakeStorageBlobUrl + $vals[1] + $destinationSasKey
  Write-Host "Copying file $($source) to $($destination)"
  Write-Information "Copying file $($source) to $($destination)"
  & $azCopyCommand copy $source $destination 
}

. "c:\labfiles\$workshopName\artifacts\environment-setup\automation\EncryptHelper.ps1"

#create some files...
CreateFiles 100;

sleep 20

Stop-Transcript