With AWS CFT we can create resources on AWS. It is IaC tool as terraform, but only for AWS.
To create CFT I can use **Json** or **Yaml**.

Let's talk about Iac. Iac tools should be **declaritive** and **versioned** in nature. What does that mean? 
**Versioned** means you can versioned the code, place it to s3 bucket or git repository and have a different versions of the code.
**Declaritive** means what you see is what you have. It means we defining in the script what we want the infrastracture to look like, rather than describing _how_ to achieve that state.

One of the great functions of CFT is **Drift detection**. With this function we can notice(just press drift detection button in console) what was changed in our infrastructure and take some action immediately. 
There is a basic structure for template:

``` yaml

AWSTemplateFormatVersion: "2010-09-09"  # Template version date

Description: >
  This template creates an EC2 instance within a specified VPC and subnet, along with a security group.

Metadata:  # Additional metadata about the template
  License: Apache-2.0
  Version: "1.0"
  Author: "Your Name"

Parameters:  # Define parameters that users can input
  VPCId:
    Type: AWS::EC2::VPC::Id
    Description: "The VPC ID to launch the instance in."
  SubnetId:
    Type: AWS::EC2::Subnet::Id
    Description: "The Subnet ID within the specified VPC."
  InstanceType:
    Type: String
    Description: "The EC2 instance type"
    Default: "t2.micro"
    AllowedValues: [ "t2.micro", "t2.small", "t3.micro", "t3.small" ]
  KeyName:
    Type: AWS::EC2::KeyPair::KeyName
    Description: "The name of the EC2 KeyPair to enable SSH access."

Rules:  # Set validation rules based on parameters
  CheckInstanceType:
    Assertions:
      - Assert:
          Fn::Contains:
            - [ "t2.micro", "t2.small", "t3.micro", "t3.small" ]
            - !Ref InstanceType
        AssertDescription: "InstanceType must be one of the allowed types."

Mappings:  # Define mappings for region-specific or other static values
  RegionMap:
    us-east-1:
      AMI: "ami-0ff8a91507f77f867"
    us-west-2:
      AMI: "ami-0bdb828fd58c52235"

Conditions:  # Set conditions to control resource creation based on input
  IsMicroInstance: !Equals [ !Ref InstanceType, "t2.micro" ]

Transform:  # Include macros or transforms, such as AWS::Include or AWS::Serverless-2016-10-31
  - AWS::Include
  - Location: "s3://mybucket/mytemplate.json"

Resources:  # Define AWS resources for the stack
  MyInstance:
    Type: "AWS::EC2::Instance"
    Condition: IsMicroInstance
    Properties:
      InstanceType: !Ref "InstanceType"
      ImageId: !FindInMap [ RegionMap, !Ref "AWS::Region", "AMI" ]
      KeyName: !Ref "KeyName"
      SubnetId: !Ref "SubnetId"
      SecurityGroupIds:
        - !Ref "InstanceSecurityGroup"

  InstanceSecurityGroup:
    Type: "AWS::EC2::SecurityGroup"
    Properties:
      GroupDescription: "Allow SSH access"
      VpcId: !Ref "VPCId"
      SecurityGroupIngress:
        - IpProtocol: "tcp"
          FromPort: "22"
          ToPort: "22"
          CidrIp: "0.0.0.0/0"

Outputs:  # Define outputs to access after stack creation
  InstanceId:
    Description: "The Instance ID of the EC2 instance"
    Value: !Ref "MyInstance"
    Export:
      Name: "InstanceId"

  InstancePublicIP:
    Description: "Public IP of the created EC2 instance"
    Value: !GetAtt MyInstance.PublicIp


```

# PRACTICE

To write templates you can use official documentation. It is very well written and you can find there many examples.
https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html

The example of the EC2 instance creation:

``` YAML
AWSTemplateFormatVersion: 2010-09-09
Description: A sample CloudFormation template with YAML comments.
# Resources section
Resources:
  MyEC2Instance: 
    Type: AWS::EC2::Instance
    Properties: 
      # Linux AMI
      ImageId: ami-1234567890abcdef0 
      InstanceType: t2.micro
      KeyName: MyKey
      BlockDeviceMappings:
        - DeviceName: /dev/sdm
          Ebs:
            VolumeType: io1
            Iops: 200
            DeleteOnTermination: false
            VolumeSize: 20
```

### LEt's create some templates.

To create template and execute go to CloudFormation service and create stack. There are several oprions:

![](../Attachments/Pasted%20image%2020241107123933.png)

For example I can choose "Build from infrastructure Composer"

![](../Attachments/Pasted%20image%2020241107125409.png)

![](../Attachments/Pasted%20image%2020241107125448.png)

If I want to add some properties, I can check what they can be in the sample template page for example. Everything can be found there or with chat gpt:

![](../Attachments/Pasted%20image%2020241107125634.png)

So I added a bucket name to the s3 config:
![](../Attachments/Pasted%20image%2020241107125950.png)

![](../Attachments/Pasted%20image%2020241107130050.png)
![](../Attachments/Pasted%20image%2020241107130201.png)
And submit

![](../Attachments/Pasted%20image%2020241107130324.png)

![](../Attachments/Pasted%20image%2020241107130408.png)

Bucket created, and one additional bucket also created to store all templates.
![](../Attachments/Pasted%20image%2020241107130510.png)

I deleted the bucket manually. Now I can use the drift option to see this change in CFT

![](../Attachments/Pasted%20image%2020241107130818.png)
Now I can see that the resource was deleted:
![](../Attachments/Pasted%20image%2020241107131013.png)

Create the stack again, but enable Versioning.
![](../Attachments/Pasted%20image%2020241107132009.png)

If I disable it manually, with drift detection I can see this change and understand what exactly was changed.
![](../Attachments/Pasted%20image%2020241107132251.png)
![](../Attachments/Pasted%20image%2020241107132316.png)

### I created a template with simple EC2 instance

![](../Attachments/Pasted%20image%2020241107135919.png)

![](../Attachments/Pasted%20image%2020241107135952.png)
