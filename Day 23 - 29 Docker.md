
# ==Day-23 | Introduction to Containers | Learn about containers in easy way==

Firstly only psychical servers existed. Developers and companies used only physical servers to deploy applications or deploy them. But it was very inefficient, as a lot of resources wasted.
So, the concept of Virtual Machines came, so now organisations could split for example one server into several virtual machines(all memory and CPU were shared to these machines, so if for example server had 100 CPU and 100 RAM, hypervisor, the tool that makes virtualisation, could split it to 5 machines with 20 CPU and 20 RAM). Every VM has it is own complete OS, 

Still, it was a lot of resources waste. Even with 20 CPU, applications could only take for example 10 CPU, or sometimes, only 5 cpu needed, sometime 15 CPU. It was inefficient. 

So the new concept was created: containerisation. With this concept, for physical or virtual servers new programs such as Docker, could create containers. These containers are very lightweight, they don't have the complete OS, it uses base OS with only application and libraries it is required. They use the RAM and CPU of the host (machine where docker executed).
With containerisation the memory and CPU is not reserved by this containers, it takes the resources of the host machines and it only takes it when it is needed and only resources it is required(for example if run application takes 3 CPU at this moment, only this amount will be used). When for VM the resources that was taken by it is not accessible for host.

As I mentioned, Docker is used for creation of containers (it is like hypervisor for VM). It is one of the most popular tool for it.


Such sheme is used to create containers:
1) User creates Dockerfile. There user describes what image should be taken as base, describes dependencies and the code that should be copied into container(for example our own application).
2) The command `docker build` executed and Docker engine creates this new image(docker engine is something like the heart of Docker). 
3) User runs newly created image, and container created.

One of the problem with docker is that it very depends on Docker Engine. If Engine will get down, containers will stop working. Till now there is now workaround for this issue.
Another tool can solve this problem, Buildah. It is another containerisation tool. 

Buildah is a tool that facilitates building Open Container Initiative (OCI) and Docker container images without requiring a running container daemon, like Docker. It provides a lower-level approach to image building, giving you more control and flexibility compared to other tools. Here’s a detailed overview you can use for your Obsidian notes:

**Buildah** is a command-line tool for building and managing OCI and Docker images. Unlike traditional container engines, Buildah doesn’t require a running daemon, making it lightweight and suitable for secure and customizable workflows.

### **Key Features**

- **Daemonless Operation**: Buildah works without a running daemon, allowing for secure image builds and reduced system resource usage.
- **Image Building and Manipulation**: Provides tools to build images from scratch or modify existing images, allowing for full control over the image creation process.
- **Scripting and Automation**: Easily integrates into shell scripts, CI/CD pipelines, and other automation systems without the need for a running service.
- **OCI Compliance**: Fully compliant with the Open Container Initiative (OCI) specifications, ensuring compatibility with other OCI-compliant tools.
- **Rootless and Rootful Modes**: Supports building images both as a root user and as an unprivileged user, enhancing security in multi-user environments.

### **Core Commands**

1. **`buildah from`**: Creates a working container from an image.
2. **`buildah run`**: Executes commands inside a working container, similar to running commands in a Dockerfile.
3. **`buildah commit`**: Saves changes in the working container as a new image.
4. **`buildah bud`**: Builds images using a Dockerfile (Build Using Dockerfile).
5. **`buildah push`**: Pushes images to a container registry.

### **Example Workflow**

1. **Create a Container**:
   ```bash
   buildah from alpine
   ```
   
2. **Run Commands Inside the Container**:
   ```bash
   buildah run <container-name> -- apk add nginx
   ```

3. **Commit the Container to an Image**:
   ```bash
   buildah commit <container-name> my-nginx-image
   ```

4. **Push the Image to a Registry**:
   ```bash
   buildah push my-nginx-image docker://registry.example.com/my-nginx-image
   ```

### **Benefits**

