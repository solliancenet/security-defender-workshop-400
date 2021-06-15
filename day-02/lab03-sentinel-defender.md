# Configure Sentinel and Defender Integration

- Configure Sentinel \ Log Analytics
- Setup Defender Portal integrations
- Sentinel APIs
- 3rd party enrichment
- Utilize notebooks and machine learning

## Exercise 1 : Azure Sentinel Basics

1. Open the Azure Portal in your **paw-1** virtual machine
2. Select **Azure Sentinel**

    ![Azure Sentinel is highlighted.](media/sentinel-browse.png "Browse to Azure Sentinel")

3. Select **+ New**
4. Select the **wssecuritySUFFIX** log analytics workspace, then select **Add**
5. Under **General**, select **Logs**, notice your previous log analytics queries are displayed and available to run
6. Continue to explore the various Azure Sentinel blade items

    ![Azure Sentinel is displayed.](media/sentinel-view.png "Browse the Sentinel blade")

## Exercise 2 : Azure Sentinel Data Sources

### Task 1: Enable Azure Active Directory Connector

1. In the Azure Sentinel blade, under **Configuration**, select **Data connectors**
2. Select **Azure Active Directory**

    ![The click path is displayed.](media/sentinel-data-connector-aad.png "Select Azure Active Directory connector")

3. In the side dialog, notice the Data Types that will be imported (`SigninLogs`, `AuditLogs`, etc)
4. Select **Open connector page**

    ![The click path is displayed.](media/sentinel-data-connector-aad-details.png "Select Azure Active Directory connector")

    > **NOTE** You would need to have `global administrator` or `security administrator` access to the Azure AD tenant in order to make the connection. Unfortunately in these labs, your lab user does not have this level of access.

    ![The connector page is displayed.](media/sentinel-data-connector-aad-connect.png "Review the connector page screenshot")

5. Select all items, then select **Apply Changes**

### Task 2: Enable Azure Active Directory Identity Protection Connector

1. Navigate back to Azure Sentinel blade, select **Azure Active Directory Identity Protection**
2. Select **Open connector page**
3. Select **Connect**
4. Select **Enable**

### Task 3: Enable Azure Defender Connector

1. Navigate back to Azure Sentinel blade, select **Azure Defender**
2. Select **Open connector page**
3. Select your subscription, then select **Connect**
4. In the dialog, select **OK**
5. For the **Azure Defender plans**, select **Enable all**
6. Select the **Azure Defender on** box, then select **Enable all**
7. Select **Save**

### Task 3: Enable Microsoft 365 Defender

1. Navigate back to Azure Sentinel blade, select **Microsoft 365 Defender**
2. Select **Open connector page**
3. Select your subscription, then select **Connect incidents & alerts**
4. Check the **Turn off all Microsoft incident creation rules...**
5. Check all the checkboxes, then select **Apply Changes**

### Task 4: Enable Cloud App Security

1. Navigate back to Azure Sentinel blade, select **Microsoft 365 Defender**
2. Select **Open connector page**
3. Select **Cloud Discovery Logs**
4. Select **Apply Changes**

### Task 5: Review connectors

1. Navigate back to Azure Sentinel blade, select **Microsoft Defender for Endpoint**
2. Select **Open connector page**
3. Notice that the connector is already connected due to the parent connector **Microsoft 365 Defender** being connected

## Exercise 3 : Azure Sentinel Workbooks

1. In the Azure Sentinel blade, under **Threat Management**, select **Workbooks**
2. Select **Azure Defender for IoT Alerts**

   ![IoT Workbook is displayed.](media/sentinel-workbook-iot.png "Select the IoT Workbook")

3. Select **Save**
4. Leave the default selected workbook location, select **OK**
5. Select **View saved workbook**

    ![IoT Workbook is displayed.](media/sentinel-workbook-iot-dashboard.png "Select the IoT Workbook")

    > **NOTE** You would need to have setup the IoT labs in order to see events in this workbook.

6. Browse back to the Sentinel Workbooks blade
7. Select **Microsoft Web Application (WAF)- firewall events**
8. Select **Save**

    ![WAF Firewall events Workbook is displayed.](media/sentinel-workbook-fw.png "Select the IoT Workbook")

