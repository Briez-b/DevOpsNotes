
AWS services for Devops engineers
1. **EC2**
2. **VPC**(private, secure)
3. **EBS** (allow you to add additional volumes to EC2)
4. **S3** (storage)
5. **IAM** (identity and access management, configure permissions for users)
6. **Cloud Watch** (monitoring).
For example some developer can create additional EBS for his machine. With Cloud Watch, you can notice this change and ask the developer for the reasons, why he created it.
7. **Lambda** (serverless serice). It is a compute service that allows you to run code without provisioning or managing servers. For example you can configure lambda to send notifications to developer every time they create EBS, or you can automatically do some action on newly created services. 
8. Cloud Build services : **AWS CodeBuild** **, AWS CodePipeline**, **AWS CodeDeploy**
**AWS CodeBuild** is a fully managed build service that compiles source code, runs tests, and produces software packages that are ready for deployment. 

**AWS CodePipeline** is a continuous integration and continuous delivery service for fast and reliable application and infrastructure updates.

**AWS CodeDeploy** is a deployment service that automates the process of deploying applications to various compute services like EC2, Lambda, and on-premises servers.
(amazon cicd staff)

9. **AWS config**
10. **Billing and costing** (check how many money you or users spend)
11. **AWS KMS** is a managed encryption service. It makes it easy to create and control the encryption keys used to secure your data.
12. **Cloud Trail** AWS CloudTrail is a service that enables you to monitor, log, and retain account activity related to actions taken on your AWS resources.
13. **AWS EKS**Elastic Kubernetes Service). 
14. **AWS ECS** (Elastic Container Service). (also AWS Fargate is used for such purpose). It is simillar to AWS EKS, but it is not based on kubernetes
15. **Amazon OpenSearch Service** is a managed service that simplifies the deployment, operation, and scaling of Elasticsearch clusters. Elasticsearch is a distributed search and analytics engine widely used for log analytics, full-text search, and real-time analytics.
