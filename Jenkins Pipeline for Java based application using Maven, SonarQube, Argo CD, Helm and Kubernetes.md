
This is one of the complete CI/CD setup used in real life (or something similar).

![](Attachments/Pasted%20image%2020241011084321.png)

# Let's try to understand every component of this setup

#### 1) **(Source Code)**. We have a git repository with our code that should be tested and deployed. The code is some Java application.
#### 2) **(JENKINS)**. He is connected to the git repository and whenever pull-request triggered (it can be configured on different action), JENKINS pipeline will be triggered. 


>[!info] In Jenkins, there are two main types of pipelines for automating CI/CD processes.
>The **Declarative Pipelines** are a more structured and simplified way of writing Jenkins pipelines. It is the recommended approach for new Jenkins users and for those who want an easy-to-read and maintainable syntax.
>
>The **Scripted Pipeline** is a more flexible and powerful type of pipeline, but it is also more complex and harder to maintain compared to declarative pipelines. It uses the full power of the Groovy programming language to define the pipeline logic.

How Jenkins notice the changes in the repositories? One of the way is using **Webhook**. We can setup it in gitHub settings, and whenever any certain action triggered in repository, it will notify Jenkins.
We specify what set of actions should be done with code by writing Jenkins pipeline (Jenkinsfile). This **set of actions** usually include:

- **(MAVEN)**. Building the source code. In this case Maven used to build Java code. If build **failed**, we stop CI/CD process and notify user about it using email. If build **successful**, we go to next step in pipeline.
- **(SonarQube).** We do the code quality check using such tools like SonarQube. It performs static code analysis to detect bugs, code smells, security vulnerabilities, and potential technical debt.  
- **(TESTS)**. Run  tests. Usually we have some tests written for our applicatiom. It can be unit tests, system tests and so on. 
- We create new Docker image with this application and push it to Docker hub to use it later in CD process.
#### 3) **(Image updater)**. It continuously monitor container image registry (Docker hub in our case) and whenever new image pushed there, it updates Manifests Repo deployments manifests files (put there a new image).

>[!info] We can also use some bash/ansible/python script instead of Image updater.
#### 4) **(Manifests Repo)**. We have another Git repository with manifest yaml files to deploy our application. 
#### 5) **(ARGO CD)**. It continuously watches Manifest Repo and whenever new changes is there, it takes .yaml manifests and use it to deploy application to our kubernetes cluster.
>[!info] ARGO CD and Argo image updater are ones of the GitOps tools. 
>**GitOps** is a modern approach to managing infrastructure and application deployments using Git as the single source of truth. It applies the principles of DevOps to infrastructure automation, focusing on continuous delivery and infrastructure-as-code (IaC). In GitOps, all changes to infrastructure, environments, and applications are made through pull requests in a Git repository, and automation ensures that the desired state defined in Git is always reflected in the actual state of the system.

#### 6) **(Kubernetes cluster)**. This is where we deploy our code. There we install Argo Image updater and ARGO CD to allow them deploying new software to this cluster. 

---
# Let's create a real setup

First check if our application work fine on local machine (install maven and java, build app and run):
``` shell
mvn clean package
java -jar target/spring-boot-web.jar
```

![](Attachments/Pasted%20image%2020241011121846.png)
So I pushed the code to this repo: https://github.com/Briez-b/CICD-setup-java-app-Jenkins-example/

1) **Create EC2 instance**

![](Attachments/Pasted%20image%2020241011125237.png)


And install Jenkins (https://www.jenkins.io/doc/book/installing/linux/)

![](Attachments/Pasted%20image%2020241011131154.png)
password: 29c321d1d1a9405b87df98bcf823a23c

2) **Write a Jenkins pipeline.**
   
![](Attachments/Pasted%20image%2020241011132522.png)

There are two ways. I can write pipeline script in the jenkins page or use the jenkinFile with the script from external repo:
![](Attachments/Pasted%20image%2020241011132736.png)

It is better to use "Pipeline script from SCM" option. 

