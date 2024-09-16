
1. Clone the desired app to local repository: https://github.com/verma-kunal/AWS-Session
2. Test if this app works locally: create `.env` file and copy there template from instruction on github(and fill the variables):
![](Attachments/Pasted%20image%2020240916160058.png)

3. `npm install` and `npm run start`. Now I am able to run this app in browser with domain name.
Now the app is installed on local machine. Now let's install it on aws EC2 machine

4. Connect to EC2 instance. Then install `node` and `npm`.
5. Set variables in .env the same way as before
6. `npm install` and `npm run start`. The application still can't be run as we need to add inbound rule to security group of our EC2 instance:
![[Screenshot from 2024-08-25 14-01-15.png)

7. Now it is can be run with this address: public ip of ec2 instance and port(http://52.28.243.198:3000/)

