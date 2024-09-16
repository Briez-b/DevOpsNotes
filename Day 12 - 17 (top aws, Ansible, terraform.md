
---
# ==Day 12 | Deploy and expose your First App to AWS

1. Clone the desired app to local repository: https://github.com/verma-kunal/AWS-Session
2. Test if this app works locally: create `.env` file and copy there template from instruction on github(and fill the variables):
![](../Images/Pasted%20image%2020240916160058.png)

3. `npm install` and `npm run start`. Now I am able to run this app in browser with domain name.
Now the app is installed on local machine. Now let's install it on aws EC2 machine

4. Connect to EC2 instance. Then install `node` and `npm`.
5. Set variables in .env the same way as before
6. `npm install` and `npm run start`. The application still can't be run as we need to add inbound rule to security group of our EC2 instance:
![[Screenshot from 2024-08-25 14-01-15.png)

7. Now it is can be run with this address: public ip of ec2 instance and port(http://52.28.243.198:3000/)

---

# ==Day 13 | Top 15 AWS Services that Every DevOps Engineers should learn

AWS services for Devops engineers
1. ==EC2==
2. ==VPC==(private, secure)
3. ==EBS== (allow you to add additional volumes to EC2)
4. ==S3== (storage)
5. ==IAM== (identity and access management, configure permissions for users)
6. ==Cloud Watch== (monitoring).
For example some developer can create additional EBS for his machine. With Cloud Watch, you can notice this change and ask the developer for the reasons, why he created it.
7. ==Lambda== (serverless serice). It is a compute service that allows you to run code without provisioning or managing servers. For example you can configure lambda to send notifications to developer every time they create EBS, or you can automatically do some action on newly created services. 
8. ==Cloud Build service== : ==AWS CodeBuild==, ==AWS CodePipeline==, ==AWS CodeDeploy==
**AWS CodeBuild** is a fully managed build service that compiles source code, runs tests, and produces software packages that are ready for deployment. 

**AWS CodePipeline** is a continuous integration and continuous delivery service for fast and reliable application and infrastructure updates.

**AWS CodeDeploy** is a deployment service that automates the process of deploying applications to various compute services like EC2, Lambda, and on-premises servers.
(amazon cicd staff)

9. ==AWS config==
10. ==Billing and costing== (check how many money you or users spend)
11. ==AWS KMS== is a managed encryption service. It makes it easy to create and control the encryption keys used to secure your data.
12. ==Cloud Trail==. AWS CloudTrail is a service that enables you to monitor, log, and retain account activity related to actions taken on your AWS resources.
13. ==AWS EKS==(Elastic Kubernetes Service). 
14. ==AWS ECS== (Elastic Container Service). (also AWS Fargate is used for such purpose). It is simillar to AWS EKS, but it is not based on kubernetes
15. ==Amazon OpenSearch Service== is a managed service that simplifies the deployment, operation, and scaling of Elasticsearch clusters. Elasticsearch is a distributed search and analytics engine widely used for log analytics, full-text search, and real-time analytics.
---
# ==Day 14 |  Configuration Management With Ansible |Puppet vs Ansible

Before devops, there were a lot of servers used for development. To configure these servers, system administrators had to write shell scripts for different types of machines. That was inefficient. Later, when development moved to cloud platforms, the amount of servers significantly increased. To handle configuration, the Configuration Management concept was created. To handle Conf Management, such tools created:
1. Puppet
2. Chef
3. Ansible

But the most used is ==Ansible==!

The diffrence between Ansible and other CM tools:
![](../Images/Pasted%20image%2020240825173612.png)

- **Puppet**:
    
    - **Architecture**: Puppet uses a pull model where agents regularly check in with the Puppet Master to fetch configurations.
    - **Agent-Based**: Requires an agent to be installed on each managed node.
- **Ansible**:
    
    - **Architecture**: Ansible uses a push model where configurations are sent out from the control machine to the managed nodes.
    - **Agentless**: Does not require any agents on the managed nodes, simplifying setup and reducing overhead.

---
# ==Day 15 |  Ansible Zero to Hero


First we need to configure ansible to make him able to connect to machines(passwordless connection).
1. Use this command to have a connection to 54.93.165.98 machine:
`ssh-copy-id -f "-o IdentityFile $PATHTOPEMKEY" ubuntu@54.93.165.98`
2. I got this line ==Now try logging into the machine, with:   "ssh -o ' IdentityFile ./NewPairKeyBriez.pem' 'ubuntu@54.93.165.98'"
and check to make sure that only the key(s) you wanted were added==
Execute this command. And exit from the machine.
3. Now I am able to connect to this machine without any key file, jus using `ssh ubuntu@54.93.165.98`

First we need to create an inventory file to describe there IP addresses of machines.
![](../Images/Pasted%20image%2020240825202754.png)
To execute something more complicated, playbook files used. But if you want to do something very simple, we can just execute one ansible command called ad hoc command:
![](../Images/Pasted%20image%2020240825202944.png)
After that I am able to see `fileCreatedByAnsible` file on both machines.
To understand what is -m and what modules should I use, you can check official documentation. https://docs.ansible.com/ansible/2.9/modules/list_of_all_modules.html
Later you can check documentation and try it by yourself

Also I can group my machines in inventory file:
![](../Images/Pasted%20image%2020240825203707.png)

Now I can use group instead of all. For example
`ansible -i inventory develop -m "shell" -a "touch fileCreatedByAnsible2"`

==Using playbook==:
If I want for instance install nginx on both machines, I can write a playbook for this. So we need to create a .yml file. firstPlaybook.yml:

![](../Images/Pasted%20image%2020240825205539.png)
typo, instead of `root` use `true`

`ansible-playbook -i /home/ansible/inventory firstPlaybook.yml`

![](../Images/Pasted%20image%2020240825205958.png)

To do more complex playbooks, you can use the ansible role. For example:
![](../Images/Pasted%20image%2020240825210723.png)
Here we create kubernetes role. Using these folders we can structure our playbooks. More about it here: 
https://github.com/ansible/ansible-examples

---

#  ==Day-16 | Infrastructure as Code==

Sometimes devops enginers must write scripts for AWS or Azure or Google  cloud. And every time he needs to rewrite his previous scripts for another cloud platform. Sometimes it can be even both at the same time, for example organisation uses AWS and Azure both. Therefore Terraform was created.

The concept of Terraform is API as code.
![](../Images/Pasted%20image%2020240827170334.png)

As devops engineer, when you use terraform, You don't need to make a lot of work when you migrating from AWS to Azure. The changes are minimal. Terraform scripts have jmodules that are acceptable for different platforms. So instead fof using for example AWS or Azure cli scripts, we can just use Terraform scripts files.

What is API? It is Application Programming Interface. APIs define the methods and data structures that developers can use to interact with an application or service. For example, if you want your application to access data from a weather service, an API would provide the necessary functions to request and retrieve weather data.


Terraform use the same concept. When we write Terraform scripts, it translates it to the language that for example AWS API understand and communicate with it is API.

---
#  ==Day-17 |Everything about Terraform |Write Your First Project |Remote Backend |Modules |Interview Q&A==


To follow this tutorial you will need:

- The [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) (1.2.0+) installed.
- The [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed.
- [AWS account](https://aws.amazon.com/free) and [associated credentials](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html) that allow you to create resources.

Then I created new directory and new file there called main.tf.

==Random note==: To display both parameters with jq I can use such command:
![](../Images/Pasted%20image%2020240827184140.png)

To create a new EC2 Instance there is the syntax of the main.tf:
![](../Images/Pasted%20image%2020240827184408.png)Then I need to run `terraform init` to initialize what cloud provider and which versions the terraform should use. And then use `terraform plan`
![](../Images/Pasted%20image%2020240827184724.png)
![](../Images/Pasted%20image%2020240827184746.png)
`terraform plan` used to show what will be done before execution the script. If all is right, use `terraform apply`. New EC2 instance will be created.
Also read what else can be done in terraform aws documentation: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build

After that new file `terraform.tfstate` is created to track whjat was done with  terraform. It allows terraform to know what is your infrastructure. This allows you to change parameters of your created resource(for example change the imageType or add more CPU). Good practice is to store this file remotely

This is a good practice to have other files in your terraform repository. For example you can add outputs.tf and variables.tf. Variables described in variables.tf can be used in main script file(for example to not write them multiple times manually, just using a variable). Output used to show the user of this script importante information about his newly created instance(for example tell him publicId of newly created EC2 instance)

![](../Images/Pasted%20image%2020240827200806.png)

To add S3 backend remote state, first we need to create s3 backet and dynamo DB:
So write new main.tf file to execute this:
