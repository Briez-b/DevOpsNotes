
>[!info] RBAC
>Kubernetes RBAC (Role-Based Access Control) is a security mechanism that regulates access to Kubernetes resources based on the roles assigned to users, groups, or service accounts. It defines granular permissions for performing specific actions (like `get`, `create`, `delete`) on resources within a cluster, either at the namespace or cluster level, by associating roles (Role/ClusterRole) with subjects via RoleBindings or ClusterRoleBindings.

This definition doesn't tell me a lot, so let's understand what is it and how to use it.

### Firstly, we can divide RBAC mechanism into 2 parts:
##### 1) Users management
In real organisations, usually devops engineer has to define accesses for people who has access to the cluster, what resources they allowed to use(for example, developers can only have access to only  services within "Develop" namespace).     
##### 2) Service accounts management
The same as user management, but for Services.
We define what access should have Services, like give some Service access to the folders, namespaces, other services and etc.

### How does it all work? 
To manage all this staff we have 3 major things in RBAC:
1) Service account / Users.
2) Roles / Cluster Role
3) Role binding / CRB

Firstly, we have to understand, Kubernetes doesn’t handle user management internally (like Linux with `useradd`). Instead, it delegates authentication to external Identity Providers, like **AWS IAM**.
This is similar to how many real-world applications, like Instagram or Facebook, allow users to log in using Google accounts or other third-party providers without requiring a direct registration. Kubernetes relies on these external systems for user authentication rather than managing users directly within the cluster.

Service account easily created by .yaml files. Also, service accounts created by default any time we create any pod. So the question is, how we config rules for these service accounts? How we define, what accesses it should have. 
For this Role and Role binding mechanisms used:
1) We create **Role** and describe there what accesses it should have. Role grants permissions only inside the namespace it was created, if we want access outside the namespace, we create **Cluster Role**
2) We should attach this role to user(or group of users). For this, **Role binding** mechanism used. After Role attached to someone, this user has access to all resources we described inside the Role. The same is for Service accounts, we can attach it to them as well.

