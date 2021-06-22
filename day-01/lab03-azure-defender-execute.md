# Azure Security Center + Azure Defender Setup : Lab 3 : Execute Azure Defender Protections

- Topics
  - Adaptive Application Controls
  - File Integrity Monitoring
  - SQL Vulnerability
  - Container and Container Image Scanning
  - Just In Time Access
  
## Exercise 1: Adaptive Application Controls

### Task 1: Adaptive Application Controls

1. Switch to the Azure Portal.
2. Search for Virtual Machines, then select it
3. Select all virtual machines, then select **Services->Inventory**, ensure that all virtual machines are connected to the **wssecuritySUFFIX** workspace.  If not, do the following
   1. Select the **CUSTOM...** radio button, then browse for your **wssecuritySUFFIX** log analytics workspace
   2. Select **Enable**
4. Select all virtual machines, then select **Services->Update Management**, ensure that all virtual machines are connected to the **wssecuritySUFFIX** workspace.  If not, do the following
   1. Select the **CUSTOM...** radio button, then browse for your **wssecuritySUFFIX** log analytics workspace
   2. Select **Enable**
5. Search for and select **Azure Security Center**.
6. In the blade menu, scroll to the **Cloud Security** section and select **Azure Defender**
7. Scroll to the bottom of the page, select **Adaptive application control**.
8. If prompted, select **Try Application Whitelisting**
   1. If prompted, select your workspace, then click **Upgrade**
   2. Select **Continue without installing agents**
9. You will likely have several groups displayed, find the one that has your newly created lab VMs.
  ![Machine groupings is displayed.](./media/securitycenter-grouping.png "Azure automatically created a group for your VMs")
10. Expand the **More applications** section, you should see that Google Chrome and Notepad++ were picked up and have Microsoft Certificated tied to them
  ![The discovered applications are displayed.](./media/securitycenter-whitelistingrules.png "Notice the applications that were executed on the machine are displayed")
11. Select **Audit**, the group state will move to **In progress**.

## Exercise 2: File Integrity Monitoring

### Task 2: File Integrity Monitoring

1. Navigate back to the main Azure Security Center page
2. In the blade menu, scroll to the **Cloud Security** section and select **Azure Defender**
3. Select **File Integrity Monitoring**.
4. For the log workspace tied to your lab environment virtual machines, is displayed, select **Upgrade Plan**

   ![Update the workspace.](./media/securitycenter-fileintegrity-upgrade.png "Upgrade the workspace")

5. Select **Try File Integrity Monitoring**.
6. Select the workspace only, then select **Upgrade**.
7. Select the **Continue without installing agents** link.

   ![The continue without installing agents link is highlighted.](./media/fileintegrity-enable.png "Select the continue without installing agents link")

8. If displayed, select **Enable**, then select **Enable File Integrity Monitoring**. If not displayed, simply select the workspace.

    > **NOTE** This can take some time, but is typically within a few minutes

9. Refresh the File Integrity Monitoring page
10. In the menu, select **Settings**.

    ![The Settings link is highlighted.](./media/fileintegrity-settings.png "Select the settings link")

11. Select the **Windows Files** tab.
12. Select **+Add**.
13. For the item name, type **HOSTS**.
14. For the path, type **c:\windows\system32\drivers\etc\\\***.
15. Toggle **Recursion** to **On**
16. Toggle **Upload file content** to **True**
17. Select **Save**.

    ![The settings page is displayed with the links highlighted.](./media/fileintegrity-addentry.png "Add a new file integrity monitoring item")

18. Select the **File Content** tab.
19. Select **Link**, then select the storage account tied to your lab.

    > **NOTE** It will take 30-60 minutes for Log Analytics and its management packs to execute on all your VMs. As you may not have that much time with this lab, screen shots are provided as to what results you will eventually get.

    ![The file content page is displayed with the links highlighted.](./media/fileintegrity-filecontent.png "Link a storage account for file changes")

20. Select **Save**
21. Switch to the Remote Desktop Connection to the **paw-1**.
22. Open the **c:\windows\system32\drivers\etc\hosts** file.
23. Add the following entry:

    ```cmd
    10.0.0.6    linux-2
    ```

24. Save the file.
25. After about 30-60 minutes, the Log Analytics workspace will start to pickup changes to your files, registry settings and windows services.
    - Switch to your Log Analytics workspace
    - Under **General**, select **Logs**
    - Run the following query:

    ```output
    ConfigurationChange
    | where Computer == "paw-1"
    | where ConfigChangeType in("Files", "Registry")
    | order by TimeGenerated
    | render table
    ```

    ![The file changes are saved to the logs of the workspace.](./media/fileintegrity-logchanges.png "Review the file change logs for the paw-1 machine in the log analytics workspace")

26. You will also start to see the file snapshots show up in the storage account:

    ![The file changes are displayed in the storage account.](./media/fileintegrity-snapshots.png "The file changes are displayed in the storage account")

## Exercise 3: VM Vulnerability

### Task 1: VM Vulnerability

