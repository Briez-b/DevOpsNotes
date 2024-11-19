
### What is Django?

**Django** is a high-level, open-source web framework written in Python that encourages rapid development and clean, pragmatic design. It was originally developed to meet the fast-paced newsroom deadlines of a newspaper, which is why it emphasizes getting work done quickly while maintaining high levels of security and scalability.

This is how the skeleton of such app looks(from example on github):
![](Attachments/Pasted%20image%2020240906163054.png)

I will try to run this app on my own machine:
1) Install python, pip.
``` bash
sudo pacman -S python3
sudo pacman -S python-pip
```
2) Install additional python packages using pip(I also created additional virtual env).
![](Attachments/Pasted%20image%2020240906105143.png)
And then I tried to launch server, but it failed. Nothing works.
The reason is just the wrong address I used. I need to add `/demo` to url
3) Run the application with this command:
``` 
python manage.py runserver
```

Also I deployed this app to EC2 instance with docker:
1) Install docker
2) Create docker file:
![](Attachments/Pasted%20image%2020240906161137.png)
In original dockerfile in Abhishek repository there is no `ENV PIP_BREAK_SYSTEM_PACKAGES 1`. I added it because currently pip is not allow to install packages without setting virtual environment. This line disable this requirement. (I also tried to create env in docker file, but the image wasn't able to execute application because it didn't see Django package).
3) Then build the image. To make this app accesible through port 8000, we need to make a mapping from docker port 8000 to EC2 host port 8000. So add the -p flag to run command:
`docker run -p 8000:8000 -it image-id`

#### Change image to python distro.
1) Find python base image in docker hub
https://hub.docker.com/_/python
2) Change Docker file:
![](Attachments/Pasted%20image%2020240906171732.png)

==come back to Django app to investigate more how it works and maybe improve application==
==for example I can create my own Django project== Check official documentation (added this task to "task note").
For example I can use `dhango-admin startproject mysite`. It will create skeleton of my future Django app.

