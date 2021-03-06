# Activity 01: Migrate SIEM to Azure Sentinel

For compliance reasons, Contoso would like to maintain raw and filtered logs for longer than 90 days, but no longer than 365 days (1 year).  They would like to know how they might be able to accomplish this with Azure Sentinel and Azure tools.

**Requirements**

* Determine supported and unsupported connectors.
* Determine the work/effort to migrate.
* Decide if a hybrid approach is appropriate.
* Keep raw and filtered logs for longer than 90 days.
* Remove data after 365 days

**Environment**

* WWI ingests data from their F5 BIG-IP load balancers, Baracuda firewalls, Cisco Meraki, Okta identity, and several Windows and Linux servers.
* This data has a lot of extra fields and content that is not important for their current queries and alerts.
* Currently they use a custom process and in some cases LogStash to filter out data they do not need and import it into Splunk.

## Whiteboard

Open your whiteboard for the event, and in the area for Activity 1 provide your answers to the following challenges.

*The following challenges are already present within the whiteboard template provided.*

Challenges

1. Is it possible to filter raw event and log data before it gets to Azure Sentinel?
2. How might WWI enrich their data before it gets into Azure Sentinel?
3. Are all the connectors supported in Log Analytics / Azure Sentinel?
4. What items will WWI need to migrate from Splunk? Can any of it be automated?
5. If not all connectors are supported, can they run in a hybrid mode until they are?
