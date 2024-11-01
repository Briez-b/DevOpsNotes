
This is a project I am gonna implement:

![](../Attachments/Pasted%20image%2020241029183637.png)

The structure for my project:

``` r
terraform-project/
├── main.tf                  # Main configuration file
├── variables.tf             # Input variables for the project
├── outputs.tf               # Outputs from the project
├── terraform.tfvars         # Values for the input variables
├── provider.tf              # Provider configurations (e.g., AWS, Azure, etc.)
├── versions.tf              # Version constraints for Terraform and providers
├── backend.tf               # Configuration for the remote backend (e.g., S3, GCS)
├── modules/                 # Custom modules directory
│   ├── vpc/                 # Module example for VPC
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   └── ec2/                 # Module example for EC2
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
├── envs/                    # Environments directory
│   ├── dev/                 # Development environment
│   │   ├── main.tfvars
│   │   ├── backend.tfvars
│   └── prod/                # Production environment
│       ├── main.tfvars
│       ├── backend.tfvars
├── scripts/                 # Bash or other scripts for automation tasks
│   └── init.sh              # Script to initialize Terraform or run pre-tasks
└── README.md                # Documentation of the project

### Description of Each File and Directory

- **`main.tf`**: The primary configuration file where core resources are defined, such as compute instances, networking, etc.
- **`variables.tf`**: Stores definitions of input variables, allowing easy customization for different environments.
- **`outputs.tf`**: Defines outputs that you might want to see after the deployment, like instance IPs, VPC IDs, etc.
- **`terraform.tfvars`**: Holds values for the input variables. Typically, it’s where sensitive or environment-specific values are set.
- **`provider.tf`**: Defines provider configurations, like AWS or GCP, allowing Terraform to manage resources in those platforms.
- **`versions.tf`**: Specifies version requirements for Terraform and provider plugins.
- **`backend.tf`**: Configures remote backends to store Terraform state files, such as an S3 bucket in AWS.
- **`modules/`**: A directory containing reusable modules that encapsulate specific resources, such as VPC, EC2, or database configurations.
    - **`vpc/`** and **`ec2/`**: Examples of subdirectories that contain modularized configurations.
- **`envs/`**: Environment-specific directories with unique configurations for different environments, like development (`dev`) and production (`prod`).
    - **`main.tfvars`**: Environment-specific variable values, separate from the `terraform.tfvars` file for better isolation.
    - **`backend.tfvars`**: Environment-specific backend configurations, helpful for storing unique state files per environment.
- **`scripts/`**: Any additional scripts for automation, provisioning, or initialization tasks.
- **`README.md`**: Project documentation, useful for describing the purpose, structure, and setup instructions.

```

First I will create all resources in the main.tf file:

1) Define providers in providers.tf file:

![](../Attachments/Pasted%20image%2020241030173927.png)

2) Create VPC and 4 Subnets (2 public, 2 private).

![](../Attachments/Pasted%20image%2020241030174043.png)

3) Create internet gateway and route table associated with these resources:

![](../Attachments/Pasted%20image%2020241030174213.png)

4) Create security group

![](../Attachments/Pasted%20image%2020241029230512.png)


5) Create load balancer, target group. 

![](../Attachments/Pasted%20image%2020241030174304.png)

7) Define launch template and auto scaling group.

![](../Attachments/Pasted%20image%2020241030174339.png)

![](../Attachments/Pasted%20image%2020241030174404.png)


8) Define backend: define the s3 bucket and dynamodb

![](../Attachments/Pasted%20image%2020241030110109.png)

![](../Attachments/Pasted%20image%2020241030110129.png)

9) Execute `terraform plan` and `terraform apply`

![](../Attachments/Pasted%20image%2020241030111025.png)

11) My app accessible with load balancer dns:

![](../Attachments/Pasted%20image%2020241030173151.png)

![](../Attachments/Pasted%20image%2020241030173325.png)

>[!info] Note
>Firstly my app didn't work as I forgot to add NAT gateways. Therefore I couldn't connect to my app as the bash script wasn't executed correctly because of the lack of the internet.
>So I added a NAT gateway.
## Next I will move some parts of the code to modules and add variables:

1) Created variables for my project

![](../Attachments/Pasted%20image%2020241101170011.png)

2) Let's modulize this code
I will use such structure:

![](../Attachments/Pasted%20image%2020241101173924.png)

3) Create VPC module

![](../Attachments/Pasted%20image%2020241101195250.png)
![](../Attachments/Pasted%20image%2020241101195305.png)
![](../Attachments/Pasted%20image%2020241101195318.png)
![](../Attachments/Pasted%20image%2020241101195331.png)


4) Create security group module
![](../Attachments/Pasted%20image%2020241101195424.png)
![](../Attachments/Pasted%20image%2020241101195450.png)

![](../Attachments/Pasted%20image%2020241101195504.png)


5) Create app load balancer module

![](../Attachments/Pasted%20image%2020241101195708.png)
![](../Attachments/Pasted%20image%2020241101195719.png)
![](../Attachments/Pasted%20image%2020241101195733.png)

6) Create auto scaling module

![](../Attachments/Pasted%20image%2020241101195825.png)
![](../Attachments/Pasted%20image%2020241101195846.png)

7) And now My main script looks like this

![](../Attachments/Pasted%20image%2020241101195918.png)
As variables I used module outputs and variables defined in the root (variables.tf and terraform.tfvars):
![](../Attachments/Pasted%20image%2020241101200023.png)

My application works.