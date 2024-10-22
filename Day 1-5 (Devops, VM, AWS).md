  
---

## ==Day 1: Fundamentals of DevOps==

### 1.1 *What is DevOps?*

**DevOps** is a set of practices, cultural philosophies, and tools aimed at improving the collaboration between development and operations teams, automating the software delivery process, and ensuring rapid, reliable releases. The primary goals of DevOps include:

1. **Automation**: Automating repetitive tasks like testing, deployment, and monitoring to ensure speed and accuracy in the release process.
2. **Quality**: Ensuring that code quality is maintained throughout the development cycle by integrating testing and feedback mechanisms.
3. **Continuous Monitoring**: Monitoring the application and infrastructure in real time to ensure stability and performance. This allows quick detection and resolution of issues.
4. **Continuous Testing**: Automated testing that runs throughout the development process to catch bugs early, improve code quality, and speed up delivery.

**DevOps tools** include Git for version control, Jenkins for continuous integration (CI), Docker for containerization, Kubernetes for orchestration, Terraform for infrastructure as code (IaC), and monitoring tools like Prometheus and Grafana.

### 1.2 *Why DevOps?*

Before DevOps, the traditional software development process looked like this:
- **Developers** wrote code and committed it to a centralized repository (e.g., SVN, Git).
- **System administrators** provided the infrastructure (such as VMs on VMware or OpenStack) to deploy and test the application.
- **Testers** tested the application on these servers, often leading to delays as they would wait for environments to be provisioned.
- **Build and release engineers** deployed the application manually to pre-production and production environments.
  
This traditional process was slow, with **manual handoffs** between teams, leading to delays, errors, and miscommunications. It lacked the speed, collaboration, and automation that modern businesses require to release software quickly and reliably.

**DevOps** was introduced to address these challenges by:
- Streamlining the **workflow** between developers, testers, and operations teams.
- Introducing **automation** for repetitive tasks like testing, deployment, and monitoring.
- Ensuring **faster feedback loops** through continuous integration and continuous deployment (CI/CD).
- Reducing manual intervention and minimizing human error.
  
The result is a **shortened software development lifecycle (SDLC)**, improved **efficiency**, and **faster delivery** of reliable applications to customers.

### 1.3 *How to Introduce Yourself as a DevOps Engineer*

When introducing yourself as a DevOps engineer, focus on these key points:
- **Background**: Briefly talk about your previous experience, highlighting your transition into DevOps. Mention any relevant prior roles (e.g., developer, system admin, or tester) and how they contribute to your DevOps knowledge.
- **Tools**: Share the tools you've worked with (e.g., Jenkins, Docker, Kubernetes, Terraform, Git). Emphasize your hands-on experience with CI/CD, container orchestration, and infrastructure as code.
- **Processes**: Mention any specific DevOps processes you’ve implemented, such as automating deployment pipelines, infrastructure management, or monitoring systems.
- **Impact**: Highlight the improvements you made, such as reducing deployment times, improving application reliability, or enhancing team collaboration.

---

## ==Day 2: Improve SDLC with DevOps==

### 2.1 *What is SDLC?*

The **Software Development Lifecycle (SDLC)** is a structured process that developers follow when building software. It defines the various stages of software development to ensure that the application meets business needs and customer expectations.

The traditional SDLC phases are:
1. **Design**: Planning and designing the system architecture, components, and interactions. This phase lays the foundation for the rest of the development cycle.
2. **Development**: Writing the actual code that implements the design. This is where developers build features and functionality.
3. **Testing**: Ensuring the code works as expected, identifying and fixing bugs. This phase involves functional, performance, and security testing.

### 2.2 *How DevOps Improves SDLC*

**DevOps** improves the SDLC by integrating development and operations processes, ensuring faster and more reliable delivery. Key improvements include:

1. **Continuous Integration (CI)**:
   - **What it is**: CI is the practice of frequently integrating code changes into a shared repository, triggering automated builds and tests.
   - **How it helps**: It allows developers to detect integration issues early, reducing bugs and speeding up development.

2. **Continuous Deployment (CD)**:
   - **What it is**: CD automates the deployment process, pushing code to production as soon as it passes all stages of testing.
   - **How it helps**: It ensures that the latest code can be reliably and quickly deployed to production, reducing downtime and accelerating release cycles.

3. **Automation**:
   - **What it is**: Automation tools (e.g., Jenkins, Ansible) handle tasks such as testing, provisioning infrastructure, and deploying applications.
   - **How it helps**: Automation reduces human error, speeds up repetitive tasks, and frees up engineers to focus on more complex work.

4. **Infrastructure as Code (IaC)**:
   - **What it is**: Tools like Terraform and Ansible allow you to define infrastructure (servers, networks, etc.) in code, making it version-controlled and repeatable.
   - **How it helps**: IaC improves consistency, scalability, and disaster recovery, enabling fast and consistent environment provisioning.

5. **Monitoring and Feedback**:
   - **What it is**: Tools like Prometheus, Grafana, and ELK stack monitor applications and infrastructure for performance and reliability.
   - **How it helps**: Real-time monitoring enables teams to detect issues early and resolve them quickly, ensuring a stable user experience.