1. Switch to the Azure Portal.
2. Open the Azure Security Center
3. Select **Azure Defender**, then scroll down and select **VM vulnerability assessment**
4. Select the checkbox to select all the virtual machines

  ![Select all VMs.](./media/vm_vulnerability_vms.png "Select all VMs")

5. Select **Fix**

  ![Select the Qualsys agent.](./media/vm_vulnerability_agent.png "Select the Qualsys agent")

6. Select **Proceed**
7. In the dialog, select **Fix X resources**

  > **Note** After a few hours, the agent will be installed on all selected machines and the assessment data will start to flow into the Security Center.

## Exercise 4: SQL Vulnerability

### Task 1: SQL Vulnerability

1. Switch to the Azure Portal.
2. Browse to the **wssecuritySUFFIX** Azure Database for SQL instance
3. Under **Security**, select **Security Center**, if you see **Enable AZure Defender for SQL**, select it.
4. After a few minutes, you should see the recommendations and security alerts for the single SQL resource (if any)
5. Select the **(Configure)** link

  ![Select the configure link.](./media/sql_vulnerability_configure.png "Select the configure link")

6. Select the **Select storage account** link
  
  ![Select the storage account link.](./media/sql_vulnerability_storage_account.png "Select the storage account link")

7. Select the **wssecuritySUFFIX** storage account
8. Select the **Enable Auditing for better threats investigation experience** link

  ![Select the link.](./media/sql_vulnerability_storage_auditing.png "Select the link")

8. Toggle the **Enable Azure SQL Auditing** to **On**
9.  Select **Log Analytics** checkbox
10. Select the **wssecuritySUFFIX** log analytics workspace
11. Toggle the **Enable Auditing of Microsoft support operations** to **On**

  ![Configure auditing.](./media/sql_vulnerability_storage_auditing_config.png "Configure auditing")

12. Select **Save**
13. In the Azure Portal, open the Azure Security Center
14. Under **Cloud Security**, select **Azure Defender**
15. Scroll to the bottom, select **SQL Vulnerability Assessment**, after a few minutes, you should see all servers across the subscription displayed.

## Exercise 5: Container and Container Image Scanning

### Task 1: Container and Container Image Scanning

1. Log in to the **wssecuritySUFFIX-paw-1** virtual machine
2. Open the Azure Portal to your lab environment
3. Navigate to your lab resource group
4. Open the **wssecuritySUFFIX** container registry
5. Under **Services**, select **Repositories**, notice there are no images
6. Under **Settings**, select **Access keys**
7. Copy the username and password for later use

  ![Copy username and password.](./media/container_registry_keys.png "Copy username and password")

8. Open a powerShell window, log in to the **wssecuritySUFFIX-linux-1** virtual machine by running the following:

  ```bash
  ssh wsuser@10.0.0.5
  ```

8. When prompted, type `yes`, then enter the lab password
9. In the new SSH session, run the following command. This will push an image to the container registry.

  ```bash
  sudo apt-get update

  sudo apt-get install pass gnupg2

  sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release

  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
  sudo apt-get install docker-io docker-ce-cli containerd.io

  sudo apt-get install docker-compose

  sudo apt-get install make

  sudo docker pull wernight/bfgminer

  sudo docker pull metal3d/xmrig:latest

  sudo docker pull mcr.microsoft.com/dotnet/core/aspnet:2.1

  ```

10. Push the image to your Azure Container Registry, replace the name, username and password:

  ```bash
  sudo docker login {acrName}.azurecr.io -u {username} -p {password}

  sudo docker tag wernight/bfgminer {acrName}.azurecr.io/bitcoin/windows

  sudo docker tag metal3d/xmrig {acrName}.azurecr.io/metal3d/xmrig

  sudo docker tag mcr.microsoft.com/dotnet/core/aspnet:2.1 {acrName}.azurecr.io/dotnet/core/aspnet:2.1

  sudo docker push {acrName}.azurecr.io/bitcoin/windows

  sudo docker push {acrName}.azurecr.io/metal3d/xmrig

  sudo docker push {acrName}.azurecr.io/dotnet/core/aspnet:2.1

  ```

11. Switch to the Azure Portal, browse to the **wssecuritySUFFIX** Azure Container Registry
12. Under **Services**, select **Repositories**, you should see the new images displayed

  ![Three containers are displayed.](./media/container_registry_containers.png "Three containers are displayed")

13. Under **Services**, select **Security**, ensure the setting is set to **On**

  ![Ensure security is enabled.](./media/container_registry_security_on.png "Ensure security is enabled")

14. Browse to **Azure Security Center**
15. Under **Cloud Security**, select **Azure Defender**
16. Select **Contain Image scanning**, you should see one or more recommendations displayed

  ![Containers with issues.](./media/container_registry_security_recommendations.png "Containers with issues")

## Exercise 6: Just In Time Access

### Task 1: Just In Time Access