- **Security**: By avoiding a persistent daemon, Buildah reduces the attack surface.
- **Flexibility**: Offers low-level image manipulation, allowing you to build exactly the environment you need.
- **Lightweight**: No need for a large, continuously running service, making it ideal for minimal environments or resource-constrained systems.

### **Use Cases**

- CI/CD Pipelines: Easily integrates with automated build systems.
- DevOps Workflows: Customize images on the fly with precise control.
- Rootless Containers: Enhanced security by building images without root privileges.

---


# ==Day-24 | Docker Zero to Hero Part-1 | Must Watch | Basics to Best Practices==

# Repo to learn Docker with examples. Contributions are most welcome.

## What is a container ?

A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another. A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

Ok, let me make it easy !!!

A container is a bundle of Application, Application libraries required to run your application and the minimum system dependencies.

[![Screenshot 2023-02-07 at 7 18 10 PM](https://user-images.githubusercontent.com/43399466/217262726-7cabcb5b-074d-45cc-950e-84f7119e7162.png)](https://user-images.githubusercontent.com/43399466/217262726-7cabcb5b-074d-45cc-950e-84f7119e7162.png)

## Containers vs Virtual Machine

Containers and virtual machines are both technologies used to isolate applications and their dependencies, but they have some key differences:

```
1. Resource Utilization: Containers share the host operating system kernel, making them lighter and faster than VMs. VMs have a full-fledged OS and hypervisor, making them more resource-intensive.

2. Portability: Containers are designed to be portable and can run on any system with a compatible host operating system. VMs are less portable as they need a compatible hypervisor to run.

3. Security: VMs provide a higher level of security as each VM has its own operating system and can be isolated from the host and other VMs. Containers provide less isolation, as they share the host operating system.


4. Management: Managing containers is typically easier than managing VMs, as containers are designed to be lightweight and fast-moving.
```
## Why are containers light weight ?

Containers are lightweight because they use a technology called containerization, which allows them to share the host operating system's kernel and libraries, while still providing isolation for the application and its dependencies. This results in a smaller footprint compared to traditional virtual machines, as the containers do not need to include a full operating system. Additionally, Docker containers are designed to be minimal, only including what is necessary for the application to run, further reducing their size.

Let's try to understand this with an example:

Below is the screenshot of official ubuntu base image which you can use for your container. It's just ~ 22 MB, isn't it very small ? on a contrary if you look at official ubuntu VM image it will be close to ~ 2.3 GB. So the container base image is almost 100 times less than VM image.

[![Screenshot 2023-02-08 at 3 12 38 PM](https://user-images.githubusercontent.com/43399466/217493284-85411ae0-b283-4475-9729-6b082e35fc7d.png)](https://user-images.githubusercontent.com/43399466/217493284-85411ae0-b283-4475-9729-6b082e35fc7d.png)

To provide a better picture of files and folders that containers base images have and files and folders that containers use from host operating system (not 100 percent accurate -> varies from base image to base image). Refer below.

### Files and Folders in containers base images

```
    /bin: contains binary executable files, such as the ls, cp, and ps commands.

    /sbin: contains system binary executable files, such as the init and shutdown commands.

    /etc: contains configuration files for various system services.

    /lib: contains library files that are used by the binary executables.

    /usr: contains user-related files and utilities, such as applications, libraries, and documentation.

    /var: contains variable data, such as log files, spool files, and temporary files.

    /root: is the home directory of the root user.
```

### Files and Folders that containers use from host operating system

```
    The host's file system: Docker containers can access the host file system using bind mounts, which allow the container to read and write files in the host file system.

    Networking stack: The host's networking stack is used to provide network connectivity to the container. Docker containers can be connected to the host's network directly or through a virtual network.

    System calls: The host's kernel handles system calls from the container, which is how the container accesses the host's resources, such as CPU, memory, and I/O.

    Namespaces: Docker containers use Linux namespaces to create isolated environments for the container's processes. Namespaces provide isolation for resources such as the file system, process ID, and network.

    Control groups (cgroups): Docker containers use cgroups to limit and control the amount of resources, such as CPU, memory, and I/O, that a container can access.
    
```

It's important to note that while a container uses resources from the host operating system, it is still isolated from the host and other containers, so changes to the container do not affect the host or other containers.

**Note:** There are multiple ways to reduce your VM image size as well, but I am just talking about the default for easy comparision and understanding.

so, in a nutshell, container base images are typically smaller compared to VM images because they are designed to be minimalist and only contain the necessary components for running a specific application or service. VMs, on the other hand, emulate an entire operating system, including all its libraries, utilities, and system files, resulting in a much larger size.

I hope it is now very clear why containers are light weight in nature.
## Docker

### What is Docker ?
Docker is a containerization platform that provides easy way to containerize your applications, which means, using Docker you can build container images, run the images to create containers and also push these containers to container regestries such as DockerHub, Quay.io and so on.

In simple words, you can understand as `containerization is a concept or technology` and `Docker Implements Containerization`.

### Docker Architecture ?

[![image](https://user-images.githubusercontent.com/43399466/217507877-212d3a60-143a-4a1d-ab79-4bb615cb4622.png)](https://user-images.githubusercontent.com/43399466/217507877-212d3a60-143a-4a1d-ab79-4bb615cb4622.png)

The above picture, clearly indicates that Docker Deamon is brain of Docker. If Docker Deamon is killed, stops working for some reasons, Docker is brain dead :p (sarcasm intended).

### Docker LifeCycle

We can use the above Image as reference to understand the lifecycle of Docker.

There are three important things,

1. docker build -> builds docker images from Dockerfile
2. docker run -> runs container from docker images
3. docker push -> push the container image to public/private regestries to share the docker images.

[![Screenshot 2023-02-08 at 4 32 13 PM](https://user-images.githubusercontent.com/43399466/217511949-81f897b2-70ee-41d1-b229-38d0572c54c7.png)](https://user-images.githubusercontent.com/43399466/217511949-81f897b2-70ee-41d1-b229-38d0572c54c7.png)

### Understanding the terminology (Inspired from Docker Docs)

#### Docker daemon

The Docker daemon (dockerd) listens for Docker API requests and manages Docker objects such as images, containers, networks, and volumes. A daemon can also communicate with other daemons to manage Docker services.

#### Docker client

The Docker client (docker) is the primary way that many Docker users interact with Docker. When you use commands such as docker run, the client sends these commands to dockerd, which carries them out. The docker command uses the Docker API. The Docker client can communicate with more than one daemon.

#### Docker Desktop

Docker Desktop is an easy-to-install application for your Mac, Windows or Linux environment that enables you to build and share containerized applications and microservices. Docker Desktop includes the Docker daemon (dockerd), the Docker client (docker), Docker Compose, Docker Content Trust, Kubernetes, and Credential Helper. For more information, see Docker Desktop.

#### Docker registries

A Docker registry stores Docker images. Docker Hub is a public registry that anyone can use, and Docker is configured to look for images on Docker Hub by default. You can even run your own private registry.

When you use the docker pull or docker run commands, the required images are pulled from your configured registry. When you use the docker push command, your image is pushed to your configured registry. Docker objects

When you use Docker, you are creating and using images, containers, networks, volumes, plugins, and other objects. This section is a brief overview of some of those objects.

#### Dockerfile

Dockerfile is a file where you provide the steps to build your Docker Image.

#### Images
An image is a read-only template with instructions for creating a Docker container. Often, an image is based on another image, with some additional customization. For example, you may build an image which is based on the ubuntu image, but installs the Apache web server and your application, as well as the configuration details needed to make your application run.

You might create your own images or you might only use those created by others and published in a registry. To build your own image, you create a Dockerfile with a simple syntax for defining the steps needed to create the image and run it. Each instruction in a Dockerfile creates a layer in the image. When you change the Dockerfile and rebuild the image, only those layers which have changed are rebuilt. This is part of what makes images so lightweight, small, and fast, when compared to other virtualization technologies.

## My practice:

First register on docker hub

Creating my first container:
1) Install docker
``` bash
sudo pacman -S docker
```
2) Add user to docker group 
``` bash
sudo usermod -aG docker ebryyau
```
For some reason I still wasn't able to run images even after log out. Reboot helped me
3) Run simple hello world image to check if all work correctly:
``` bash
docker run hello-world
```

Run our own image:
1) Create Dockerfile and needed app code:
![](../Images/Pasted%20image%2020240906072432.png)
1. **FROM ubuntu:latest**: This line sets the base image to the latest version of Ubuntu.
2. **WORKDIR /app**: Sets the working directory inside the container to `/app`.
3. **COPY . /app**: Copies all the files from the current directory on the host system into the `/app` directory in the container.
4. **RUN apt-get update && apt-get install -y python3 python3-pip**: Updates the package list and installs Python 3 and pip.
5. **ENV NAME World**: Sets an environment variable `NAME` with the value `World`.
6. **CMD ["python3", "app.py"]**: Specifies the command to run when the container starts, which is to execute the `app.py` script using Python 3.

![](../Images/Pasted%20image%2020240906072608.png)
app is a simple python hello-world
2) Run build:
``` bash
docker buid -t ebryyau/first-ubuntu-image:v1 .
```
![](../Images/Pasted%20image%2020240906074540.png)
3) Run to be sure it works. And then you can push it to docker hub. Then this image will be accesible for everyone:
![](../Images/Pasted%20image%2020240906075056.png)
![](../Images/Pasted%20image%2020240906075115.png)
To remove images use this:
``` bash
docker rmi image-name
```
I can also remove multiple images or use image id

- **Check for Running Containers**: Make sure no running or stopped containers are using the image you want to delete. You can check with:
``` bash
docker ps -a # all, even stopped
docker ps # running containers
```
To check how many memories images take use:
```bash
docker system df
```

Here's a concise list of useful Docker commands for quick reference, covering common tasks such as managing containers, images, volumes, and more:

### **Some additional commands**
- **Start a Container:**
  ```bash
  docker start container-name-or-id
  ```
- **Stop a Container:**
  ```bash
  docker stop container-name-or-id
  ```
- **Remove a Container:**
  ```bash
  docker rm container-name-or-id
  ```
- **Run a New Container:**
  ```bash
  docker run -d --name container-name image-name
  ```
### **Images**
- **List All Images:**
  ```bash
  docker images
  ```
- **Build an Image from Dockerfile:**
  ```bash
  docker build -t image-name .
  ```
- **Remove an Image:**
  ```bash
  docker rmi image-name-or-id
  ```
- **Remove Unused Images:**
  ```bash
  docker image prune
  ```
- **Pull an Image from a Registry:**
  ```bash
  docker pull image-name
  ```

These commands will help you efficiently manage your Docker environment. Feel free to save or expand on this list based on your needs! Let me know if you need more details or examples for any command

---

# ==Day-25 | Docker Containerzation for Django==

### What is Django?

**Django** is a high-level, open-source web framework written in Python that encourages rapid development and clean, pragmatic design. It was originally developed to meet the fast-paced newsroom deadlines of a newspaper, which is why it emphasizes getting work done quickly while maintaining high levels of security and scalability.

This is how the skeleton of such app looks(from example on github):
![](../Images/Pasted%20image%2020240906163054.png)

I will try to run this app on my own machine:
1) Install python, pip.
``` bash
sudo pacman -S python3
sudo pacman -S python-pip
```
2) Install additional python packages using pip(I also created additional virtual env).
![](../Images/Pasted%20image%2020240906105143.png)
And then I tried to launch server, but it failed. Nothing works.
The reason is just the wrong address I used. I need to add `/demo` to url
3) Run the application with this command:
``` 
python manage.py runserver
```