### 2.3 *Benefits of DevOps for SDLC*:
- **Faster Time to Market**: Automation, CI/CD, and streamlined workflows help teams deliver software faster.
- **Improved Collaboration**: DevOps breaks down silos between development, testing, and operations teams, fostering better communication and cooperation.
- **Higher Quality**: Continuous testing and monitoring ensure bugs are caught early, leading to more stable releases.
- **Better Scalability**: Infrastructure as code and containerization (e.g., Docker, Kubernetes) make it easier to scale applications dynamically based on demand.


---
### ==Day 3 Virtual machines==

When VM are not used, the resources used inefficiently. In this example we see that when there are 5 teams in the project(like example.com), they use 5 servers. In every server they use only 20 % of the resources. It sis very inefficiently. 

So, the Virtual Machines (VM) were created for such purpose. In such case we have only 1 server for all teams splitted to 5 parts by hypervisor.

 **Hypervisor**, also known as a **virtual machine monitor** (**VMM**) or **virtualizer**, is a type of computer [software](https://en.wikipedia.org/wiki/Software "Software"), [firmware](https://en.wikipedia.org/wiki/Firmware "Firmware") or [hardware](https://en.wikipedia.org/wiki/Computer_hardware "Computer hardware") that creates and runs [virtual machines](https://en.wikipedia.org/wiki/Virtual_machine "Virtual machine"). A computer on which a hypervisor runs one or more virtual machines is called a _host machine_, and each virtual machine is called a _guest machine_.
Examples: Virtiual box, VMWare

![](Attachments/Pasted%20image%2020240614021724.png)




---
### ==Day 4 AWS & Asure - How to create virtual machines==

AWS (Amazon web services) - is a subsidiary of [Amazon](https://en.wikipedia.org/wiki/Amazon.com "Amazon.com") that provides [on-demand](https://en.wikipedia.org/wiki/Software_as_a_service "Software as a service") [cloud computing](https://en.wikipedia.org/wiki/Cloud_computing "Cloud computing") [platforms](https://en.wikipedia.org/wiki/Computing_platform "Computing platform") and [APIs](https://en.wikipedia.org/wiki/Application_programming_interface "Application programming interface") to individuals, companies, and governments, on a metered, pay-as-you-go basis.

**Microsoft Azure** is the [cloud computing](https://en.wikipedia.org/wiki/Cloud_computing "Cloud computing") platform developed by [Microsoft](https://en.wikipedia.org/wiki/Microsoft "Microsoft"). It offers management, access and development of applications and services to individuals, companies and governments through its global infrastructure.

EC2 - virtual machines in AWS.
VM - Virtual machines in microsoft azure



![](Attachments/Pasted%20image%2020240614021828.png)
![](Attachments/Pasted%20image%2020240614023117.png)

To automate the creation of VMs we can use scripts that interact with AWS API. To use scripts, several options exist:
- **AWS CLI** ( AWS Command Line Interface)
- Boto 3 module in Python to interact with AWS API (==not sure, read more==)
- **AWS CFT** (cloud formation templates). 
-  **Terraform** (we will talk about it later)
- **AWS CDK** (recently introduced)

![](Attachments/Pasted%20image%2020240614030107.png)


---
### ==Day 5 AWS CLI Full Guide | How to connect to EC2 Instance from UI & Terminal==


Several ways to connect to VMs
### 1) Use AWS console. Just use connect button on AWS console(web page)
![](Attachments/Pasted%20image%2020240614030511.png)
### 2) Use terminal in your OS. For example use:   
	- **iTerm2** for macOs
    - **MobaXterm** for Windows

To connect use this Ip address:
![](Attachments/Pasted%20image%2020240614031231.png)




![](Attachments/Pasted%20image%2020240614033535.png)
If it says that the key is not private, use `chmod 600 file.pem`
==STOP and terminate the instance after using the EC2!==


### 3) Use AWS CLI (command line interface)
1) Download AWS CLI.
2) Configure AWS CLI
![](Attachments/Pasted%20image%2020240614045031.png)


Use the all the info from this page when execute `aws configure` :
![](Attachments/Pasted%20image%2020240614045257.png)
Now we can use different AWS services, for instance s3, with `aws` command. (s3 is some cloud storage service. You can read more about it later, if you want)

To find another commands use AWS CLI documentation (check later): 
https://docs.aws.amazon.com/cli/

### Running of EC2 instance through AWS CLI:
https://docs.aws.amazon.com/cli/v1/userguide/cli-services-ec2-instances.html ==read more later==

I checked the name for `--image-id`, generated `--key-name`, `--security-group-ids`(to create this, I also had to find the `--vpc-id`, ==read about it more later==)
![](Attachments/Pasted%20image%2020240614061031.png)


![](Attachments/Pasted%20image%2020240614061227.png)

The command I used is:

```
aws ec2 run-instances --image-id ami-01e444924a2233b07 --count 1 --instance-type t2.micro --key-name ebryyauKeyPair --security-group-ids sg-030778de8d7925ed7 --subnet-id subnet-0c66713f5f0876723
```

When I tried to connect, I received this:
![](Attachments/Pasted%20image%2020240614063555.png)
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

![](Attachments/Pasted%20image%2020240614064400.png)

![](Attachments/Pasted%20image%2020240614065031.png)
### 5) Using scripts, for example boto 3 in python:
https://gist.github.com/mda590/679aba60ca03699d5b12a32314debdc0
![](Attachments/Pasted%20image%2020240614070118.png)
You can read about boto3 more in documentation!


---
