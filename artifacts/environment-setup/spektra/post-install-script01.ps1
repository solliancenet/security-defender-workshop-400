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

function InstallGit()
{
  Write-Host "Installing Git." -ForegroundColor Green -Verbose

  #download and install git...		
  $output = "$env:TEMP\git.exe";
  Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/download/v2.27.0.windows.1/Git-2.27.0-64-bit.exe -OutFile $output; 

  $productPath = "$env:TEMP";
  $productExec = "git.exe"	
  $argList = "/SILENT"
  start-process "$productPath\$productExec" -ArgumentList $argList -wait

}

function InstallAzureCli()
{
  Write-Host "Installing Azure CLI." -ForegroundColor Green -Verbose

  #install azure cli
  Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi -usebasicparsing; 
  Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; 
  rm .\AzureCLI.msi
}

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

#Create InstallAzPowerShellModule
function InstallAzPowerShellModule
{
  Write-Host "Installing Azure PowerShell (NuGet)." -ForegroundColor Green -Verbose

  Install-PackageProvider NuGet -Force
  Set-PSRepository PSGallery -InstallationPolicy Trusted
  Install-Module Az -Repository PSGallery -Force -AllowClobber
}

function InstallAzPowerShellModuleMSI
{
  Write-Host "Installing Azure PowerShell (MSI)." -ForegroundColor Green -Verbose
  #download and install git...		
  Invoke-WebRequest -Uri https://github.com/Azure/azure-powershell/releases/download/v4.5.0-August2020/Az-Cmdlets-4.5.0.33237-x64.msi -usebasicparsing -OutFile .\AzurePS.msi;
  Start-Process msiexec.exe -Wait -ArgumentList '/I AzurePS.msi /quiet'; 
  rm .\AzurePS.msi
}

#Create-LabFilesDirectory
function CreateLabFilesDirectory
{
  New-Item -ItemType directory -Path C:\LabFiles -force
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

DisableInternetExplorerESC

EnableIEFileDownload

InstallAzPowerShellModule

InstallDocker

InstallGit
        
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
$resourceGroupName = (Get-AzResourceGroup | Where-Object { $_.ResourceGroupName -like "*-L400*" }).ResourceGroupName
$deploymentId =  (Get-AzResourceGroup -Name $resourceGroupName).Tags["DeploymentId"]

$url = "https://raw.githubusercontent.com/solliancenet/security-defender-workshop-400/main/artifacts/environment-setup/spektra/deploy.parameters.post.json"
$output = "c:\LabFiles\parameters.json";
$wclient = New-Object System.Net.WebClient;
$wclient.CachePolicy = new-object System.Net.Cache.RequestCachePolicy([System.Net.Cache.RequestCacheLevel]::NoCacheNoStore);
$wclient.Headers.Add("Cache-Control", "no-cache");
$wclient.DownloadFile($url, $output)
(Get-Content -Path "c:\LabFiles\parameters.json") | ForEach-Object {$_ -Replace "GET-AZUSER-PASSWORD", "$AzurePassword"} | Set-Content -Path "c:\LabFiles\parameters.json"
(Get-Content -Path "c:\LabFiles\parameters.json") | ForEach-Object {$_ -Replace "GET-DEPLOYMENT-ID", "$deploymentId"} | Set-Content -Path "c:\LabFiles\parameters.json"

Write-Host "Starting main deployment." -ForegroundColor Green -Verbose
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri "https://raw.githubusercontent.com/solliancenet/security-defender-workshop-400/main/artifacts/environment-setup/automation/00-asa-workspace-core.json" -TemplateParameterFile "c:\LabFiles\parameters.json"

#download the git repo...
Write-Host "Download Git repo." -ForegroundColor Green -Verbose
git clone https://github.com/solliancenet/security-defender-workshop-400.git synapse-ws-L400

cd './synapse-ws-L400/artifacts/environment-setup/automation'

#execute setup scripts
Write-Host "Executing post scripts." -ForegroundColor Green -Verbose
#./01-environment-setup.ps1
#./03-environment-validate.ps1

sleep 20

Stop-Transcript