Also I deployed this app to EC2 instance with docker:
1) Install docker
2) Create docker file:
![](../Images/Pasted%20image%2020240906161137.png)
In original dockerfile in Abhishek repository there is no `ENV PIP_BREAK_SYSTEM_PACKAGES 1`. I added it because currently pip is not allow to install packages without setting virtual environment. This line disable this requirement. (I also tried to create env in docker file, but the image wasn't able to execute application because it didn't see Django package).
3) Then build the image. To make this app accesible through port 8000, we need to make a mapping from docker port 8000 to EC2 host port 8000. So add the -p flag to run command:
`docker run -p 8000:8000 -it image-id`

#### Change image to python distro.
1) Find python base image in docker hub
https://hub.docker.com/_/python
2) Change Docker file:
![](../Images/Pasted%20image%2020240906171732.png)

==come back to Django app to investigate more how it works and maybe improve application==
==for example I can create my own Django project== Check official documentation (added this task to "task note").
For example I can use `dhango-admin startproject mysite`. It will create skeleton of my future Django app.


---

# ==Day26 Multi Stage Docker Builds | Reduce Image Size by 800 % | Distroless Container Images

Before we were using only one stage builds. But there is a  posibility to make several stages during the buyilding you image.
Let's see what do I mean and why do we need this.
With one stage build in Dockerfile we do:
1) We take one image as base for example ubuntu(iut can be ~800 mb just for an example)
2) We create work directory, copy our code , install all dependencies we need with command like apt-get, maybe using some other shell commands.
3) Finally we execute something in CMD (maybe our application script)
With this way we build only one build based on ubuntu, and the final size of our image can be more then 1 GB.

