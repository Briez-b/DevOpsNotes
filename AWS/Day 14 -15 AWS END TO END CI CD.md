
Let's implement this CICD:

![](../Attachments/Pasted%20image%2020241108003627.png)



# First let's create CI part.

Instead of CodeCommit I will be using github repository. 

### 1) Create a github repository with the application code.

![](../Attachments/Pasted%20image%2020241108024426.png)
![](../Attachments/Pasted%20image%2020241108024442.png)


### 2) Create a **Code Build** project

![](../Attachments/Pasted%20image%2020241108025100.png)

Connect github account to aws and use it as source

![](../Attachments/Pasted%20image%2020241108025613.png)
![](../Attachments/Pasted%20image%2020241108030308.png)

Choose the environment where the code will be built. It can be custom or managed image.

![](../Attachments/Pasted%20image%2020241108032633.png)

And finally write buildspec file. It is something similar to Jenkinsfile. I can use the file from repository, or I can just write it right there.  

The draft version(need to add variables for docker credentials)
![](../Attachments/Pasted%20image%2020241108093818.png)

And create build project.

![](../Attachments/Pasted%20image%2020241108094107.png)

Now store parameter in AWS Systems Manager (something like secrets) using parameter store

![](../Attachments/Pasted%20image%2020241109032212.png)
![](../Attachments/Pasted%20image%2020241109032408.png)
![](../Attachments/Pasted%20image%2020241109032602.png)

Now I can use these parameters in spec file, but before add SSM policy to Service role

![](../Attachments/Pasted%20image%2020241109041008.png)

Had some problems with few commands and docker url, but after troubleshooting all works fine. The final **buildspec.yml**

![](../Attachments/Pasted%20image%2020241109045451.png)

![](../Attachments/Pasted%20image%2020241109045513.png)

![](../Attachments/Pasted%20image%2020241109045620.png)

**CI part almost completed**.

### 3) Now add AWS CodePipeline service.

Create pipeline service:
![](../Attachments/Pasted%20image%2020241109050316.png)
![](../Attachments/Pasted%20image%2020241109050459.png)

And add main brunch to "include" section in "Trigger"

![](../Attachments/Pasted%20image%2020241109050553.png)
Ans skip deployment stage for now
![](../Attachments/Pasted%20image%2020241109050624.png)

And now build executed everytime there is a change in github repository

![](../Attachments/Pasted%20image%2020241109051237.png)

---

# Now let's add CD part.

### 1) Create application in CodeDeploy service

![](../Attachments/Pasted%20image%2020241110152741.png)

### 2) Create EC2 instance and install there CodeDeploy agent using documentation (https://docs.aws.amazon.com/codedeploy/latest/userguide/codedeploy-agent-operations-install-ubuntu.html).

``` shell
sudo apt update
sudo apt install ruby-full]
wget https://aws-codedeploy-eu-central-1.s3.eu-central-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
```
![](../Attachments/Pasted%20image%2020241110162449.png)

And give the permission for ec2-instance to the CodeDeploy service (Create a role and assign policy)

![](../Attachments/Pasted%20image%2020241110174917.png)
![](../Attachments/Pasted%20image%2020241110174941.png)


And assign this role to ec2 instance.

![](../Attachments/Pasted%20image%2020241110175045.png)
and restart agent process in ec2-instance (`sudo systemctl restart codedeploy-agent`)

### 3) Configure CodeDeploy

Attach deployment group to created application:
![](../Attachments/Pasted%20image%2020241110180640.png)

![](../Attachments/Pasted%20image%2020241110180942.png)


**Now define how and what exactly the CodeDeploy should deploy.

Create deployment for this app. We create it to test that deployment files in repository work fine (later we add Deployment stage to CodePipeline), so this deployment will not be needed, CodeDeplot will be triggered automatically.

![](../Attachments/Pasted%20image%2020241111155912.png)

And add **addspec.yml** to repository (this file define the deployment)
![](../Attachments/Pasted%20image%2020241111162559.png)
![](../Attachments/Pasted%20image%2020241111162608.png)
![](../Attachments/Pasted%20image%2020241111162616.png)
**Mistake, the file should be ==appspec.yml==**

Now recreate the deployment to deploy based on the commit (for now I use commit to only test of it works)
The deployment failed because there is no docker on agent machine. 

![](../Attachments/Pasted%20image%2020241111164742.png)

I installed docker, but again it fails. If ps -q is empty (there is no container runing), it doesn't work

![](../Attachments/Pasted%20image%2020241111165232.png)

Fixed it:

![](../Attachments/Pasted%20image%2020241111165814.png)

For some reasons it doesn't see changes in script. So recreated app and deployment and fixed buildspec (to push latest tag)

![](../Attachments/Pasted%20image%2020241111174141.png)

And it works:

![](../Attachments/Pasted%20image%2020241111174300.png)

### 4) And add CodeDeploy service to our CodePipeline

![](../Attachments/Pasted%20image%2020241111175104.png)

![](../Attachments/Pasted%20image%2020241111175341.png)

![](../Attachments/Pasted%20image%2020241111175304.png)
Note: change BuildArtifact to SourceArtifact. 

And finally I updated the app and pushed it to GitHub. But still got an error. 

![](../Attachments/Pasted%20image%2020241111182411.png)

Added s3 policy to Ec2 IAM role

![](../Attachments/Pasted%20image%2020241111182615.png)

And now it works:

![](../Attachments/Pasted%20image%2020241111182735.png)

![](../Attachments/Pasted%20image%2020241111183308.png)

# NOW CI/CD works every time I push new commit.