9. Leave the selected workbook location, select **OK**
10. Select **View saved workbook**

    > **NOTE** You would need to have completed the Web Application Gateway/Application Firewall lab in order to see events in this workbook.

## Exercise 4 : Azure Sentinel Hunting

1. In the Azure Sentinel blade, select **Hunting**
2. Review the page, notice it has several pre-built queries for `hunting` log data for events that are of interest

    ![Hunting is displayed.](media/sentinel-hunting.png "Review the Hunting blade")

3. Select one of the items, it will display the details of what that item does:

    ![Hunting example is displayed.](media/sentinel-hunting-example.png "Review a Hunting example")

## Exercise 5 : Azure Sentinel Entity Behavior

1. In the Azure Sentinel blade, select **Entity Behavior**
2. This feature allows you to track based on special types of entities such as Users, Resources, IP Address, etc
3. It must be enabled by a global admin, any unfortunately our lab environment does not allow for this.

## Exercise 6 : Threat Intelligence

1. In the Azure Sentinel blade, select **Threat intelligence**
2. In the top navigation, select **+Add new**
3. For the type, select **ipv4-addr**
4. For the address type **80.89.137.214**

    > **NOTE** This is a known bad ip address originating from Russia and injected into the Azure Security Center and Sentinel logs from previous steps.

5. For the threat types, select all options
6. For the confidence, move the scroll bar to **100**
7. For the valid from, select today's date
8. Select **Apply**

## Exercise 7 : Azure Sentinel Incidents and Investigation

### Task 1: Setup Query Rule

1. In the Azure Sentinel blade, under **Configuration**, select **Analytics**
2. Select **+Create**, then select **Schedule query rule**

   ![The click path is displayed.](media/sentinel-analytics.png "Select to create a new scheduled query rule")

3. For the name, type **Custom threats**
4. For the tactics, select **Discovery**
5. For the severity, select **High**
6. Select **Next: Set rule logic**

    ![Query rules details are displayed.](media/sentinel-query-rule.png "Enter the query rules details")

7. For the rule query, type the following:

    ```output
    OrgSecurity_CL
    | where IsThreat_b == true
    | extend IPCustomEntity = IPAddress
    | extend HostCustomEntity = Computer
    ```

8. Select **Next: Incident Settings**
9. Ensure the **Create incidents from alerts trigger by this analytics rule** is toggled to **Enabled**
10. Ensure the **Group related alerts, trigger by this analytics rule, into incidents** is toggled to **Enabled**
11. Ensure the **Group related alerts, triggered by this analytics rule in incidents**
12. For the time frame, select **5 Hours**
13. For the grouping, select **Grouping alerts into a single incident if the selected entities match**
14. Select the **IP** entity
15. Select **Next: Automated response**
16. Select **Next: Review**
17. Select **Create**

### Task 2: Investigate Incident

1. In the **Azure Sentinel** blade, select **Incidents**.
2. You should see a new incident displayed based on your previously created Alert:

    ![New incident is displayed.](./media/sentinel-incident-new.png "Select the new incident")

3. Select the incident, you will notice Sentinel is doing some prep work.

    ![Incident data is being collected.](./media/sentinel-incident-prep.png "Review the dialog")

4. Eventually the incident will be ready to be investigated, in the meantime we will continue with some other lab work.

## Exercise 8 : Azure Sentinel Notebooks

### Task 1: Import Notebook

1. In the **Azure Sentinel** blade, select **Notebooks**.
2. Review the list of sample notebooks, select the **A Getting Started Guide for Azure Sentinel ML Notebooks**, in the dialog, select **Save notebook**

    ![Notebook is highlighted.](./media/sentinel-notebook-launch.png "Launch the notebook")

3. Select the lab machine learning workspace, then select **OK**

    ![Machine Learning Workspace is selected.](./media/sentinel-notebook-mlworkspace.png "Select and launch the ML Workspace")

4. Select **Launch notebook**
5. If not already logged in, enter your lab Azure credentials. If prompted, close any dialogs.
6. Select the machine learning workspace, then select **Get Started**

    ![Machine Learning Workspace is selected.](./media/sentinel-notebook-mlworkspace-start.png "Select and launch the ML Workspace")

7. In the right navigation, select **Notebooks**
8. In the notebooks section, select the upload button, then **Upload Files**

    ![Machine Learning Workspace upload file.](./media/sentinel-notebook-mlworkspace-upload.png "Upload the notebook")

