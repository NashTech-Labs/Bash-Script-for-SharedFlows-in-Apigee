## Shared Flows in Apigee 

It provide a way to encapsulate reusable logic and policies that can be shared across multiple API proxies.

### Prerequisites
Before proceeding with the automation of Shared Flows, make sure you have the following prerequisites in place:

1. Apigee X organization and environment set up

2. ApigeeCLI installed and configured on your local machine

3. Access to the Apigee X management APIs (ensure you have the necessary permissions)

## Steps for Automation

Follow these steps to automate the management of Shared Flows in Apigee X using ApigeeCLI:

Step 1: Clone Github Repository containing automation script

git clone https://github.com/knoldus/Bash-Script-for-SharedFlows-in-Apigee.git

$ cd Bash-Script-for-SharedFlows-in-Apigee

Following is the bash script for the automation of sharedflows in Apigee:

`sharedflow.sh `

Step 2: Create a Shared Flow

View all the possible commands by using this:

`$ bash sharedflow.sh undeploy <organization> <environment> <revision>`
 

Create a Shared Flow using this automation script:


`$ bash sharedflow.sh create <organization>`

Replace <organization> with your Apigee X organization name

It will ask you to choose which shared flow to create. Enter number as per your choice.
After chossing, it will create sharedflow in Apigee.

Step 3: Deploy a Shared Flow

Deploy the Shared Flow to an environment:

`$ bash sharedflow.sh deploy <organization> <environment> <revision>`

Replace <organization> with your Apigee X organization name, <environment> with the target environment and <revision> with the revision number to deploy.


SharedFlow is deployed to the environment.

Step 4: Undeploy a Shared Flow

Undeploy the Shared Flow from an environment:

`$ bash sharedflow.sh undeploy <organization> <environment> <revision>`

Replace <organization> with your Apigee X organization name, <environment> with the target environment, and <revision> with the revision number to undeploy.

SharedFlow is undeployed from the environment.