So another way of building our images exists, that is multistage build.
For our final image we don't need anymore any shell commands and other ubuntu libs as it is only required during installation of our dependencies for our application (let's it be python app, we install python and pip wit apt-get). 
With multistage build we can install all of this dependencies during the first step and copy `bin` folder to another very lightweight build that will be created in stage 2, so our first build will not be needed anymore:\
1 stage:
1) We take one image as base for example ubuntu(iut can be ~800 mb just for an example)
2) We create work directory, copy our code , install all dependencies we need with command like apt-get, maybe using some other shell commands. 1 stage is finished.
2 stage:
3) We take another base image, but very lightweitgh (it can be ~200 mb, sometimes even less)
4) Copy the folder with needed packages and libs from 1st build into 2nd.
5) Execute needed cmd command to launch our application.
With such approach our final image will be less then 500 mb, and we can reduce it even more.

Such very lightweight base images we used in stage 2 called ==distroless images==. Such images usually doesn't contain even commands like `ls, curl, grep` and etc. There is only packages we need(depends on build we choose, for example we can take the image only with "python runtime"). With such build we can even raise our security because of the reasons above.




This is an example of golang app(just calculator) with one stage build:
![](../Images/Pasted%20image%2020240907115141.png)
Such image will take ==~850 mb.==

