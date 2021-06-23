# Activity 01: Planning, migrating and estimating Azure Sentinel + Log Analytics

Wide World Importers would like to explore migrating from their on-premises SIEM/SOAR system to Log Analytics + Azure Sentinel.  They would like to have Microsoft present a migration path and potential costs.

**Requirements**

* Determine supported and unsupported connectors.
* Determine the work/effort to migrate.
* Decide if a hybrid approach is appropriate.
* Calculate the costs of the potential solution.

**Environment**

* Wide World Importers has a 3 node Splunk cluster configured.
* All hardware sends their logs to Splunk via connectors
* WWI has F5 BIG-IP load balancers, Baracuda firewalls, Cisco Meraki, Okta identity, and several Windows and Linux servers.
* Some of their software systems are cloud agnostic and run across Azure, Amazon Web Services and Google Cloud for high availability.
* WWI has determined that they ingest ~500GB per day in log data, but they can see their needs growing to 1TB per day in the next year.
* They would like to know if they can implement some kind of log filtering before it makes it to Azure Sentinel
* They currently fire 50-75 alerts per day, about 10% send SMS messages.

## Whiteboard

Open your whiteboard for the event, and in the area for Activity 1 provide your answers to the following challenges.

*The following challenges are already present within the whiteboard template provided.*

Challenges

1. Are all the connectors supported in Log Analytics / Azure Sentinel?
2. What items will WWI need to migrate from Splunk? Can any of it be automated?
3. If not all connectors are supported, can they run in a hybrid mode until they are?
4. What will the final cost of the solution be? Are there any programs WWI could take advantage of to keep costs low?
