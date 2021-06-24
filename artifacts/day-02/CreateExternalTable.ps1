$subscriptionId = "#SUBSCRIPTION_ID#";
$resourceGroupName = "#RESOURCE_GROUP_NAME#";
$workspaceName = "#WORKSPACE_NAME#";
$storageAccountName = "#STORAGE_ACCOUNT_NAME#";
$exportName = "ExportStorageAccount";

$workspaceId = "#WORKSPACE_ID#";
$workspaceKey = "#WORKSPACE_KEY#";

cd "c:/labfiles/#WORKSHOP_NAME#/artifacts/day-02";

Import-Csv users.csv | Upload-AzMonitorLog.ps1 -WorkspaceId $workspaceId -WorkspaceKey $workspaceKey -LogTypeName 'users_lookup'
