Before devops, there were a lot of servers used for development. To configure these servers, system administrators had to write shell scripts for different types of machines. That was inefficient. Later, when development moved to cloud platforms, the amount of servers significantly increased. To handle configuration, the Configuration Management concept was created. To handle Conf Management, such tools created:
1. Puppet
2. Chef
3. Ansible

But the most used is **Ansible**

The difference between Ansible and other CM tools:
![](Attachments/Pasted%20image%2020240825173612.png)

- **Puppet**:
    
    - **Architecture**: Puppet uses a pull model where agents regularly check in with the Puppet Master to fetch configurations.
    - **Agent-Based**: Requires an agent to be installed on each managed node.
- **Ansible**:
    
    - **Architecture**: Ansible uses a push model where configurations are sent out from the control machine to the managed nodes.
    - **Agentless**: Does not require any agents on the managed nodes, simplifying setup and reducing overhead.

