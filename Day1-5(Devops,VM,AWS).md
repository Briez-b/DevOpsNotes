  
## ==Day 1 Fundamentals of DevOps==

#### 1.1 *What is DevOps?*

**DevOps** is a process of improving the application delivery by ensuring:
1. Automation
2. Quality
3. Continuous Monitoring
4. Continuous testing

#### 1.2 *Why DevOps*

The process before DevOps,
- Developer writes a code, check in the code and put it in central location. (Local to Centralized repo)
- System admin provides environment to deploy codes. (VM ware or open stack to create VMs on bare metal using hypervisor)
- Tester testes the application on server.
- Build & Release engineer deploy application on to the server. (pre-production & prod) 
Finally deliver the application to customers.

Multiple people involved and it is a manual process and delay in delivery.

To improve process of this delivery make it shorter and more automatized, DevOps used. 

#### 1.3 Introduce Yourself as a Devops Engineer
Properly say about your experience. Say what did you do before DevOps exp, take your time. Tell something about tools you used. 

---
## ==Day 2 Improve SDLC with DevOps==

**SDLC** - Software Development Lifecycle
Every Development cycle has these phases:
- Design
- Develop
- Testing


---
### ==Day 3 Virtual machines

When VM are not used, the resources used inefficiently. In this example we see that when there are 5 teams in the project(like example.com), they use 5 servers. In every server they use only 20 % of the resources. It sis very inefficiently. 

So, the Virtual Machines (VM) were created for such purpose. In such case we have only 1 server for all teams splitted to 5 parts by hypervisor.

 **Hypervisor**, also known as a **virtual machine monitor** (**VMM**) or **virtualizer**, is a type of computer [software](https://en.wikipedia.org/wiki/Software "Software"), [firmware](https://en.wikipedia.org/wiki/Firmware "Firmware") or [hardware](https://en.wikipedia.org/wiki/Computer_hardware "Computer hardware") that creates and runs [virtual machines](https://en.wikipedia.org/wiki/Virtual_machine "Virtual machine"). A computer on which a hypervisor runs one or more virtual machines is called a _host machine_, and each virtual machine is called a _guest machine_.
Examples: Virtiual box, VMWare

![](Images/Pasted%20image%2020240614021724.png)




---
### ==Day 4 AWS & Asure - How to create virtual machines

AWS (Amazon web services) - is a subsidiary of [Amazon](https://en.wikipedia.org/wiki/Amazon.com "Amazon.com") that provides [on-demand](https://en.wikipedia.org/wiki/Software_as_a_service "Software as a service") [cloud computing](https://en.wikipedia.org/wiki/Cloud_computing "Cloud computing") [platforms](https://en.wikipedia.org/wiki/Computing_platform "Computing platform") and [APIs](https://en.wikipedia.org/wiki/Application_programming_interface "Application programming interface") to individuals, companies, and governments, on a metered, pay-as-you-go basis.

**Microsoft Azure** is the [cloud computing](https://en.wikipedia.org/wiki/Cloud_computing "Cloud computing") platform developed by [Microsoft](https://en.wikipedia.org/wiki/Microsoft "Microsoft"). It offers management, access and development of applications and services to individuals, companies and governments through its global infrastructure.

EC2 - virtual machines in AWS.
VM - Virtual machines in microsoft azure



![](Images/Pasted%20image%2020240614021828.png)
![](Images/Pasted%20image%2020240614023117.png)

To automate the creation of VMs we can use scripts that interact with AWS API. To use scripts, several options exist:
- **AWS CLI** ( AWS Command Line Interface)
- Boto 3 module in Python to interact with AWS API (==not sure, read more==)
- **AWS CFT** (cloud formation templates). 
-  **Terraform** (we will talk about it later)
- **AWS CDK** (recently introduced)

![](Images/Pasted%20image%2020240614030107.png)


---
### ==Day 5 AWS CLI Full Guide | How to connect to EC2 Instance from UI & Terminal


Several ways to connect to VMs
### 1) Use AWS console. Just use connect button on AWS console(web page)
![](Images/Pasted%20image%2020240614030511.png)
### 2) Use terminal in your OS. For example use:   
	- **iTerm2** for macOs
    - **MobaXterm** for Windows

To connect use this Ip address:
![](Images/Pasted%20image%2020240614031231.png)




![](Images/Pasted%20image%2020240614033535.png)
If it says that the key is not private, use `chmod 600 file.pem`
==STOP and terminate the instance after using the EC2!==


### 3) Use AWS CLI (command line interface)
1) Download AWS CLI.
2) Configure AWS CLI
![](Images/Pasted%20image%2020240614045031.png)


Use the all the info from this page when execute `aws configure` :
![](Images/Pasted%20image%2020240614045257.png)
Now we can use different AWS services, for instance s3, with `aws` command. (s3 is some cloud storage service. You can read more about it later, if you want)

To find another commands use AWS CLI documentation (check later): 
https://docs.aws.amazon.com/cli/

### Running of EC2 instance through AWS CLI:
https://docs.aws.amazon.com/cli/v1/userguide/cli-services-ec2-instances.html ==read more later==

I checked the name for `--image-id`, generated `--key-name`, `--security-group-ids`(to create this, I also had to find the `--vpc-id`, ==read about it more later==)
![](Images/Pasted%20image%2020240614061031.png)


![](Images/Pasted%20image%2020240614061227.png)

The command I used is:

```
aws ec2 run-instances --image-id ami-01e444924a2233b07 --count 1 --instance-type t2.micro --key-name ebryyauKeyPair --security-group-ids sg-030778de8d7925ed7 --subnet-id subnet-0c66713f5f0876723
```

When I tried to connect, I received this:
![](Images/Pasted%20image%2020240614063555.png)
To resolve it, I changed the rule of security group with this procedure: 

*Ensure that your EC2 instance's security group allows inbound traffic on port 22 (SSH).*

- *Go to the [EC2 Dashboard](https://console.aws.amazon.com/ec2).*
- *Select "Instances" from the left-hand menu.*
- *Find your instance and note the "Security Groups".*
- *Click on the security group link.*
- *Check the "Inbound rules" to ensure there is a rule allowing SSH (port 22) from your IP address or a range of IP addresses.*


### 4) Using AWS cloudformation template

The link to github with example:
https://github.com/aws-cloudformation/aws-cloudformation-templates

![](Images/Pasted%20image%2020240614064400.png)

![](Images/Pasted%20image%2020240614065031.png)
### 5) Using scripts, for example boto 3 in python:
https://gist.github.com/mda590/679aba60ca03699d5b12a32314debdc0
![](Images/Pasted%20image%2020240614070118.png)
You can read about boto3 more in documentation!


---
