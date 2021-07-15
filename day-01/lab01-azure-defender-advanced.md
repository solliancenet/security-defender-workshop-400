# Azure Security Center + Azure Defender Setup : Lab 2 : Execute Azure Defender Protections

## Exercise 1: Network Map

### Task 1: Network Map

1. Open the Azure Portal
2. Search for Azure Security Center
3. Select **Azure Defender**
4. Select **Network Map**
5. Select the **wssecuritySUFFIX-win10** virtual machine node, review the recommendations
6. Select the **Management ports of virtual machines should be protected with just-in-time network access control** recommendation
7. Select **Fix**
8. Select **Save**
9. Navigate back to the Network map via the bread crumb
10. Select the **wssecuritySUFFIX-hub** virtual network node, review the recommendations
11. Select the **DDoS Protection Standard should be enabled** recommendation
12. Select **Take Action**
13. Select **Enable**
14. Select the **wssecuritySUFFIX** protection plan
15. Select **Save**

## Exercise 2: Azure Defender KQL Queries

### Task 1: VM Vulnerability Assessment

1. Open the Azure Portal
2. Browse to the **wssecuritySUFFIX** log analytics workspace
3. Under **General**, select **Logs**
4. Close any dialogs
5. Run the following query:

```kql
TODO
```

### Task 2: SQL Vulnerability Assessment

1. TODO

### Task 3: File Integrity

1. Open the Azure Portal
2. Browse to the **wssecuritySUFFIX** log analytics workspace
3. Under **General**, select **Logs**
4. Close any dialogs
5. Expand the **Change Tracking** category/solution, notice the two tables `ConfigurationChange` and `ConfigurationData`
6. Run the following query:

```kql
TODO
```

### Task 4: Container Image Scanning

1. Open the Azure Portal
2. Browse to the **wssecuritySUFFIX** log analytics workspace
3. Under **General**, select **Logs**
4. Close any dialogs
5. Run the following query:

```kql
TODO
```

### Task 5: Adaptive Application Control

1. Open the Azure Portal
2. Browse to the **wssecuritySUFFIX** log analytics workspace
3. Under **General**, select **Logs**
4. Close any dialogs
5. Run the following query:

```kql
TODO
```

### Task 6: Adaptive Network Hardening

1. Open the Azure Portal
2. Browse to the **wssecuritySUFFIX** log analytics workspace
3. Under **General**, select **Logs**
4. Close any dialogs
5. Run the following query:

```kql
TODO
```

### Task 7: JIT VM Access

1. Open the Azure Portal
2. Browse to the **wssecuritySUFFIX** log analytics workspace
3. Under **General**, select **Logs**
4. Close any dialogs
5. Run the following query:

```kql
TODO
```

### Task 8: Network Map

1. Open the Azure Portal
2. Browse to the **wssecuritySUFFIX** log analytics workspace
3. Under **General**, select **Logs**
4. Close any dialogs
5. Run the following query:

```kql
TODO
```

## Exercise 3: Continuous Export

### Task 1: Enable Continuos Export

1. TODO

## Exercise 4: Azure Defender for IoT

### Task 1: Enable Azure Defender for IoT

1. Open the Azure Portal
2. Browse to the **wssecuritySUFFIX** IoT Hub
3. Under **Security**, select **Overview**
4. Select **Enable**, then refresh the page
5. Select **Settings**
6. Select **Data Collection**
7. For the workspace configuration, toggle to **On**
8. Select the lab subscription
9. Select the **wssecuritySUFFIX** workspace
10. Select **Save**

## Reference Links

- Network Map
