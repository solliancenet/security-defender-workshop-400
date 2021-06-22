$subscriptionId = "#SUBCRIPTION_ID#";
$resourceGroupName = "#RESOURCE_GROUP_NAME#";
$workspaceName = "#WORKSPACE_NAME#";
$storageAccountName = "#STORAGE_ACCOUNT_NAME#";
$exportName = "ExportEventHub";

$url = "https://management.azure.com/subscriptions/$subscriptionId/resourcegroups/$resourceGroupName/providers/Microsoft.operationalInsights/workspaces/$workspaceName/dataexports/$exportName?api-version=2020-08-01";

$post = get-content "storage_post.json";

$post = $post.replace("#SUBSCRIPTION_ID#",$subscriptionId);
$post = $post.replace("#RESOURCE_GROUP_NAME#",$resourceGroupName);
$post = $post.replace("#WORKSPACE_NAME#",$workspaceName);
$post = $post.replace("#STORAGE_ACCOUNT_NAME#",$storageAccountName);

#login so you can get a token
az login;

#get an access token...
$tokenValue = ((az account get-access-token --resource https://management.azure.com) | ConvertFrom-Json).accessToken

#do the post...
$headers = @{
    'Authorization' = "Bearer " + $tokenValue;
}

$res = Invoke-RestMethod -Uri $url -Method PUT -Headers $headers -Body $post

$res;

#reference - https://docs.microsoft.com/en-us/azure/azure-monitor/logs/logs-data-export?tabs=rest