$subscriptionId = "#SUBCRIPTION_ID#";
$resourceGroupName = "#RESOURCE_GROUP_NAME#";
$workspaceName = "#WORKSPACE_NAME#";

$url = "https://management.azure.com/subscriptions/$subscriptionId/resourcegroups/$resourceGroupName/providers/Microsoft.operationalInsights/workspaces/$workspaceName/incidents/73e01a99-5cd7-4139-a149-9f2736ff2ab5?api-version=2020-08-01";

$post = get-content "incident_post.json";

$post = $post.replace("#SUBSCRIPTION_ID#",$subscriptionId);
$post = $post.replace("#RESOURCE_GROUP_NAME#",$resourceGroupName);
$post = $post.replace("#WORKSPACE_NAME#",$workspaceName);

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

#reference - https://docs.microsoft.com/en-us/rest/api/securityinsights/incidents/create-or-update