![](Attachments/Pasted%20image%2020241011133401.png)

So write a script file and put it to my repository. But before this, I need to do additional setup. 

3) **Install docker pipeline plugin to use docker as agent in pipeline:**

![](Attachments/Pasted%20image%2020241011135856.png)

4) **Install sonarQube server to the same EC2 instance and SonarQube Scanner plugin to use SonarQube in pipeline**

``` shell
apt install unzip
adduser sonarqube
sudo su - sonarqube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.4.0.54424.zip
unzip *
chmod -R 755 /home/sonarqube/sonarqube-9.4.0.54424
chown -R sonarqube:sonarqube /home/sonarqube/sonarqube-9.4.0.54424
cd sonarqube-9.4.0.54424/bin/linux-x86-64/
./sonar.sh start
```

![](Attachments/Pasted%20image%2020241011173607.png)
login: admin
password: admin

Log in to it and generate a token that can be used inside Jenkins as secret.

![](Attachments/Pasted%20image%2020241011173847.png)

Add this token to secret in Jenkins:

![](Attachments/Pasted%20image%2020241011174127.png)

5) **Install docker to the same EC2 instance.**

``` Shell
sudo apt install docker.io
sudo su -
usermod -aG docker jenkins
usermod -aG docker ubuntu
systemctl restart docker
```

6) **Prepare kubernetes cluster and install there argo CD**
   
   I have cluster created with kops (nodes on AWS).
   Install argo CD using operators(it is the best way to install controllers on kubernetes):
   
![](Attachments/Pasted%20image%2020241011180127.png)

![](Attachments/Pasted%20image%2020241011180625.png)

7) Create repository for manifests files:

![](Attachments/Pasted%20image%2020241011183750.png)

8) Write Jenkins file and push it to source code repository:

![](Attachments/Pasted%20image%2020241012164633.png)
![](Attachments/Pasted%20image%2020241012164659.png)

for 'github' i generated token in github and added it to jenkins secrets. And for 'docker-credentials' also added credentials as secret.
9) Run build on Jenkins. 

Now I can see that CI part is good, all steps:

![](Attachments/Pasted%20image%2020241012164758.png)
![](Attachments/Pasted%20image%2020241012164849.png)

And I can see that the repository with deployment files was successful updated by script from pipeline:

![](Attachments/Pasted%20image%2020241012164950.png)

And I can see that this build was pushed to docker hub.
### CI part works as expected. Now let's add CD part and automate it all.

10) Deploy a basic ArgoCD custom resource(it containers some services, configmaps and etc.):

![](Attachments/Pasted%20image%2020241012171320.png)

And expose `service/example-argocd-server` to access argoCD UI. I changed it to nodePort, and added new inbound rule:

![](Attachments/Pasted%20image%2020241012172220.png)

![](Attachments/Pasted%20image%2020241012172530.png)

To find the password in argoCD cluster secret and decrypt it:

![](Attachments/Pasted%20image%2020241012172959.png)

![](Attachments/Pasted%20image%2020241012175316.png)

11) Configure argoCD

![](Attachments/Pasted%20image%2020241012175710.png)

![](Attachments/Pasted%20image%2020241012175739.png)
>Add also a namespace (the same where argoCD resource created).

12) The app successfully deployed. Now everytime the repo will be updated, argoCD automatically update cluster.

![](Attachments/Pasted%20image%2020241012190150.png)

![](Attachments/Pasted%20image%2020241012190741.png)

And my app accessible with this url.

Now even if I edit this deployment or service diretly in the cluster (with kubectl), argoCD will change it back as for ARGO CD there is only one source of truth, and this is manifest repository.

 13) Make Jenkins job be triggered on new commits. Add webhook to gitHub:

![](Attachments/Pasted%20image%2020241012191917.png)

![](Attachments/Pasted%20image%2020241012192011.png)


**Now every time I push new commit to main branch, it automatically deployed on cluster.**

![](Attachments/Pasted%20image%2020241012204451.png)

![](Attachments/Pasted%20image%2020241012204517.png)

