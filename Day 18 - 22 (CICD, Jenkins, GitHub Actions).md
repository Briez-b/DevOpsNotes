
---
# ==Day-18 | What is CICD ? | Introduction to CICD | How CICD works ?==

### Key Concepts

#### 1. **Continuous Integration (CI)**
   - **Definition**: Practice of merging all developer working copies to a shared mainline multiple times a day.
   - **Process**:
     - Developers commit code frequently.
     - Each commit triggers an automated build and test sequence.
     - Early detection of integration issues helps maintain a clean codebase.

#### 2. **Continuous Delivery (CD)**
   - **Definition**: Extends CI by automating the release process to make sure code is always in a deployable state.
   - **Process**:
     - After CI, the code is automatically prepared for a potential release.
     - Includes additional tests, such as performance, load, and user acceptance tests.
     - Deployments are manual but can happen at any time, as the code is always in a releasable state.


During CI there are usually several stages during which some process happens. To describe it, CI Pipelines used. It is usually some file where described what every stage should do with the code(it is like some script). This usually done by tools like Jenkins or GitHub Actions.

Some of the most common steps are:
- Unit testing
- Static Code analysis
- Code quality
- Automation
- Reports
- Deployment
These steps usually executed by orchestrator. For example Jenkins.
Often the quantity of Jenkins machines should be scaled down or up, and every time you have to do manualy if you using Jenkins machines. So it is better to deploy CI on newest tools, for example use kubernetes.

One of the good examples is GitHub Actions. 


---
# ==Day-19 | Jenkins ZERO to HERO | 3 Projects Live |Docker Agent |Interview Questions==

1) Install Jenkins on my EC2 instance.
	- install java. `sudo apt install openjdk-21-jdk`
	- install jenkins. Use oficial website for the command
2) Allow the Jenkins communicate with EC2 instance by setting inbound rule.
![](Images/Pasted%20image%2020240830190248.png)
The port can be seen with ps -ef | jenkins

3) Use ip adress and port as an address and check the passport:
![](Images/Pasted%20image%2020240830190625.png)
then select "Install suggested plugins" and follow other steps. After that it should be installed.

Before working with jenkins I figured out how pull requests works in GitHub. This is the example of how make a pull request to merge the changes from another branch to the main:
	 - first i created the new branch locally called draft and connected it with the remote draft branch in my GitHub repository:
	 ![](Images/Pasted%20image%2020240830203140.png)
	 then I created a new file and pushed new changes to remote draft branch.
	 - after select pull requests - > create new request on github and choose the branch from which we will be merging our changes to main branch
	 ![](Images/Pasted%20image%2020240830203621.png)
	![](Images/Pasted%20image%2020240830203736.png)
	 - And after you press "merge pull request", the changes will appear on main branch as new merge commit.
Let's try to add CI to this GitHub repository.
![](Images/Pasted%20image%2020240830204255.png)
#### The image shows two different Jenkins infrastructure setups:

1. **Left Side**: A traditional Jenkins setup with a single Jenkins Master node connected to multiple Jenkins Worker Nodes (Node 1, Node 2, Node 3). This architecture represents a standard distributed Jenkins environment where the Master node manages the jobs and the Worker nodes execute the jobs.
2. **Right Side**: A containerized Jenkins setup with the Jenkins Master running inside a Docker container. The Master node directly manages several other containers (`c1`, `c2`, `c3`), which are used for executing jobs. This approach utilizes Docker to manage isolated build environments within containers, offering a modern, flexible, and scalable Jenkins architecture.

Install Docker:
`sudo apt install docker.io`
Grant the permission to the Jenkins user
`sudo usermod -aG docker jenkins`
 `sudo usermod -aG docker ubuntu`
`sudo systemctl restart docker`

Set the passwd for user
`sudo passwd jenkins`
And switch to this user
`su - jenkins`
Check if docker works:
`docker run hello-world`
install docker pipeline plugin on jenkins.
Then go to new item and choose Pipeline.

