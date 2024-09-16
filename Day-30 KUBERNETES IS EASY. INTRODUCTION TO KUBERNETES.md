
The first questions is what is the difference between Docker and Kubernetes? Why we need kubernetes and what is that?

Kubernetes is the container orchestration platform.

Let's start from the beginning.
The problem with containers and docker are:
1) ==Containers is the ephemeral nature==. This means that the life of containers is very short. If there is lack of memory and resources on machine, containers can be easily die. Or if there is no memory left, new containers cannot be created. So the problem is that with docker we have only single host and containers depends on the resources of only one machine.
2) ==No "Auto scaling"==.  As soon as load increased(for example new film on Netflix), usually the amount of containers should be increased. And decreased when there is no high load. This should be done automatically. But in Docker it can only done manually.
3) ==No "Auto healing"==. Containers can be killed any time for 100 of reasons. And user cannot always run them manually in a big environments. So the containers should have a possibility to have run automatically, if some of them was stopped for some reason.
4) ==Docker is very simple==, it doesn't support any enterprise level of support and tools.(for example application should support all of above, firewall, api gateway and etc.).

All these problem Kubernetes solves. How it solves these problems?
1)  For the first problem, Kubernetes is usually a cluster. That means that it can use several nodes, for example one master node and two workers. So it already solves the first problem, if there is a lack of resources on one node, containers can be created on another worker node. 
2) Kubernetes has something called as Replication controller. You can simply go to one Yaml config file, and specify there how many containers should be run. So, whenever we need new containers(for example when receive high load), we can simply add additional replicas in this YAML file(or create some script that will add automatically when traffic high). So, it solves auto scaling problem.
3) Kubernetes has "auto healing" feature. That means, whenever container goes down, new copy of this container will be created.
4) Kubernetes is used in big enterprise projects, it supports a lot of feature needed for such kind of application. And it also supports custom resources(that means you can add your own or external features and tools, that can be used in kubernetes).
