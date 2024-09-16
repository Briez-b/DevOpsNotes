
First we need to configure ansible to make him able to connect to machines(passwordless connection).
1. Use this command to have a connection to 54.93.165.98 machine:

`ssh-copy-id -f "-o IdentityFile $PATHTOPEMKEY" ubuntu@54.93.165.98`

2. I got this line:

``Now try logging into the machine, with:   "ssh -o ' IdentityFile ./NewPairKeyBriez.pem' 'ubuntu@54.93.165.98' and check to make sure that only the key(s) you wanted were added`

Execute this command. And exit from the machine.
3. Now I am able to connect to this machine without any key file, just using `ssh ubuntu@54.93.165.98`

First we need to create an inventory file to describe there IP addresses of machines.

![](Attachments/Pasted%20image%2020240825202754.png)

To execute something more complicated, playbook files used. But if you want to do something very simple, we can just execute one ansible command called ad hoc command:

![](Attachments/Pasted%20image%2020240825202944.png)

After that I am able to see `fileCreatedByAnsible` file on both machines.
To understand what is -m and what modules should I use, you can check official documentation. https://docs.ansible.com/ansible/2.9/modules/list_of_all_modules.html
Later you can check documentation and try it by yourself

Also I can group my machines in inventory file:

![](Attachments/Pasted%20image%2020240825203707.png)

Now I can use group instead of all. For example
`ansible -i inventory develop -m "shell" -a "touch fileCreatedByAnsible2"`

==Using playbook==:
If I want for instance install nginx on both machines, I can write a playbook for this. So we need to create a .yml file. firstPlaybook.yml:

![](Attachments/Pasted%20image%2020240825205539.png)

typo, instead of `root` use `true`

`ansible-playbook -i /home/ansible/inventory firstPlaybook.yml`

![](Attachments/Pasted%20image%2020240825205958.png)

To do more complex playbooks, you can use the ansible role. For example:
![](Attachments/Pasted%20image%2020240825210723.png)
Here we create kubernetes role. Using these folders we can structure our playbooks. More about it here: 
https://github.com/ansible/ansible-examples
