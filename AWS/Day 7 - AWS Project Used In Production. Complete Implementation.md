
https://docs.aws.amazon.com/vpc/latest/userguide/vpc-example-private-subnets-nat.html



![](../Attachments/Pasted%20image%2020241022150345.png)
![](../Attachments/Pasted%20image%2020241022150312.png)
![](../Attachments/Pasted%20image%2020241022150452.png)


# PRACTICE

1) Create VPC

![](../Attachments/Pasted%20image%2020241022152444.png)
![](../Attachments/Pasted%20image%2020241022153833.png)
2) Create EC2 instances (by creating auto scaling group)
First we need to create launch template for EC2 instances:
![](../Attachments/Pasted%20image%2020241022155132.png)
![](../Attachments/Pasted%20image%2020241022155148.png)

![](../Attachments/Pasted%20image%2020241022155210.png)
![](../Attachments/Pasted%20image%2020241022155348.png)
And use this template for auto scaling group:
![](../Attachments/Pasted%20image%2020241022155616.png)
![](../Attachments/Pasted%20image%2020241022155724.png)
![](../Attachments/Pasted%20image%2020241022160101.png)
Now my instances running in 2 private subnets. They don't have any public IP
3) Create new EC2 instance (bastion host machine) in public subnet. It It is needed to be able to connect to our private machines.
Copy a .pem key to this machine to use it later to connect to Private EC2 instances:
![](../Attachments/Pasted%20image%2020241022162109.png)


4) Run very basic Python app in private EC2 instances:
![](../Attachments/Pasted%20image%2020241022164133.png)

5) Create Load Balancer.

![](../Attachments/Pasted%20image%2020241022164345.png)
![](../Attachments/Pasted%20image%2020241022164745.png)
![](../Attachments/Pasted%20image%2020241022164814.png)
Here I need to create target group:
![](../Attachments/Pasted%20image%2020241022165420.png)
![](../Attachments/Pasted%20image%2020241022165442.png)
Note: And press "Include as pending bellow" button. 
Let's continue with creating load balancer:
![](../Attachments/Pasted%20image%2020241022170229.png)

![](../Attachments/Pasted%20image%2020241022170253.png)
And http traffic to security group:
![](../Attachments/Pasted%20image%2020241022170544.png)

6) Now my app accessible:
![](../Attachments/Pasted%20image%2020241022170704.png)
7) Link yhis dns to my domain in route53:
![](../Attachments/Pasted%20image%2020241022171231.png)

Now it is accessible with my domain.