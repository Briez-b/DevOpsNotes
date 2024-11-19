
## Identifying Stale EBS Snapshots

In this example, we'll create a Lambda function that identifies EBS snapshots that are no longer associated with any active EC2 instance and deletes them to save on storage costs.

### Description:

The Lambda function fetches all EBS snapshots owned by the same account ('self') and also retrieves a list of active EC2 instances (running and stopped). For each snapshot, it checks if the associated volume (if exists) is not associated with any active instance. If it finds a stale snapshot, it deletes it, effectively optimizing storage costs.


1) Let's create a snapshot of the ec2 instance's volume

![](../Attachments/Pasted%20image%2020241117210902.png)

2) Create Lambda function

The code:
![](../Attachments/Pasted%20image%2020241117212734.png)

![](../Attachments/Pasted%20image%2020241117213141.png)


![](../Attachments/Pasted%20image%2020241117213228.png)

And it is failed because it doesn't have permissions to snapshots:

![](../Attachments/Pasted%20image%2020241117213322.png)

3) Add permissions to Lambda func role:

![](../Attachments/Pasted%20image%2020241117213530.png)

If I look for snapshot policy, it will be difficult to find exactly what I needed. So I can create my own policy:

![](../Attachments/Pasted%20image%2020241117213738.png)

![](../Attachments/Pasted%20image%2020241117213907.png)

![](../Attachments/Pasted%20image%2020241117214031.png)

New policy added. But we still have error:

![](../Attachments/Pasted%20image%2020241117214815.png)

Need to add "describe volumes" and "describe instances" permissions.

![](../Attachments/Pasted%20image%2020241117220548.png)

And finally function works:

![](../Attachments/Pasted%20image%2020241117215050.png)

Sometimes my func failed. I need to increase execution time (by default it is 3 sec)

![](../Attachments/Pasted%20image%2020241117215755.png)

4) Delete the instance and execute script. All not attached snapshots removed. 

![](../Attachments/Pasted%20image%2020241117220625.png)

I can add the trigger for lambda function.


![](../Attachments/Pasted%20image%2020241117224113.png)



![](../Attachments/Pasted%20image%2020241117224034.png)



The script explanation from chat gpt

This Python script, designed to run as an **AWS Lambda function**, automates the cleanup of unused **EBS snapshots** to save storage costs. Here's a detailed explanation of what the script does:

---

### **1. Importing Libraries**
```python
import boto3
```
- **boto3**: The AWS SDK for Python, used to interact with AWS services.
- This script uses **boto3** to interact with the **EC2** service for managing snapshots, volumes, and instances.

---

### **2. Lambda Handler Function**
```python
def lambda_handler(event, context):
```
- This is the entry point for the Lambda function.
- AWS triggers this function when an event occurs. The function receives two parameters:
  - `event`: Contains information about the trigger.
  - `context`: Provides runtime information about the Lambda function.

---

### **3. Initialize EC2 Client**
```python
ec2 = boto3.client('ec2')
```
- Initializes a **client** to interact with the **EC2 service**.

---

### **4. Get All EBS Snapshots**
```python
response = ec2.describe_snapshots(OwnerIds=['self'])
```
- Retrieves all EBS snapshots owned by the AWS account (`OwnerIds=['self']`).

---

### **5. Get Active EC2 Instance IDs**
```python
instances_response = ec2.describe_instances(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
active_instance_ids = set()
```
- Filters EC2 instances to get only **running instances** (`instance-state-name = running`).
- `active_instance_ids`: A set to store the IDs of active instances.
==Not used later in the script. Just an example==
---

### **6. Collect Active Instance IDs**
```python
for reservation in instances_response['Reservations']:
    for instance in reservation['Instances']:
        active_instance_ids.add(instance['InstanceId'])
```
- Iterates through the response to extract all running EC2 instance IDs and stores them in `active_instance_ids`.
==Not used later in the script. Just an example==
---

### **7. Iterate Through Snapshots**
```python
for snapshot in response['Snapshots']:
    snapshot_id = snapshot['SnapshotId']
    volume_id = snapshot.get('VolumeId')
```
- Loops through all snapshots.
- Extracts:
  - `snapshot_id`: The ID of the snapshot.
  - `volume_id`: The ID of the volume from which the snapshot was created (if it exists).

---

### **8. Handle Snapshots Not Attached to Any Volume**
```python
if not volume_id:
    ec2.delete_snapshot(SnapshotId=snapshot_id)
    print(f"Deleted EBS snapshot {snapshot_id} as it was not attached to any volume.")
```
- If `volume_id` is `None`, it means the snapshot is not associated with any volume, so the script deletes it.

---

### **9. Handle Snapshots with Associated Volumes**
```python
try:
    volume_response = ec2.describe_volumes(VolumeIds=[volume_id])
    if not volume_response['Volumes'][0]['Attachments']:
        ec2.delete_snapshot(SnapshotId=snapshot_id)
        print(f"Deleted EBS snapshot {snapshot_id} as it was taken from a volume not attached to any running instance.")
```
- Checks if the associated volume exists:
  - Retrieves the volume's details using `describe_volumes`.
  - Checks if the volume is **not attached** to any instance (`Attachments` list is empty).
  - If not attached, the snapshot is deleted.

---

### **10. Handle Nonexistent Volumes**
```python
except ec2.exceptions.ClientError as e:
    if e.response['Error']['Code'] == 'InvalidVolume.NotFound':
        ec2.delete_snapshot(SnapshotId=snapshot_id)
        print(f"Deleted EBS snapshot {snapshot_id} as its associated volume was not found.")
```
- If the volume does not exist (possibly deleted), the `describe_volumes` call raises a `ClientError` with code `InvalidVolume.NotFound`.
- In this case, the snapshot is deleted since its source volume no longer exists.

---

### **Key Features:**

1. **Automated Cleanup**:
   - Deletes snapshots that are no longer associated with active volumes or running instances.
   
2. **Cost Savings**:
   - By cleaning up unused snapshots, the script helps reduce storage costs.

3. **Error Handling**:
   - Handles cases where volumes are deleted or snapshots are orphaned.

4. **Efficient Use of Resources**:
   - Targets only snapshots that are no longer useful, avoiding accidental deletions.

---

### **Considerations and Limitations:**
- **IAM Permissions**: Ensure the Lambda function has the following permissions:
  - `ec2:DescribeSnapshots`
  - `ec2:DescribeInstances`
  - `ec2:DescribeVolumes`
  - `ec2:DeleteSnapshot`
  
- **Timing**: The function should be scheduled periodically (e.g., daily) using an AWS EventBridge rule.

- **Region-Specific**: This script operates in the same AWS region as the Lambda function. For multi-region setups, you would need to modify the code.

---

Would you like help deploying this function or extending its functionality?