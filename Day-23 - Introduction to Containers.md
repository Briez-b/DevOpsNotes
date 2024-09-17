
Firstly only psychical servers existed. Developers and companies used only physical servers to deploy applications or deploy them. But it was very inefficient, as a lot of resources wasted.
So, the concept of Virtual Machines came, so now organisations could split for example one server into several virtual machines(all memory and CPU were shared to these machines, so if for example server had 100 CPU and 100 RAM, hypervisor, the tool that makes virtualization, could split it to 5 machines with 20 CPU and 20 RAM). Every VM has it is own complete OS, 

Still, it was a lot of resources waste. Even with 20 CPU, applications could only take for example 10 CPU, or sometimes, only 5 cpu needed, sometime 15 CPU. It was inefficient. 

So the new concept was created: containerization. With this concept, for physical or virtual servers new programs such as Docker, could create containers. These containers are very lightweight, they don't have the complete OS, it uses base OS with only application and libraries it is required. They use the RAM and CPU of the host (machine where docker executed).
With containerization the memory and CPU is not reserved by this containers, it takes the resources of the host machines and it only takes it when it is needed and only resources it is required(for example if run application takes 3 CPU at this moment, only this amount will be used). When for VM the resources that was taken by it is not accessible for host.

As I mentioned, Docker is used for creation of containers (it is like hypervisor for VM). It is one of the most popular tool for it.


Such scheme is used to create containers:
1) User creates Dockerfile. There user describes what image should be taken as base, describes dependencies and the code that should be copied into container(for example our own application).
2) The command `docker build` executed and Docker engine creates this new image(docker engine is something like the heart of Docker). 
3) User runs newly created image, and container created.

One of the problem with docker is that it very depends on Docker Engine. If Engine will get down, containers will stop working. Till now there is no workaround for this issue.
Another tool can solve this problem, Buildah. It is another containerization tool. 

#### Buildah
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