Let's do the same, but with multistage build:
1) Create our app that will be deployed on docker image
![](../Images/Pasted%20image%2020240907114924.png)


2) Create Dockerfile:
![](../Images/Pasted%20image%2020240907121304.png)
3) Now we can see the size is only 1.96 mb
This is just an example. In real cases it is better to use goland distroless image:
```
# Build stage
FROM golang:1.19 AS builder
WORKDIR /app
COPY . .
RUN go build -o myapp

# Run stage
FROM gcr.io/distroless/base
COPY --from=builder /app/myapp /myapp
CMD ["/myapp"]

```
Python multistage build:
![](../Images/Pasted%20image%2020240907125952.png)
It takes only 52,8 mb

NodeJs example:
![](../Images/Pasted%20image%2020240907130256.png)

More examples here: https://github.com/GoogleContainerTools/distroless

---
# ==# Day-27 | Docker Volumes and Bind Mounts|Persistent Storage for Docker==

There can be different scenarios when containers need to read some files, or make some logs to have these files accessible. It can't be done inside the container because of the nature of them(everytime the container will be destroyed or not run, we lost files inside them).
Some of the possible scenarios
1) Container application must have a possibility to store logfiles that can be readed anytime and shouldn';t be lost.
2) Containers should have a possibility to read files generated by another container(like frontend and bachend containers that leave some json and etc.)
3) Containers should have a possibility to read files outside the container that are generated, for example by the end of the day, by the tool like `crontab`

