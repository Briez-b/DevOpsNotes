
Sometimes devops engineer must write scripts for AWS or Azure or Google  cloud. And every time he needs to rewrite his previous scripts for another cloud platform. Sometimes it can be even both at the same time, for example organisation uses AWS and Azure both. Therefore Terraform was created.

The concept of Terraform is API as code.
![](Attachments/Pasted%20image%2020240827170334.png)

As devops engineer, when you use terraform, You don't need to make a lot of work when you migrating from AWS to Azure. The changes are minimal. Terraform scripts have modules that are acceptable for different platforms. So instead of using for example AWS or Azure cli scripts, we can just use Terraform scripts.

What is API? It is Application Programming Interface. APIs define the methods and data structures that developers can use to interact with an application or service. For example, if you want your application to access data from a weather service, an API would provide the necessary functions to request and retrieve weather data.


Terraform use the same concept. When we write Terraform scripts, it translates it to the language that for example AWS API understand and communicate with it is API.

#  Day-17 - Everything about Terraform. Write Your First Project. Remote Backend. Modules. Interview Q&A


To follow this tutorial you will need:

- The [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) (1.2.0+) installed.
- The [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed.
- [AWS account](https://aws.amazon.com/free) and [associated credentials](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html) that allow you to create resources.

Then I created new directory and new file there called main.tf.

==Random note==: To display both parameters with jq I can use such command:
![](Attachments/Pasted%20image%2020240827184140.png)

To create a new EC2 Instance there is the syntax of the main.tf:

![](Attachments/Pasted%20image%2020240827184408.png)

Then I need to run `terraform init` to initialize what cloud provider and which versions of terraform should use. And then use `terraform plan`
![](Attachments/Pasted%20image%2020240827184724.png)

![](Attachments/Pasted%20image%2020240827184746.png)
`terraform plan` used to show what will be done before execution the script. If all is right, use `terraform apply`. New EC2 instance will be created.
Also read what else can be done in terraform aws documentation: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build

After that new file `terraform.tfstate` is created to track what was done with  terraform. It allows terraform to know what is your infrastructure. This allows you to change parameters of your created resource(for example change the imageType or add more CPU). Good practice is to store this file remotely

This is a good practice to have other files in your terraform repository. For example you can add outputs.tf and variables.tf. Variables described in variables.tf can be used in main script file(for example to not write them multiple times manually, just using a variable). Output used to show the user of this script importante information about his newly created instance(for example tell him publicId of newly created EC2 instance)

![](Attachments/Pasted%20image%2020240827200806.png)

To add S3 backend remote state, first we need to create s3 backet and dynamo DB:
So write new main.tf file to execute this:
!!!!! Add this later