# Activity 01: Data Import (Filter and Enrichment)

Due to the size of their data and the estimated costs, Contoso would like to do some basic filtering on the raw logs that will be ingested into Azure Sentinel.  They are looking for solutions to do this filtering.

**Requirements**

* Filter raw data to lower ingestion and storage costs
* Provide higher quality data with enrichments

**Environment**

* WWI ingests data from their F5 BIG-IP load balancers, Baracuda firewalls, Cisco Meraki, Okta identity, and several Windows and Linux servers.
* This data has a lot of extra fields and content that is not important for their current queries and alerts.
* Currently they use a custom process to filter out data they do not need and import it into Splunk.

## Whiteboard

Open your whiteboard for the event, and in the area for Activity 1 provide your answers to the following challenges.

*The following challenges are already present within the whiteboard template provided.*

Challenges

1. Is it possible to filter raw event and log data before it gets to Azure Sentinel?
2. How might WWI enrich their data before it gets into Azure Sentinel?
