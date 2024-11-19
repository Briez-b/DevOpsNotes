
# Loops in Python (for and while)

## Introduction

Loops are a fundamental concept in programming, and they allow you to perform repetitive tasks efficiently. In Python, there are two primary types of loops: "for" and "while."

## For Loop

The "for" loop is used to iterate over a sequence (such as a list, tuple, string, or range) and execute a set of statements for each item in the sequence. The loop continues until all items in the sequence have been processed.

**Syntax:**

```python
for variable in sequence:
    # Code to be executed for each item in the sequence
```

**Example:**

```python
fruits = ["apple", "banana", "cherry"]
for fruit in fruits:
    print(fruit)
```

**Output:**

```
apple
banana
cherry
```

In this example, the loop iterates over the "fruits" list, and in each iteration, the "fruit" variable takes on the value of the current item in the list.

#### While Loop

The "while" loop continues to execute a block of code as long as a specified condition is true. It's often used when you don't know in advance how many times the loop should run.

**Syntax:**

```python
while condition:
    # Code to be executed as long as the condition is true
```

**Example:**

```python
count = 0
while count < 5:
    print(count)
    count += 1
```

**Output:**

```
0
1
2
3
4
```

In this example, the "while" loop continues to execute as long as the "count" is less than 5. The "count" variable is incremented in each iteration.


---

# Loop Control Statements (break and continue)

## Introduction

Loop control statements are used to modify the behavior of loops, providing greater control and flexibility during iteration. In Python, two primary loop control statements are "break" and "continue."

## `break` Statement

The "break" statement is used to exit the loop prematurely. It can be applied to both "for" and "while" loops, allowing you to terminate the loop when a particular condition is met.

**Example:**

```python
numbers = [1, 2, 3, 4, 5]
for number in numbers:
    if number == 3:
        break
    print(number)
```

**Output:**

```
1
2
```

In this example, the loop stops when it encounters the number 3.

## `continue` Statement

The "continue" statement is used to skip the current iteration of the loop and proceed to the next one. It can be used in both "for" and "while" loops, enabling you to bypass certain iterations based on a condition.

**Example:**

```python
numbers = [1, 2, 3, 4, 5]
for number in numbers:
    if number == 3:
        continue
    print(number)
```

**Output:**

```
1
2
4
5
```

In this example, the loop skips the iteration where the number is 3 and continues with the next iteration.

## Practice Exercise - Automating Log File Analysis

#### Introduction

In this practice exercise, we use a "for" loop to automate the analysis of a log file and identify lines containing the word "error." This demonstrates how loops can be used to process data and extract relevant information efficiently.

**Example:**

```python
log_file = [
   "INFO: Operation successful",
   "ERROR: File not found",
   "DEBUG: Connection established",
   "ERROR: Database connection failed",
]

for line in log_file:
   if "ERROR" in line:
       print(line)
```

**Output:**

```
ERROR: File not found
ERROR: Database connection failed
```

In this exercise, the loop iterates through the "log_file" list and prints lines containing the word "ERROR."

---

# For Loop DevOps use-cases

1. **Server Provisioning and Configuration:**

   DevOps engineers use "for" loops when provisioning multiple servers or virtual machines with the same configuration. For example, when setting up monitoring agents on multiple servers:

   ```bash
   servers=("server1" "server2" "server3")
   for server in "${servers[@]}"; do
       configure_monitoring_agent "$server"
   done
   ```

2. **Deploying Configurations to Multiple Environments:**

   When deploying configurations to different environments (e.g., development, staging, production), DevOps engineers can use a "for" loop to apply the same configuration changes to each environment:

   ```bash
   environments=("dev" "staging" "prod")
   for env in "${environments[@]}"; do
       deploy_configuration "$env"
   done
   ```

3. **Backup and Restore Operations:**

   Automating backup and restore operations is a common use case. DevOps engineers can use "for" loops to create backups for multiple databases or services and later restore them as needed.

   ```bash
   databases=("db1" "db2" "db3")
   for db in "${databases[@]}"; do
       create_backup "$db"
   done
   ```

4. **Log Rotation and Cleanup:**

   DevOps engineers use "for" loops to manage log files, rotate logs, and clean up older log files to save disk space.

   ```bash
   log_files=("app.log" "access.log" "error.log")
   for log_file in "${log_files[@]}"; do
       rotate_and_cleanup_logs "$log_file"
   done
   ```

5. **Monitoring and Reporting:**

   In scenarios where you need to gather data or perform checks on multiple systems, a "for" loop is handy. For example, monitoring server resources across multiple machines:

   ```bash
   servers=("server1" "server2" "server3")
   for server in "${servers[@]}"; do
       check_resource_utilization "$server"
   done
   ```

6. **Managing Cloud Resources:**

   When working with cloud infrastructure, DevOps engineers can use "for" loops to manage resources like virtual machines, databases, and storage across different cloud providers.

   ```bash
   instances=("instance1" "instance2" "instance3")
   for instance in "${instances[@]}"; do
       resize_instance "$instance"
   done
   ```

---

# While Loop DevOps Usecases

DevOps engineers often use "while" loops in various real-time use cases to automate, monitor, and manage infrastructure and deployments. Here are some practical use cases from a DevOps engineer's perspective:

1. **Continuous Integration/Continuous Deployment (CI/CD) Pipeline:**

   DevOps engineers often use "while" loops in CI/CD pipelines to monitor the deployment status of applications. They can create a "while" loop that periodically checks the status of a deployment or a rolling update until it completes successfully or fails. For example, waiting for a certain number of pods to be ready in a Kubernetes deployment:

   ```bash
   while kubectl get deployment/myapp | grep -q 0/1; do
       echo "Waiting for myapp to be ready..."
       sleep 10
   done
   ```

2. **Provisioning and Scaling Cloud Resources:**

   When provisioning or scaling cloud resources, DevOps engineers may use "while" loops to wait for the resources to be fully provisioned and ready. For instance, waiting for an Amazon EC2 instance to become available:

   ```bash
   while ! aws ec2 describe-instance-status --instance-ids i-1234567890abcdef0 | grep -q "running"; do
       echo "Waiting for the EC2 instance to be running..."
       sleep 10
   done
   ```

3. **Log Analysis and Alerting:**

   DevOps engineers can use "while" loops to continuously monitor logs for specific events or errors and trigger alerts when a certain condition is met. For example, tailing a log file and alerting when an error is detected:

   ```bash
   while true; do
       if tail -n 1 /var/log/app.log | grep -q "ERROR"; then
           send_alert "Error detected in the log."
       fi
       sleep 5
   done
   ```

4. **Database Replication and Data Synchronization:**

   DevOps engineers use "while" loops to monitor database replication and ensure data consistency across multiple database instances. The loop can check for replication lag and trigger corrective actions when necessary.

   ```bash
   while true; do
       replication_lag=$(mysql -e "SHOW SLAVE STATUS\G" | grep "Seconds_Behind_Master" | awk '{print $2}')
       if [ "$replication_lag" -gt 60 ]; then
           trigger_data_sync
       fi
       sleep 60
   done
   ```

5. **Service Health Monitoring and Auto-Recovery:**

   DevOps engineers can use "while" loops to continuously check the health of services and automatically trigger recovery actions when services become unhealthy.

   ```bash
   while true; do
       if ! check_service_health; then
           restart_service
       fi
       sleep 30
   done
   ```


