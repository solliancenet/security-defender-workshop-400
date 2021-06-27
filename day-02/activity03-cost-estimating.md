# Activity 01: Estimating Azure Sentinel + Log Analytics

Wide World Importers would like to explore migrating from their on-premises SIEM/SOAR system to Azure Defender + Log Analytics + Azure Sentinel.  They would like to have Microsoft present a migration path and potential costs.

**Requirements**

* Calculate the costs of the potential solution.

**Environment**

* Wide World Importers has a 3 node Splunk cluster configured.
* All hardware sends their logs to Splunk via connectors
* WWI has F5 BIG-IP load balancers, Baracuda firewalls, Cisco Meraki, Okta identity, and several Windows and Linux servers.
* Some of their software systems are cloud agnostic and run across Azure, Amazon Web Services and Google Cloud for high availability.
* WWI has determined that they ingest ~500GB per day in log data, but they can see their needs growing to 1TB per day in the next year.
* They would like to know if they can implement some kind of log filtering before it makes it to Azure Sentinel
* They currently fire 50-75 alerts per day, about 10% send SMS messages.
* WWI has about 125 active Windows servers plus another 75 active Linux servers
* WWI utilizes several SQL and no-SQL based machines.  They estimate around 10 SQL machines and another 15 PostgreSQL and MySQL server instances.
* WWI will be utilizing AKS for their app modernization and estimate they will have 100 cores when the modernization is complete.
* Images will be stored in Azure Container Registry, they currently have 50 images they plan to move over

## Whiteboard

Open your whiteboard for the event, and in the area for Activity 1 provide your answers to the following challenges.

*The following challenges are already present within the whiteboard template provided.*

Challenges

1. What will the final cost of the solution be? Are there any programs WWI could take advantage of to keep costs low?

## Resources

1. Are there resources that can be referenced for calculating costs other than the Azure cost calculator?