### Simple jenkins pipeline

Add the Jenkins file to repository and add the path to Jenkins.
Jenkins file: 
![](Images/Pasted%20image%2020240831153528.png)

The line `docker { image 'node:16-alpine' }` is part of a Jenkins pipeline script, and it specifies that the pipeline stage should run inside a Docker container using the specified image.

- **`image 'node:16-alpine'`**: This defines the Docker image that will be used. In this case, `node:16-alpine` is a lightweight Node.js image based on Alpine Linux, which includes Node.js version 16.
- **`agent { docker { image '...' } }`**: This combination instructs Jenkins to pull the specified Docker image (`node:16-alpine`) from Docker Hub (or another Docker registry) and use it as the environment to run the commands in the stage.
You can browse more images on [Docker Hub](https://hub.docker.com/) to find the most suitable one for your use case.

![](Images/Pasted%20image%2020240831154111.png)

Then launch the build. That is it!
### Multi agent multi steps pipeline

![](Images/Pasted%20image%2020240831175323.png)

### Complete CI/CD setup with deploying on kubernetes
Just watched for theory, but didn't practice yet because doesn't know anything about kubernetes and how to deploy on it
https://www.youtube.com/watch?v=ogrx8G8pClQ

---
# ==Day-20 | GitHub Actions | Actions vs Jenkins | 3 Projects with examples | Configure your own runner==

### Adding GitHub Actions to my repository
1) I created .github/workflows repository and added there `first-actions.yml` file. This is our pipeline:
![](Images/Pasted%20image%2020240831212757.png)
 Such syntax like `- uses: actions/checkout@v3` means that checkout@v3 plugin will be used. All such plugins you can find in github doc.
2) Added `addition.py` to new folder `action-test`. This is simple hardcoded python test. 
![](Images/Pasted%20image%2020240831212942.png)

After that I just pushed it on draft, the Ci automatically starting based on `first-actions.yml`. 
![](Images/Pasted%20image%2020240831213110.png)
![](Images/Pasted%20image%2020240831213140.png)

Now for every new commit in this repository (on branches where action file present), Ci will be executed.
You can read more in GitHub actions doc.

Also you can use gitHub  secrets, for example write the keys to the setting of the GitHub repository and use variables in .yml file:
![](Images/Pasted%20image%2020240831215157.png)
##### If you want to use your own runner(for example your own EC2 instance with docker how we done before with jenkins), you can set it in config:
1) Create EC2 instance and set inbound and outbound rule: 
![](Images/Pasted%20image%2020240831220357.png)

2) Execute all commands on your EC2
![](Images/Pasted%20image%2020240831221316.png)

3) Change to `self-hosted`
![](Images/Pasted%20image%2020240831222403.png)
4) After that EC2 instance will be listnning for any commit on github repository
## Comparing with Jenkins

### Advantages of GitHub Actions over Jenkins

- Hosting: Jenkins is self-hosted, meaning it requires its own server to run, while GitHub Actions is hosted by GitHub and runs directly in your GitHub repository.

- User interface: Jenkins has a complex and sophisticated user interface, while GitHub Actions has a more streamlined and user-friendly interface that is better suited for simple to moderate automation tasks.

- Cost: Jenkins can be expensive to run and maintain, especially for organizations with large and complex automation needs. GitHub Actions, on the other hand, is free for open-source projects and has a tiered pricing model for private repositories, making it more accessible to smaller organizations and individual developers.
### Advantages of Jenkins over GitHub Actions

- Integration: Jenkins can integrate with a wide range of tools and services, but GitHub Actions is tightly integrated with the GitHub platform, making it easier to automate tasks related to your GitHub workflow.

In conclusion, Jenkins is better suited for complex and large-scale automation tasks, while GitHub Actions is a more cost-effective and user-friendly solution for simple to moderate automation needs.
