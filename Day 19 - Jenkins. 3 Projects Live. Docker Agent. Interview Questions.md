
1) Install Jenkins on my EC2 instance.
	- install java. `sudo apt install openjdk-21-jdk`
	- install jenkins. Use oficial website for the command
2) Allow the Jenkins communicate with EC2 instance by setting inbound rule.
![](Attachments/Pasted%20image%2020240830190248.png)
The port can be seen with ps -ef | jenkins

3) Use ip adress and port as an address and check the passport:
![](Attachments/Pasted%20image%2020240830190625.png)
then select "Install suggested plugins" and follow other steps. After that it should be installed.

Before working with jenkins I figured out how pull requests works in GitHub. This is the example of how make a pull request to merge the changes from another branch to the main
	 - **first i created the new branch locally called draft and connected it with the remote draft branch in my GitHub repository**:
	 ![](Attachments/Pasted%20image%2020240830203140.png)
	 - **then I created a new file and pushed new changes to remote draft branch.**
	 - **after select pull requests - > create new request on github and choose the branch from which we will be merging our changes to main branch**
	 ![](Attachments/Pasted%20image%2020240830203621.png)
	![](Attachments/Pasted%20image%2020240830203736.png)
	 **- And after you press "merge pull request", the changes will appear on main branch as new merge commit.**
Let's try to add CI to this GitHub repository.
![](Attachments/Pasted%20image%2020240830204255.png)
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
![](Attachments/Pasted%20image%2020240831153528.png)

The line `docker { image 'node:16-alpine' }` is part of a Jenkins pipeline script, and it specifies that the pipeline stage should run inside a Docker container using the specified image.

- **`image 'node:16-alpine'`**: This defines the Docker image that will be used. In this case, `node:16-alpine` is a lightweight Node.js image based on Alpine Linux, which includes Node.js version 16.
- **`agent { docker { image '...' } }`**: This combination instructs Jenkins to pull the specified Docker image (`node:16-alpine`) from Docker Hub (or another Docker registry) and use it as the environment to run the commands in the stage.
You can browse more images on [Docker Hub](https://hub.docker.com/) to find the most suitable one for your use case.

![](Attachments/Pasted%20image%2020240831154111.png)

Then launch the build. That is it!
### Multi agent multi steps pipeline

![](Attachments/Pasted%20image%2020240831175323.png)

### Complete CI/CD setup with deploying on kubernetes
Just watched for theory, but didn't practice yet because doesn't know anything about kubernetes and how to deploy on it
https://www.youtube.com/watch?v=ogrx8G8pClQ
come back later!!!!
