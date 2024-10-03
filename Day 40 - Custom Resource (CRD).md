We can enhance the behaviour of our kubernetes. To do it, custom resource mechanism exists. 
With this mechanism we can install any resource we need.
>[!info] Custom resource
>A **Custom Resource (CR)** in Kubernetes is an extension of the Kubernetes API that allows you to define and manage your own resource types, similar to built-in resources like Pods or Services. Custom Resources enable you to store and retrieve structured data using Kubernetes API, providing flexibility to extend Kubernetes capabilities without modifying the core code.

To extend kubernetes functionality 3 things exit:
#### 1) CRD (Custom resource definition)
#### 2) CR (custom resource)

CRD is a way to extend the Kubernetes API by defining a new custom resource type (**CRD**). This allows you to create and manage objects beyond the built-in Kubernetes resources (like Pods, Services, etc.). For example, a DevOps engineer can create a CRD using a `.yaml` file to define a new resource type, and later we can create such resources with another `custom-resource.yaml`(like `deployment.yaml`) which can then be managed just like any other Kubernetes resource via `kubectl`.

![](Attachments/Pasted%20image%2020241003125300.png)
The difference between a standard Kubernetes **resource** (like a Deployment) and a **Custom Resource** (CR). On the left side, a YAML file defines a standard resource (such as a Deployment), and Kubernetes handles its lifecycle based on this predefined resource type. On the right side, a **Custom Resource** (e.g., Virtual Service) is defined via YAML, and its lifecycle is managed by a Custom Resource Definition (**CRD**), which extends Kubernetes to recognize this new resource type. The CRD allows validation and extension of the resource’s behavior, enabling Kubernetes to manage custom resources just like built-in ones.

#### 3) Custom controller

As for other resources, controller should be present, to manage the behaviour of our resources(like Deployment controller for ReplicaSet). 
For such porpose we should definbe and deploy **Custom controller**.

The **custom controller** constantly watches for changes in the state of the custom resources and takes actions to bring the actual state closer to the desired state defined in the CRD.

### How we usually add Custom resources?
1) We deploy new CRD. Let's call it Virtual Service CRD: it can be done manually(using `manifest.yaml`), it can be installed with helm charts or operator.
2) We create **Custom Resource** and deploy it: create `virtual-service.yaml` and apply it. It is validated my `virtual-service CRD`
3) We deploy **Custom controller**.
Examples of tools with their own custom controllers present here. https://www.cncf.io/

Practical implementation of sample controller. https://github.com/kubernetes/sample-controller
