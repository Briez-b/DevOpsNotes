
Before we were using only one stage builds. But there is a  posibility to make several stages during the buyilding you image.
Let's see what do I mean and why do we need this.
With one stage build in Dockerfile we do:
1) We take one image as base for example ubuntu(iut can be ~800 mb just for an example)
2) We create work directory, copy our code , install all dependencies we need with command like apt-get, maybe using some other shell commands.
3) Finally we execute something in CMD (maybe our application script)
With this way we build only one build based on ubuntu, and the final size of our image can be more then 1 GB.

So another way of building our images exists, that is multistage build.
For our final image we don't need anymore any shell commands and other ubuntu libs as it is only required during installation of our dependencies for our application (let's it be python app, we install python and pip wit apt-get). 
With multistage build we can install all of this dependencies during the first step and copy `bin` folder to another very lightweight build that will be created in stage 2, so our first build will not be needed anymore:\
1 stage:
1) We take one image as base for example ubuntu(iut can be ~800 mb just for an example)
2) We create work directory, copy our code , install all dependencies we need with command like apt-get, maybe using some other shell commands. 1 stage is finished.
2 stage:
3) We take another base image, but very lightweitgh (it can be ~200 mb, sometimes even less)
4) Copy the folder with needed packages and libs from 1st build into 2nd.
5) Execute needed cmd command to launch our application.
With such approach our final image will be less then 500 mb, and we can reduce it even more.

Such very lightweight base images we used in stage 2 called ==distroless images==. Such images usually doesn't contain even commands like `ls, curl, grep` and etc. There is only packages we need(depends on build we choose, for example we can take the image only with "python runtime"). With such build we can even raise our security because of the reasons above.



This is an example of golang app(just calculator) with one stage build:

![](Attachments/Pasted%20image%2020240907115141.png)

Such image will take ==~850 mb.==

Let's do the same, but with multistage build:
1) Create our app that will be deployed on docker image
![](Attachments/Pasted%20image%2020240907114924.png)


2) Create Dockerfile:
![](Attachments/Pasted%20image%2020240907121304.png)
3) Now we can see the size is only 1.96 mb
This is just an example. In real cases it is better to use goland distroless image:
```
# Build stage
FROM golang:1.19 AS builder
WORKDIR /app
COPY . .
RUN go build -o myapp

# Run stage
FROM gcr.io/distroless/base
COPY --from=builder /app/myapp /myapp
CMD ["/myapp"]

```
Python multistage build:
![](Attachments/Pasted%20image%2020240907125952.png)
It takes only 52,8 mb

NodeJs example:
![](Attachments/Pasted%20image%2020240907130256.png)

More examples here: https://github.com/GoogleContainerTools/distroless