Two concepts were created for Docker:
### Bind Mounts
You can bind any directory from your host machine to the docker container, so he will always have an access to this dir. This approach os very simple and it is not such good as the next concept, but still used , for example, in development to do some fast testing and etc.
### Docker Volumes

Volumes are similar, you can create volume(it will take some storage from host machine or for example EC2 instance), so we can attach it to any container we want. This soultion is better as we have a better lifecycle:
1) Volumes can be easy created, destroyed or attached/detached to any container, therefore it is easier to control it.
2) We can use not only the memory of our original host, we also can use any memory, such as EC2 instance, external devices and etc.
How it works? Using Docker cli we can create Volume that will be using the memory on the needed machine (like it is create additional logical disk). And later we attach it to any container we want.

### How to create Volumes?
![](../Images/Pasted%20image%2020240907141526.png)
![](../Images/Pasted%20image%2020240907143239.png)
`$ docker inspect 8ceb7cd923d5` | jq
...
![](../Images/Pasted%20image%2020240907143345.png)
We can also specify if this is read or write volume ("RW: true above"). To do this, we can specify it in --mount parameters.

---
# ==Day-28 | Docker Networking | Bridge vs Host vs Overlay |Secure containers with custom bridge network==

Often we need a way to have containers communicating each other or an oposite, do not have a possibility to communicate.
For example we can have such 2 scenarios:
1) We have 2 containers, one is Frontend, another Backend. They deffenetly should communicate each other.
2) We have 2 container. The aim of one is log in / out operations, Another one is some payment related staff. We deffenetly don't want to have possible a communication between each other to increase security.

==Let's find out what is happening with communication between container and host when it is created:==
Host machine has it is own Ethernet network interface. For my arch linux machine it is called enp0s31f6 and it has IP 192.168.166.223. Also there is a network for my docker: docker0 172.17.0.1.
![](../Images/Pasted%20image%2020240908132427.png)

When docker run a container, the container has it is own network interface, but it can't be used to communicate to host. 
But when any container is run, docker use additional virtual network interface called bridge and assign free IP address to
new container, which can be used for such purpose:
![](../Images/Pasted%20image%2020240908133355.png)
Here is the bridge network info. we can use any IP address within the subnet `172.17.0.0/16` except the gateway (`172.17.0.1`) and the IP addresses already assigned to running containers. For example, you could use an IP address like `172.17.0.3`, `172.17.0.4`, etc., as long as it's not already in use by another container. But it is better to let docker assign it automatically, when it creates container.

The assigned Ip address for our container
![](../Images/Pasted%20image%2020240908133755.png)

So, let's come back to examples above.
### First example scenario(frontend and backend container): 
Containers should have a possibility for communication with each other.

There is no need to do anything else, by default newly created containers use the same "bridge" network interface, so just next IPAddress assigned, therefore they can communicate each other by default.
![](../Images/Pasted%20image%2020240908135419.png)
Note: to run containers in background(detach mode) we can use -d. They should have some ongoing process.
```
docker run -d --name nginxContainer nginx
```
To login to container to use bash commands:
```
docker exec -it nginxContainer /bin/bash
```
### Second scenario (log in/out and payment cpntainers):
They must not communicate to each other.

As we know, by default it uses the same "bridge" network interface. It is not suitable for this case.  Instead we can create a new "bridge" network interface and use it for new container. In such case both containers will be using different "bridge" interfaces, therefore they will not be able to communicate each other.

To create new bridge network use this:
```
docker network create bridge2
```

Now we can use this network with --network when we run container:
```
docker run -d --name newContainer3 --network=bridge2 ebryyau/multistage-go-calc
```
IP of the first container:
![](../Images/Pasted%20image%2020240908142806.png)

Ip of the second:
![](../Images/Pasted%20image%2020240908142731.png)They have different subnet now, they will not able to communicate each other.

==come back to devops playlist later, there is one video I missed for now==

