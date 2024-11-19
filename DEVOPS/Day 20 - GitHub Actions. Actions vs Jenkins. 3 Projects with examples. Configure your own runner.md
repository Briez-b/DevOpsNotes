

### Adding GitHub Actions to my repository
1) I created .github/workflows repository and added there `first-actions.yml` file. This is our pipeline:
![](Attachments/Pasted%20image%2020240831212757.png)
 Such syntax like `- uses: actions/checkout@v3` means that checkout@v3 plugin will be used. All such plugins you can find in github doc.
2) Added `addition.py` to new folder `action-test`. This is simple hardcoded python test. 
![](Attachments/Pasted%20image%2020240831212942.png)

After that I just pushed it on draft, the Ci automatically starting based on `first-actions.yml`. 
![](Attachments/Pasted%20image%2020240831213110.png)
![](Attachments/Pasted%20image%2020240831213140.png)

Now for every new commit in this repository (on branches where action file present), Ci will be executed.
You can read more in GitHub actions doc.

Also you can use gitHub  secrets, for example write the keys to the setting of the GitHub repository and use variables in .yml file:
![](Attachments/Pasted%20image%2020240831215157.png)
##### If you want to use your own runner(for example your own EC2 instance with docker how we done before with jenkins), you can set it in config:
1) Create EC2 instance and set inbound and outbound rule: 
![](Attachments/Pasted%20image%2020240831220357.png)

2) Execute all commands on your EC2
![](Attachments/Pasted%20image%2020240831221316.png)

3) Change to `self-hosted`
![](Attachments/Pasted%20image%2020240831222403.png)
4) After that EC2 instance will be listnning for any commit on github repository
## Comparing with Jenkins

### Advantages of GitHub Actions over Jenkins

- Hosting: Jenkins is self-hosted, meaning it requires its own server to run, while GitHub Actions is hosted by GitHub and runs directly in your GitHub repository.

- User interface: Jenkins has a complex and sophisticated user interface, while GitHub Actions has a more streamlined and user-friendly interface that is better suited for simple to moderate automation tasks.

- Cost: Jenkins can be expensive to run and maintain, especially for organizations with large and complex automation needs. GitHub Actions, on the other hand, is free for open-source projects and has a tiered pricing model for private repositories, making it more accessible to smaller organizations and individual developers.
### Advantages of Jenkins over GitHub Actions

- Integration: Jenkins can integrate with a wide range of tools and services, but GitHub Actions is tightly integrated with the GitHub platform, making it easier to automate tasks related to your GitHub workflow.

In conclusion, Jenkins is better suited for complex and large-scale automation tasks, while GitHub Actions is a more cost-effective and user-friendly solution for simple to moderate automation needs.
