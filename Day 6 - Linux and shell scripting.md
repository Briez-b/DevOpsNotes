### Day-6 | ==Linux & Shell Scripting==

Create file
`touch filename.txt`
Show the content of the file in terminal
`cat filenametxt`

Look for memory
`free -g`
Look how many CPU
`nproc`
Look how many storage is available and used
`df -h`
All these things in one place
`top`
Use `-b` and `-n` flags to print the info in console. `-b` is non interactive mode. `-n` is the number of iterations
`top -b -n 1`
Cout the text:
`echo "needed text"`

---
### ==Extra lection for shell==

### Video 1 # Shell Scripting Zero 2 Hero
This is how to write shell script:
every script should be started with "she-bang" at the beginning:
`#!/bin/bash`

Be sure the file is allowed to be executable. Use chmod.
Permission for everyone:
`chmod 777`
4(r) + 2(w) + 1(x)  rwx    |read, write and execute|

Reveal all the command used in terminal:
`history`


### Video 2 Shell Scripting Zero 2 Hero 2

Interview question: the difference between `#!/bin/sh` and `#!/bin/bash`?
Before it was the same because sh was a link to bash. But now some OS use sh as link to another shells (like dash in ubuntu).

Some useful commands:

![](Images/Pasted%20image%2020240617103251.png)
To grep some processes we can use this command. For example show all processes runned by amazon:
`ps -ef | grep "amazon"`

==Interview question==
What is the output of this command? 

![](../Images/Pasted%20image%2020240617103714.png)
Another important command. Show only a info from 3 column using `awk`:
`ps -ef | grep "amazon" | awk -F" " '{print $2}'

![](../Images/Pasted%20image%2020240622190621.png)

To get the content from the internet  use `curl`:

![](../Images/Pasted%20image%2020240622193410.png)

The analog of this command is:
`curl -X GET https://yourhttpling.com`
To download the file use `wget`
`wget https://site.com/yourfile.txt

To find the file by the name use `find`
![](../Images/Pasted%20image%2020240622194157.png)

"If else" condition for scripts:
![](../Images/Pasted%20image%2020240622194425.png)

"For loop" in shell scripting:

Another method of using if and for loops using (( )) for arithmetic and increment operators:
![](../Images/Pasted%20image%2020240622200945.png)

Not very usefull command,but I left it there because it uses "SIGNALS". Signals are the thing that we are send to the terminal. For example ctrl + C:
![](../Images/Pasted%20image%2020240622201335.png)
SIGINT is "ctr + c".


---
