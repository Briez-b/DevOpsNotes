
You can write shell script for GitHub purposes(like check who has an access to certain repository). To find the particular command firstly we need to go to GitHub documentation(google github api doc)
![](Attachments/Pasted%20image%2020240623204452.png)

To use the script, first I cloned it from existing repository. This script requires my username and token that should be generated on github, so I did it:
![](Attachments/Pasted%20image%2020240916185855.png)

![](Attachments/Pasted%20image%2020240916154647.png)

Here is the script and the output:
![](Attachments/Pasted%20image%2020240623210857.png)

![](Attachments/Pasted%20image%2020240623210930.png)

==Improved script. Added new function `helper` to be sure that the script will not be executed if the number of args is not equal 2==
![](Attachments/Pasted%20image%2020240623221031.png)

In Bash, `$#` refers to the number of positional parameters (arguments) passed to a script or function, and `$@` refers to all the positional parameters passed to a script or function. They have different purposes and usage contexts.