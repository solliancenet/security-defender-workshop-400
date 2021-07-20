# Azure Security Center + Azure Defender Setup : Lab 2 : REST APIs

## Exercise 1: REST APIs

### Task 1: Log Analytics

1. TODO

### Task 2: Azure Security Graph

1. TODO

## Exercise 2: Visualize Recommendations with Power BI

### Task 1: Create KQL Query

1. Open the Azure Portal
2. Select **Logs**
3. Run the following query

```kql
```

4. Select **Export to Power BI**
5. 

### Task 2: Export to Power BI

1. Open the `Azure Defender.pbix` file
2. Right-click the `Alerts` data source, select **Edit**
3. Select the `Alerts` data source, in the ribbon, select **Advanced Editor**.
4. Review the query.  Repeat for all the data sources in the Power BI report.
5. Update the SubscriptionId, TenantId and WorkspaceId with the lab details
6. Generate a new `https://management.azure.com` access token, replace it in the report
7. When prompted, enter your lab credentials
8. You should see all the tabs update with Azure Defender related items. Review each tab.

## Reference Links

- Azure Defender APIs
- Azure Sentinel APIs
- Power BI
