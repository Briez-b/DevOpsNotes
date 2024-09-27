
Let's try to understand why do we need KUBERNETES SERVICES. 
Without using KUBERNETES services we can get 3 problems

***Problem 1:*** 
Kubernetes Deployments can implement the auto-healing capability for pod that goes down using Replica Sets but whenever the new pod comes up, It comes up with a new IP address. So how the customer or user know about this new IP address ?

***Problem 2***:
If your application requires multiple replicas of a pod to serve multi concurrent users, each replica of a pod has unique IP address but customers or users would need a one common IP address or DNS. Just like we all access google.com(DNS) or 8.8.8.8(IP Address) to access google.

***Problem 3:***
How are the applications deployed as Pods in Kubernetes are accessed by external or people from other teams in your organization who don't have access to the Kubernetes cluster?

To solve these problems Kubernetes service exists. 

>[!info] A Kubernetes **Service** (`svc`)
>A Kubernetes **Service** (`svc`) is an abstraction that defines a logical set of Pods and a policy by which to access them. Services provide a stable IP address and DNS name for Pods, even as they are dynamically created or destroyed. There are several types of services in Kubernetes, each with its use case.

How it works? To solve these problems, when we create a deployment, we also create kubernetes services(**svc**) on top of that.

What services do? 
### 1) It provides **load balancing**

This service access load balancer. Thanks to this, service provide only one IP address or DNS name that is connected to all PODS. Therefore, when for example some users want to access pods, they don't need to use specific IP address of the one POD or several. They can just use the main IP address, that svc provide and then SVC forward this request to POD. This mechanism solves the problem 2

### 2) **Service discovery**

To track all PODs service discovery function doesn't use their IP addresses, because the PODs can be killed anytime, and new PODs with new IP addresses will be created. So, it is not efficient to track it with IP address.

Instead, service use "**labels & selectors**" mechanism to track POD's. It tracks labels, instead of IP addresses. 

What is this?
For every PODs that will be created, we apply label to these PODs(for example we have 3 pods with label "app : payment", ). So, when POD will get destroyed, for newly created POD the label will remain the same. So, the service can still track this POD, even when the IPAddress changed.


For example, when we create deployment, we specify in .yaml file the metadata with this label: "**app: payment**"

![](Attachments/Pasted%20image%2020240927074743.png)



This label will be assigned to every created POD, and whenever some POD will be killed, replica set will create new pod with the same label. Service(svc) will understand that new POT is created, and keep tracking the new POD. 
![](Attachments/Pasted%20image%2020240920182636.png)


***So, problem 1 and 2 solved***

### 3) Expose cluster to external world. 3 Types of services.

Usually we need to expose our cluster to external world to allow people access our application. For such purposes service provides a possibility to expose it.
How it will do it? Whenever we create a deployment, we can specify there, how application should be accessible(like only internally, or also externally). 
We can create a services of 3 types:

### 1. **ClusterIP (Default)**
   - **Description**: This is the default type of service in Kubernetes. It exposes the service on an internal IP address within the cluster, meaning it’s only accessible from within the cluster. Pods inside the cluster can communicate with the service using this internal IP.
   - **Use Case**: This is useful when you want to enable communication between different services or applications running within the Kubernetes cluster, but not from the outside world.
   - **Example**: If you have a backend database service that should only be accessed by frontend services within the cluster, you'd use a `ClusterIP` service.

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: my-internal-service
   spec:
     type: ClusterIP
     selector:
       app: my-app
     ports:
       - protocol: TCP
         port: 80
         targetPort: 8080
   ```

### 2. **NodePort**
   - **Description**: A `NodePort` service exposes the service on a static port (the “node port”) on each node of the cluster. This allows external traffic to access the service by sending requests to any node’s IP address and the node port. The service can be accessed via `NodeIP:NodePort`, making it accessible from outside the cluster, but not as robust as a `LoadBalancer`.
   - **Use Case**: This is useful for development or testing when you want to quickly expose a service to external users without using a cloud load balancer. It’s also used in environments where an external load balancer isn’t available.
   - **Example**: You might use `NodePort` to expose a web application to the outside world when running a local Kubernetes cluster (like Minikube).

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: my-nodeport-service
   spec:
     type: NodePort
     selector:
       app: my-app
     ports:
       - protocol: TCP
         port: 80
         targetPort: 8080
         nodePort: 30007  # The nodePort is typically within the range 30000-32767
   ```

### 3. **LoadBalancer**
   - **Description**: A `LoadBalancer` service exposes the service to external traffic by provisioning an external load balancer (for example, an AWS Elastic Load Balancer, GCP Load Balancer, etc.). This service type is commonly used in cloud environments to automatically provision cloud load balancers that distribute traffic to the pods in your service.
   - **Use Case**: This is ideal for production environments where you need to expose your application to the internet, and it needs to handle incoming traffic efficiently across multiple nodes or instances.
   - **Example**: If you have a web application running in production and you want to expose it to the internet with proper load balancing, you would use a `LoadBalancer`.

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: my-loadbalancer-service
   spec:
     type: LoadBalancer
     selector:
       app: my-app
     ports:
       - protocol: TCP
         port: 80
         targetPort: 8080
   ```

### Summary:
- **ClusterIP**: Internal traffic only (within the cluster).
- **NodePort**: Exposes service externally via each node’s IP and a static port.
- **LoadBalancer**: Exposes the service externally through a cloud provider’s load balancer.

Each type of service has its own use case based on whether the service needs to be accessible internally or externally.