# Activity 01: Azure Defender

Contoso is migrating their entire on-premises infrastructure to Azure.  They would like to implement security best practices across all of their migrated resources and ensure that new resources meet their baseline standards.

**Requirements**

* Provide a security baseline to Contoso for their future Azure landing zone

**Environment**

* 100s of servers that comprise Windows and Linux servers
* Web Applications that will be exposed to the internet and utilize Azure Database for SQL
* Contoso is moving to a micro-services and container based platform as part of their modernization efforts using Azure Kubernetes Service (AKS)
* Contoso applications are using hard coded app configuration values, but they would like to move to Azure Key Vault, however, they are worried that administrators may abuse the Key Vault service and still gain access to confidential values.
* Contoso would like to enable self-service Azure resource groups, but want to ensure that any resources that are deployed are done so in a secure and compliant manner.

## Whiteboard

Open your whiteboard for the event, and in the area for Activity 1 provide your answers to the following challenges.

*The following challenges are already present within the whiteboard template provided.*

Challenges

1. How will Contoso monitor the security of their cloud-based Azure?
2. Contoso is concerned about moving their web applications over to public endpoint, how can they secure these resource from common attacks and service take downs?
3. How can Contoso ensure that their AKS containers will be secure?
4. Contoso has had issues with administrators installing applications that were not approved on infrastructure servers, with the latest supply chain hacks they would like to ensure that they keep tabs on any new applications that are installed.
5. How can Contoso keep track of unauthorized access to Azure Key Vault?
6. What can Contoso do to keep self-service users from abusing or deploying un-secure solutions to their Azure Subscriptions?