1. In a browser, navigate to your Azure portal (<https://portal.azure.com>).
2. Search for **Security Center**, select it
3. Under **Cloud Security** select **Azure Defender**.
4. Scroll to the bottom, select **Just-in-time VM Access**
5. Select the **Configured** tab, and verify the lab VMs are displayed.  If not, select the **Not Configured** tab, and then check the checkbox to select the lab VMs, and then select the **Enable JIT on X VMs** link.
6. In the configuration window that opens, review the settings, then select **Save**.
7. After a few minutes, you should see the virtual machines moved to the **Configured** tab.

### Task 2: Perform a JIT request

1. Select the **paw-1** virtual machine, and then select **Request access**.

    ![On the Virtual machines screen, the first listed virtual machine name is selected and highlighted (paw-1), as is Request access button above it.](./media/jit_request_access.png "Request access for paw-1")

2. For each of the ports, select the **On** toggle button, notice how the default IP settings is **My IP**.

    ![On is selected under the Toggle column for all four of the ports listed under paw-1.](./media/jit_request_access2.png "Select on for each of the ports")

3. At the bottom of the dialog, select **Open ports**. After a few moments, you should now see the **APPROVED** requests have been incremented and the **Last Access** is set to **Active now.**.

    ![On the Virtual machines screen, the paw-1 virtual machine displays 1 Request as approved, and the last access column shows Active now.](./media/jit_request_displayed.png "View Approved and Last Access status")

    > **Note**  If you did not wait for your VMs and virtual networks to be fully provisioned via the ARM template, you may get an error.

4. Select the ellipses, then select **Activity Log**, you will be able to see a history of who requests access to the virtual machines.

    ![Activity Log is highlighted in the shortcut menu for the last user.](./media/jit_request_audit.png "View the Activity Log")

    > **Note**: These entries will persist after you have deleted the VMs. You will need to manually remove them after VM deletion.

5. In the Azure Portal main menu, select **All Services**, then type **Network**, then select **Network security groups**.

    ![All services is highlighted in the left menu of the Azure portal, and the Network security groups is highlighted in the filtered list to the right.](./media/jit_network_security_group.png "Select paw-1-nsg")

6. In the filter textbox, type **paw-1-nsg**, then select the **paw-1-nsg** network security group.

7. Select **Inbound security rules.** You should now see inbound security rules set up by JIT Access.

    ![The first four listed items are highlighted under Inbound security rules.](./media/jit_network_rules.png "View the inbound security rules set up by JIT Access")

## Exercise 6: Clearing Recommendations

### Task 1: Clearing Recommendations

1. Switch to Azure Security Center
2. Under **General**, select **Recommendations**
3. Review your **Secure Score**
  
  ![Your current secure score.](./media/asc_secure_score.png "Your current secure score")

4. Scroll down to the **Controls** section, review each of the recommendations

  ![Your current recommendations.](./media/asc_secure_recommendations.png "Your current recommendations")

5. Resolve as many controls and recommendations as possible.  Compare your scores to other workshop attendees.

## Exercise 7: Azure Security Center Settings

### Task 1: Azure Defender Plans

1. In a browser, navigate to your Azure portal (<https://portal.azure.com>).
2. Search for and open **Security Center**
3. Under **Management**, select **Pricing & Settings**
4. Select the lab subscription
5. On the Azure Defender Plans, click **Enable all** then select **Save**
6. Select the **wssecuritySUFFIX** log analytics resource
7. On the Azure Defender Plans, select **Azure Defender On**
8. Select **Save**
9. Under **Settings**, select **Data collection**
10. Select **Common**

  ![Enable logging.](./media/asc_log_analytics_data_collection.png "Enable logging")

11. Select **Save**

### Task 2: Auto provisioning

1. Under **Management**, select **Pricing & Settings**
2. Select the lab subscription
3. On the Settings page, select **Auto provisioning**
4. Toggle the **Log Analytics agent for Azure VMs** to **On**

  ![Enable auto provisioning.](./media/asc_subscription_auto_provision.png "Enable auto provisioning")

5. Select **Edit configuration**
6. In the dialog, select **Connect Azure VMs to a different workspace**
7. Select the **wssecuritySUFFIX** workspace
8. Select **Existing and new VMs**

  ![Set the workspace.](./media/asc_subscription_auto_provision_config.png "Set the workspace")

9.  Select **Apply**
10. Toggle the **Microsoft Dependency agent** to **On**
11. Toggle the **Policy Add-on for Kubernetes** to **On**
12. Select **Save**

### Task 3: Continuos Export

1. On the Settings page, select **Continuous export**
2. Review the settings on the page, notice that you can send data to an event hub or to another log analytics workspace.

  ![Continuous export settings.](./media/asc_subscription_continous_export.png "Continuous export settings")

### Task 4: Cloud Connectors

1. On the Settings page, select **Cloud connectors**
2. Review the settings on the page, notice that you can connect your AWS or GCP cloud accounts

  ![Cloud connector settings.](./media/asc_subscription_cloud_connectors.png "Cloud connector settings")

## Reference Links

- [Adaptive Application Controls](https://docs.microsoft.com/en-us/azure/security-center/security-center-adaptive-application)
- [File Integrity Monitoring](https://docs.microsoft.com/en-us/azure/security-center/security-center-file-integrity-monitoring)

