# Activity 01: Log Analytics + Azure Automation

Wide World Importers has several automation commands setup in their on-premises Splunk instance that fire automatically when certain alerts are created. These commands do various things against both on-premises environments and cloud-based environments.  They would like to know how they would do the same with a cloud-based SEIM/SOAR software like Azure Sentinel.

**Requirements**

* Execute remediation actions on on-premises devices
* Execute remediation actions on cloud-based environments

**Environment**

* WWI has F5 BIG-IP load balancers, Baracuda firewalls, Cisco Meraki, Okta identity, and several Windows and Linux servers.
* Some of their software systems are cloud agnostic and run across Azure, Amazon Web Services and Google Cloud for high availability.
* Be able to execute PowerShell scripts against on-premises environments
* Execute cloud-based REST APIs using various authentication mechanisms (Username/Password, OAuth, Certificates)

## Whiteboard

Open your whiteboard for the event, and in the area for Activity 1 provide your answers to the following challenges.

*The following challenges are already present within the whiteboard template provided.*

Challenges

1. Can you run automated processes from Azure Sentinel on on-premises devices
2. How would you remediate alerts in Azure-based resources?
3. How would you remediate alerts in other cloud-based providers?