9. Upload the `c:\LabFiles\artifacts\Azure Sentinel ML.ipynb` file to the workspace, when prompted, check both checked boxes, then select **Upload**
10. In the Compute area, select the **+** sign
11. Select the **Standard_DS3_v2**

    ![Machine Learning Workspace upload file.](./media/sentinel-notebook-mlworkspace-compute.png "Upload the notebook")

12. Select **Next**
13. From compute name, type **Main**, select **Create**. Continue on while the compute is being provisioned.

14. In another browser tab, navigate to the [Azure Active Directory page](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview), copy your `Tenant ID` for use later.

    ![The Azure AD page is displayed.](./media/sentinel-azuread-tenant-id.png "Copy the tenant id")

15. Browse to your **wssecuritySUFFIX** log analytics workspace, copy the workspace id.

### Task 2: Create VirusTotal account

1. Open [VirusTotal web site](https://www.virustotal.com/gui/join-us), if you already have an account, [login to it](https://www.virustotal.com/gui)
   - Fill in the form details, select **Join us**
2. Log in to the website, in the top right navigation, select your user icon
3. Select **API Key**

    ![The click path is displayed.](./media/virustotal-browse.png "Select API Key")

4. Copy the API Key for later steps

    ![The API Key is highlighted.](./media/virustotal-apikey.png "Select the API key")

### Task 3: Create MaxMind account

1. Open the MaxMind [sign up page](https://www.maxmind.com/en/geolite2/signup). If you already have an account, [login to it](https://www.maxmind.com/en/account/login)
   - Fill out the sign up form, select **Continue**
2. Login to the MaxMind site
3. Select **Managed License Keys**, then select **Generate new license key**

    ![The click path is highlighted.](./media/maxmind-api-key.png "Create a new API key")

4. Select **No**
5. Select **Confirm**

### Task 4: Execute a Hunt

1. Switch back to the Machine Learning NoteBook, the compute should be provisioned
2. If prompted, select **Start Jupyter kernel**
3. For each cell select **Run** and follow each of the cells as they are executed. Do not run the entire notebook.

    ![The Run button is highlighted.](./media/sentinel-notebook-run.png "Run the notebook")

4. Some cells will output information:

    ![A cell with output.](./media/sentinel-notebook-cell-output.png "Review the output")

5. Some will prompt you for data such as the Workspace, TenantId and API keys:

    ![A cell with input.](./media/sentinel-notebook-cell-input.png "Enter your information in the cell")

6. Another cell will ask you to generate an access token

    ![A cell to connect to Azure.](./media/sentinel-notebook-cell-azure-login.png "Copy the device token to azure for authentication")

   - Copy the device code and click the **Copy code to dashboard and authenticate**

   - In the dialog that opens, copy the device code

   - Login using the lab username and password

7. Continue to run a few more cells, you should see a cell output the Log Analytics table and the `SigninLogs` schema:

    ![Cell output is displayed.](./media/sentinel-notebook-cell-log-analytics-tables.png "Review the output")

8. One cell will display the queries available to you

    ![Cell output is displayed.](./media/sentinel-notebook-cell-log-analytics-queries.png "Review the output")

9. The next cell will display kusto query details

    ![Cell output is displayed.](./media/sentinel-notebook-cell-log-analytics-query-details.png "Review the output")

10. The next cell will execute a query passing in parameters:

    ![Cell output is displayed.](./media/sentinel-notebook-cell-log-analytics-query-execution.png "Review the output")

11. Run the remaining cells, you will make calls to the external API providers to enrich the log data with threat levels and IP Address analysis

## Exercise 9 : Extending Azure Sentinel Incidents (Optional)

This task requires registration to gain access to an API Key. It can take a few days to do this action.

### Task 1 : RiskIQ Api Key

1. Open a browser window to https://api.riskiq.net
2. In the left navigation, select the **Register Now** link, or login to your account
3. Fill out the form, login using the email you used in the form
4. Register and validate your email address in the verification email
5. [Login to the site](https://community.riskiq.com/login), select the profile icon, then select **Account Settings**

    ![The click path is displayed.](./media/maxmind-profile.png "Browse to the API key")

6. Select **Show** for the User, record your API Key and Secret

### Task 2 : Extend Azure Sentinel

1. Open a browser window to https://github.com/Azure/Azure-Sentinel/tree/master/Playbooks/Enrich-SentinelIncident-RiskIQ-IP-Passive-DNS
2. Click the **Deploy to Azure** button
3. Be sure you are logged into your lab account
4. Select your subscription and resource group
5. For the playbook name, ensure **Recent-IP-Passive-DNS** is displayed
6. For your username, type the lab username (ex: odl_user_SUFFIX@solliancelabs.onmicrosoft.com)

    ![The custom deployment parameters are displayed.](./media/riskiq-azure-deployment.png "Enter the template parameters")

7. Select **Review and create**
8. Select **Create**
9. In the Azure portal, navigate to your Azure Sentinel and your log analytics workspace
10. Select **Automation** from the Azure Sentinel navigation menu, then select **Playbooks**
11. Select the **Recent-IP-Passive-DNS** playbook by selecting the playbook name

    ![The imported playbook is displayed.](./media/riskiq-playbook.png "Select the imported playbook")

12. Select **Edit** from the top menu of the playbook

    ![Edit is highlighted.](./media/riskiq-edit.png "Edit the imported playbook")

13. There are four steps in this playbook requiring you to configure connections. Select a Connection from one of the steps requiring configuration and configure a new connection. Select the **Invalid** icon

    ![Invalid icon error is highlighted.](./media/riskiq-edit-connection.png "Edit the connections")

14. Select **Sign in**

    ![Sign in button is highlighted.](./media/riskiq-edit-connection-signin.png "Select Sign in")

15. Enter your lab username and password.

    > **NOTE** For the connections to Azure Sentinel the user specified when establishing the connection must have sufficient permissions in the Azure Sentinel workspace to read the security alerts.

16. Expand the **For each** activity, select the the RiskIQ connection
17. Select the Invalid icon
18. For the name, type **RiskIQ**
19. Enter your RiskIQ API token and secret obtained from RiskIQ portal

    ![RiskIQ settings are displayed.](./media/riskiq-edit-connection-riskiq.png "Enter your information")

20. Select **Save** from the top menu of the playbook to save the playbook
21. Navigate to your Azure Sentinel **Analytics** page, select the **Custom Threats** rule you created earlier, then select **Edit**

    > **NOTE** The Recent-IP-Passive-DNS playbook works with analytics rules which map IP address entities so make sure you are working with such a rule. For simple testing of the playbook automation you can use rule logic as shown below to force an alert creation with a specific IP address.

    ```output
    AzureActivity
    | take 1
    | extend IPCustomEntity = "144.91.119.160"
    ```

22. Navigate to the **Automated response** tab
23. Place a check mark in the box for the Recent-IP-Passive-DNS playbook which will enable the playbook to run each time the analytic rule generates security alerts
24. Select **Next: Review**
25. Select **Save** to finish and return to the Analytics page

### Task 3 : Review Incident

1. Navigate back to your Azure Sentinel Incidents page
2. Locate the new incident generated from the analytic rule previously and select it
3. Select **View full details** from the information pane
4. Select the **View playbooks** on the far right
5. For the **Recent-IP-Passive-DNS** playbook, select **Run**.  After a few moments you will see a new comment added.
6. Select the **Comments** tab to see the enrichment added by the Recent-IP-Passive-DNS playbook automation. You can also view the information in the RiskIQ portal by following the link provided at the bottom of the comment.

    ![Azure Sentinel incident is enriched with comments.](./media/sentinel-enrichment.png "Review the enrichment comments")

> **Congrats, you have used Machine Learning to analyze signals from your Azure resources and tied that data to Azure Sentinel with extended external API calls for incident enrichment. Good luck on your security journey in Azure!**

## Reference Links

- [What is Azure Sentinel](https://docs.microsoft.com/en-us/azure/sentinel/overview)
- [Investigate incidents with Azure Sentinel](https://docs.microsoft.com/en-us/azure/sentinel/tutorial-investigate-cases)
- Azure Sentinel Notebooks
- [Enrich Azure Sentinel security incidents with the RiskIQ Intelligence Connector](https://techcommunity.microsoft.com/t5/azure-sentinel/enrich-azure-sentinel-security-incidents-with-the-riskiq/ba-p/1534412)

# Resources

- https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/investigate-alerts?view=o365-worldwide
