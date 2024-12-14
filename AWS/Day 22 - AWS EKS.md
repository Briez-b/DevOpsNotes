
# PRACTICE

I am going to expose application using EKS cluster

1) Create EKS cluster. For this install `kubectl` and `eksctl`. (I did it before). Also some policies should be attached to IAM user, but I just used administrator user.

I will use serverless compute (fargate).

![](../Attachments/Pasted%20image%2020241212180103.png)

![](../Attachments/Pasted%20image%2020241212180119.png)


2) Add context to kubectl

![](../Attachments/Pasted%20image%2020241212181202.png)


3) Create fargate profile to add one more namespace for our app (without new profiel we can't add new resources to other namespaces, only to default namespace)

![](../Attachments/Pasted%20image%2020241213162804.png)

![](../Attachments/Pasted%20image%2020241213162745.png)

Now I can add new resources to game-2048 namespace

4) Add the resource with our app by applying .yaml file

![](../Attachments/Pasted%20image%2020241213170219.png)

![](../Attachments/Pasted%20image%2020241213170258.png)


5) Now we need to add ingress controller to cluster. For that first we need to add oidc provider.

![](../Attachments/Pasted%20image%2020241213171002.png)

And add alb controller.
For that we have to add new policy (taken from official alb documentation): https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html

![](../Attachments/Pasted%20image%2020241213171828.png)
And error occurred because I already had it (i did it during observability practice).

Also create a service account that will be attached to Load balancer controller.

![](../Attachments/Pasted%20image%2020241213172330.png)

And install ELB controller using helm.

![](../Attachments/Pasted%20image%2020241213172908.png)

![](../Attachments/Pasted%20image%2020241213173243.png)

And now we can see that load balancer created in console:

![](../Attachments/Pasted%20image%2020241213173657.png)


==Important==. Application load balancer didn't connect to ingress for some reason. So I troubleshooted it:

Firstly checked what is the reason for ingress to not work:

![](../Attachments/Pasted%20image%2020241213190248.png)

It seems the policy and the role I created before don't have some premission. I found this ticket in github:

![](../Attachments/Pasted%20image%2020241213190353.png)

It seems with some update load balancer wants some additional permission. And the policy file I downloaded from documentation is outdated. 

So I updated .json policy file: added 2 new permissions:

![](../Attachments/Pasted%20image%2020241213190659.png)
![](../Attachments/Pasted%20image%2020241213190717.png)

And redone all the steps. 

And now application works:

![](../Attachments/Pasted%20image%2020241213190829.png)


