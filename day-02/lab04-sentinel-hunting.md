# Sentinel Extensibility + Hunting

- Topics
  - End to end investigation (backwards from sentinel)
  - Perform queries
  - Setup Alerts
  - Perform Investigations
  - Troubleshoot
  - KQL UNIONs
  - SIEM Integration

## Notes

- supply chain attack?
  - modify container image
  - upload a bitcoin miner image?

- Send email with word document
- embed macro in word document
- have execute powershell script
- download mimikatz
- lateral movement
- encrypt some files in hosts
- set some registry keys

## Exercise 1: Execute Attack

You will execute an attack on your paw virtual machine that will do some not so great things. Since your environment has Azure Sentinel configured with all the various data connectors, you should get a basic alert fired. It will be your job to determine what the attack did.

### Task 1: Execute Attack

1. Switch to your **paw-1** virtual machine
2. Run the `.\artifacts\day-02\Attack.ps1`

## Exercise 2: Investigating alerts

The previous exercise created a breach in a system in your environment. You will need to determine what happened and determine what remediation can be done (if any).

### Task 1: Review Alert

1. Open Azure Sentinel
2. Select **Alerts**

### Task 2: Review Alert Story

1. TODO.

### Task 3: Troubleshoot

TODO

1. TODO.

### Task 3: Run some KQL

TODO

1. TODO.

### Task 4: Ask questions

1. Who caused the attack to occur?
2. What entities were involved?
3. What was the steps of the attack?

## Exercise 3 : Use STIX and TAXII with Azure Sentinel

As part of your investigation, you found out someone else had already discovered this attack pattern and published it to a TAXII feed. You want to bring these alerts into your Azure Sentinel for future incident creation.

### Task 1: Create TAXII Connections

1. Open the Azure Portal in your **paw-1** virtual machine
2. Select **Azure Sentinel**
3. Under **Configuration**, select **Data Connectors**
4. Select **Threat Intelligence – TAXII** from the list of the data connectors
5. Click the **Open Connector page** button.
6. For the **Friendly name**, type **Mitre**
7. Enter the API Root, type **https://cti-taxii.mitre.org/stix**
8. For Collection ID, type **95ecc380-afe9-11e4-9b6c-751b66dd541e**
9. For username and password leave blank
10. Click the **Add** button.
11. For the **Friendly name**, type **Anomali**
12. Enter the API Root, type **https://limo.anomali.com/api/v1/taxii2/feeds/**
13. For Collection ID, type **107**
14. For username and password, type **guest**
15. Click the **Add** button.
16. You should now see a confirmation on the notification dialog that the connection was established successfully. The TAXII Server will now show up in the List of the configured TAXII Servers.
17. To view the threat indicators imported into Azure Sentinel, select **Logs**

### Task 2: Create alerts

1. Under **General**, select **Logs**
2. You should now see an **Azure Sentinel** table category displayed
3. Expand it and then expand **ThreatIntelligenceIndicator**. You should now see a list of all the alerts that were imported from the TAXII connectors
4. Under **Threat Management**, select **Threat Intelligence**
5. You should notice several new items displayed based on type and the source (you should see Anomali and Mitre as sources)
6. Select one of the items
7. In the dialog on the right, click the **0 Alerts** area. You will be directed to Log Analytics with the query that represents the item
8. Select **New alert rule->Create Azure Sentinel alert**, follow the dialogs as you have done before in previous labs.
9. Congrats, you have imported external security provider data and created an alert from it using the STIX and TAXII standards.