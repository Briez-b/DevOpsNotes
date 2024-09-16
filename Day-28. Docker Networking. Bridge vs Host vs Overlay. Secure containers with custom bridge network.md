
Often we need a way to have containers communicating each other or an opposite, do not have a possibility to communicate.
For example we can have such 2 scenarios:
1) We have 2 containers, one is Frontend, another Backend. They deffenetly should communicate each other.
2) We have 2 container. The aim of one is log in / out operations, Another one is some payment related staff. We deffenetly don't want to have possible a communication between each other to increase security.

==Let's find out what is happening with communication between container and host when it is created:==
Host machine has it is own Ethernet network interface. For my arch linux machine it is called enp0s31f6 and it has IP 192.168.166.223. Also there is a network for my docker: docker0 172.17.0.1.
![](Attachments/Pasted%20image%2020240908132427.png)

When docker run a container, the container has it is own network interface, but it can't be used to communicate to host. 
But when any container is run, docker use additional virtual network interface called bridge and assign free IP address to
new container, which can be used for such purpose:
![](Attachments/Pasted%20image%2020240908133355.png)
Here is the bridge network info. we can use any IP address within the subnet `172.17.0.0/16` except the gateway (`172.17.0.1`) and the IP addresses already assigned to running containers. For example, you could use an IP address like `172.17.0.3`, `172.17.0.4`, etc., as long as it's not already in use by another container. But it is better to let docker assign it automatically, when it creates container.

The assigned Ip address for our container
![](Attachments/Pasted%20image%2020240908133755.png)

So, let's come back to examples above.
### First example scenario(frontend and backend container): 
Containers should have a possibility for communication with each other.

There is no need to do anything else, by default newly created containers use the same "bridge" network interface, so just next IPAddress assigned, therefore they can communicate each other by default.
![](Attachments/Pasted%20image%2020240908135419.png)
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

![](Attachments/Pasted%20image%2020240908142806.png)

Ip of the second:

![](Attachments/Pasted%20image%2020240908142731.png)

They have different subnet now, they will not able to communicate each other.

==come back to devops playlist later, there is one video I missed for now==

