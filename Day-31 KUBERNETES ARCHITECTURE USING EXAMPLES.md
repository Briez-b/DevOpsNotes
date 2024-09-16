Kubernetes functions can be separated on two things:
Control plane and Data plane. 
To understand what is these functions for let's begin with comparing with Docker.

##### Docker:
We have one host and it creates container using Docker daemon with docker run. When we run container,  it should have something to run (for example it should have Java runtime and java application).
Or in my previous example, simple calculator was waiting for my commands. So, container was run till I stop using the calculator. So, containers should have something that could be run. The component responsible for this called **Container run time**. It includes several key components like **containerd** that work together to create, manage, and run containers.
![[Pasted image 20240912163152.png]]

---
##### Kubernetes

In Docker we deploy containers, in Kubernetes we deploy PODs. 

> [!info] POD
**POD** is the smallest and simplest unit of deployment in Kubernetes. It represents a single instance of a running process in a cluster and can contain one or more closely related containers, usually sharing the same network and storage resources. Pods are designed to run the containers that work together as a single application or service component.``

To use kubernetes, we create a master and worker nodes(in this example there will be 1 master, 1 worker). 
Master node role is control plane. All the requests go through this node.
Worker nodes role is Data plane. This is the place where Kubernetes deploys PODs. 
![[Pasted image 20240912162207.png]]
When pod is deployed on worker node, there is a component called **kubelet**. It is responsible for running and managing your POD. For example, it checks if the POD is running, if not it informs Kubernetes about it to do something about it.

---
#### ==Data plane== (worker nodes components):

**Kubelet**
> [!info] Kubelet
**Kubelet** is a primary node agent in Kubernetes that runs on each worker node. It is responsible for managing Pods, ensuring that containers are running as expected, and interacting with the container runtime to start, stop, and maintain containers according to the Pod specifications provided by the Kubernetes control plane.

**Container run time**
To run these containers in the pod, there should be also some "container run time" component. But the difference between docker and kubernetes, that kubernetes can use any container runtimes like `containerd`, `CRI-O`, or others that are CRI-compliant. In docker only containerd used. 
> [!info] Container runtime
> The container runtime is the software component on each Kubernetes node that is responsible for pulling container images, starting and stopping containers, and managing container operations as directed by the kubelet. It is an essential part of the Kubernetes node that handles the actual execution of the containerized workloads defined in Pods. Popular CRI-compliant container runtimes include `containerd`, `CRI-O`, and, historically, Docker (before the deprecation of Docker shim in Kubernetes).

**kube-proxy**
Responsible for networking, analog of docker0 bridge in docker, but with additional functionality.
> [!info] Kube-proxy
> Kube-proxy is a network component that runs on each node in the Kubernetes cluster and is responsible for maintaining network rules and routing traffic to and from the containerized applications. It manages the networking setup for service discovery and ensures that network requests are forwarded correctly between pods, services, and external clients by maintaining network rules using iptables, IPVS, or other supported methods. Kube-proxy plays a crucial role in enabling load balancing and network connectivity within the Kubernetes cluster.

---
#### ==Control plane== (master node components):

**API server**(`kube-apiserver`) 
To communicate with kubernetes cluster, we need a component that should be responsible for that. The component that takes the instructions from external and apply them(for example where new PODS should be deployed, on what node). So, API server is the interface between kubernetes cluster and external world.

>[!info] API Server
The API Server is a critical component of the Kubernetes control plane that acts as the central management point and the front-end for the entire Kubernetes cluster. It exposes the Kubernetes API, which is the primary interface used by all components and external tools to interact with the cluster. The API Server processes RESTful API requests from users, tools, and other control plane components, validates them, and updates the cluster state in etcd, the distributed key-value store.

**Scheduler** (`kube-scheduler`):
Responsible for scheduling the resources, assigning newly created pods to nodes.
>[!info] Scheduler
The Kubernetes Scheduler is a control plane component responsible for assigning newly created pods to nodes in the cluster based on resource requirements, constraints, and policies. It is the component that decides which node is the best fit for each pod, considering factors like available resources, taints, tolerations, affinity, and anti-affinity rules.

**etcd**:
It responsible for backup of all the kubernetes data. It stores all the information about current state of kubernetes cluster. 
>[!info] Etcd
Etcd is a distributed, reliable key-value store that serves as the primary data store for Kubernetes. It holds the configuration data, cluster state, and metadata needed for managing the Kubernetes cluster. Etcd is crucial for the operation of the Kubernetes control plane, as it provides the persistent backend for all cluster data, including information about nodes, pods, services, secrets, and configurations.

**Controller manager** (`kube-controller-manager`):
This component runs controllers that manage various aspects of the cluster. For example runs "Replication controller" that serves as the mechanism responsible for auto healing. It always checks if the required amount of pods runs and normally function. If some pod got killed, it automatically add new replica. 
>[!info] Controller Manager
The Kubernetes Controller Manager is a core control plane component that runs controllers, each responsible for maintaining the desired state of various resources in the cluster. It is a daemon that manages multiple controllers in a single process, coordinating their actions to ensure the Kubernetes cluster behaves as intended. Each controller watches the state of the cluster via the API Server and takes corrective actions when the actual state does not match the desired state.

**Cloud Controller manager**:
Responsible for integrating kubernetes with other cloud provider services. For example Kubernetes can be run on the services like EKS(amazon elastic kubernetes service). When it is run on EKS, it has to understand how to create and use cloud provider's load balancer, storage volumes and etc. CCM manages all of these, woth this component kubernetes understand how to interact with different cloud provider platforms
>[!info] Cloud Controller Manager
The Cloud Controller Manager is a Kubernetes control plane component that integrates Kubernetes with cloud provider-specific services. It enables the Kubernetes cluster to interact with cloud resources such as load balancers, storage volumes, and nodes provided by the underlying cloud infrastructure. By running cloud-specific control loops, it decouples cloud provider code from the main Kubernetes components, allowing for better maintainability and modularity.

---
#### Components summary:

| **Plane**         | **Component Name**       | **Description**                                                              |
| ----------------- | ------------------------ | ---------------------------------------------------------------------------- |
| **Control Plane** | API Server               | Exposes the Kubernetes API, managing all communication within the cluster.   |
|                   | Scheduler                | Assigns pods to nodes based on resource requirements and constraints.        |
|                   | etcd                     | Stores all cluster data, including configurations and state.                 |
|                   | Controller Manager       | Runs controllers that ensure the desired state of the cluster is maintained. |
|                   | Cloud Controller Manager | Manages cloud-specific resources like load balancers and storage.            |
| **Data Plane**    | Kubelet                  | Ensures containers are running on nodes according to pod specifications.     |
|                   | Kube-proxy               | Manages network rules for communication between services and pods.           |
|                   | Container Runtime        | Executes containers on nodes, such as containerd or CRI-O.                   |
