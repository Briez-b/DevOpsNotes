==Practice==
## 📊 Metrics in Prometheus:
- Metrics in Prometheus are the core data objects that represent measurements collected from monitored systems.
- These metrics provide insights into various aspects of **system performance, health, and behavior**.

## 🏷️ Labels:
- Metrics are paired with Labels.
- Labels are key-value pairs that allow you to differentiate between dimensions of a metric, such as different services, instances, or endpoints.


## 🔍 Example:
```bash
container_cpu_usage_seconds_total{namespace="kube-system", endpoint="https-metrics"}
```
- `container_cpu_usage_seconds_total` is the metric.
- `{namespace="kube-system", endpoint="https-metrics"}` are the labels.


## 🛠️ What is PromQL?
- PromQL (Prometheus Query Language) is a powerful and flexible query language used to query data from Prometheus.
- It allows you to retrieve and manipulate time series data, perform mathematical operations, aggregate data, and much more.

- 🔑 Key Features of PromQL:
    - Selecting Time Series: You can select specific metrics with filters and retrieve their data.
    - Mathematical Operations: PromQL allows for mathematical operations on metrics.
    - Aggregation: You can aggregate data across multiple time series.
    - Functionality: PromQL includes a wide range of functions to analyze and manipulate data.

## 💡 Basic Examples of PromQL
- `container_cpu_usage_seconds_total`
    - Return all time series with the metric container_cpu_usage_seconds_total
- `container_cpu_usage_seconds_total{namespace="kube-system",pod=~"kube-proxy.*"}`
    - Return all time series with the metric `container_cpu_usage_seconds_total` and the given `namespace` and `pod` labels.
- `container_cpu_usage_seconds_total{namespace="kube-system",pod=~"kube-proxy.*"}[5m]`
    - Return a whole range of time (in this case 5 minutes up to the query time) for the same vector, making it a range vector.

## ⚙️ Aggregation & Functions in PromQL
- Aggregation in PromQL allows you to combine multiple time series into a single one, based on certain labels.
- **Sum Up All CPU Usage**:
    ```bash
    sum(rate(node_cpu_seconds_total[5m]))
    ```
    - This query aggregates the CPU usage across all nodes.

- **Average Memory Usage per Namespace:**
    ```bash
    avg(container_memory_usage_bytes) by (namespace)
    ```
    - This query provides the average memory usage grouped by namespace.

- **rate() Function:**
    - The rate() function calculates the per-second average rate of increase of the time series in a specified range.
    ```bash
    rate(container_cpu_usage_seconds_total[5m])
    ```
    - This calculates the rate of CPU usage over 5 minutes.
- **increase() Function:**
    - The increase() function returns the increase in a counter over a specified time range.
    ```bash
    increase(kube_pod_container_status_restarts_total[1h])
    ```
    - This gives the total increase in container restarts over the last hour.

- **histogram_quantile() Function:**
    - The histogram_quantile() function calculates quantiles (e.g., 95th percentile) from histogram data.
    ```bash
    histogram_quantile(0.95, sum(rate(apiserver_request_duration_seconds_bucket[5m])) by (le))
    ```
    - This calculates the 95th percentile of Kubernetes API request durations.



==I am going to test it by myself==

# PRACTICE

I am going to run some promQL. But first let's add ingress for it:

- **Install AWS load balancer controller**: https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html
First create service account for this load balancer:

![](../Attachments/Pasted%20image%2020241017132910.png)

And install controller:
![](../Attachments/Pasted%20image%2020241017135833.png)

- Added ingress resource and applied it:

![](../Attachments/Pasted%20image%2020241017165449.png)

Now I can access prometheus

![](../Attachments/Pasted%20image%2020241017165534.png)

Now let's try tp get info about certain metrics:

![](../Attachments/Pasted%20image%2020241017172026.png)
To see what metrics available we can expose or connect to services with the metrics (metrics accessible with ip-address:port/metrics)

### I can also use functions: 

Aggregation in PromQL allows you to combine multiple time series into a single one, based on certain labels.
- **Sum Up All CPU Usage**:
    ```bash
    sum(rate(node_cpu_seconds_total[5m]))
    ```
    - This query aggregates the CPU usage across all nodes.

- **Average Memory Usage per Namespace:**
    ```bash
    avg(container_memory_usage_bytes) by (namespace)
    ```
    - This query provides the average memory usage grouped by namespace.

- **rate() Function:**
    - The rate() function calculates the per-second average rate of increase of the time series in a specified range.
    ```bash
    rate(container_cpu_usage_seconds_total[5m])
    ```
    - This calculates the rate of CPU usage over 5 minutes.
- **increase() Function:**
    - The increase() function returns the increase in a counter over a specified time range.
    ```bash
    increase(kube_pod_container_status_restarts_total[1h])
    ```
    - This gives the total increase in container restarts over the last hour.

- **histogram_quantile() Function:**
    - The histogram_quantile() function calculates quantiles (e.g., 95th percentile) from histogram data.
    ```bash
    histogram_quantile(0.95, sum(rate(apiserver_request_duration_seconds_bucket[5m])) by (le))
    ```
    - This calculates the 95th percentile of Kubernetes API request durations.


---

For better visualisation and monitoring features **Grafana** used. Also, Grafana support authentification system(you can use IAM for example to give access to Grafana only to managers).

Add Grafana to ingress so I can access it. 

**Grafana UI**: password is `prom-operator`
I have some predefined dashboard I can use:

![](../Attachments/Pasted%20image%2020241017173232.png)

The example of some dashboard:

![](../Attachments/Pasted%20image%2020241017173329.png)

I can create my own dashboard

![](../Attachments/Pasted%20image%2020241017173503.png)


I can add other source of data to Grafana instead of Prometheus, for example influxDB.

---


# List of some typical metrics people watch in cluster (from cahtgpt)


In a Kubernetes cluster, monitoring key metrics is essential to ensure the health, performance, and stability of your workloads and infrastructure. Here are some typical metrics people commonly monitor in Kubernetes:

### 1. **Node Metrics**
   - **CPU Usage**: 
     - Metric: `node_cpu_usage_seconds_total`
     - What to watch: Total CPU usage on a node, broken down by cores.
     - Importance: Helps monitor overall node load and resource availability.
   - **Memory Usage**:
     - Metric: `node_memory_working_set_bytes`
     - What to watch: Amount of memory in use by a node.
     - Importance: Ensure memory isn’t exhausted, which can cause pods to be evicted.
   - **Disk Usage**:
     - Metric: `node_filesystem_usage_bytes`
     - What to watch: Percentage or total usage of filesystem storage.
     - Importance: Monitor for potential disk bottlenecks or overuse.
   - **Network Traffic**:
     - Metric: `node_network_receive_bytes_total` / `node_network_transmit_bytes_total`
     - What to watch: Network throughput for incoming and outgoing traffic.
     - Importance: Identify network bottlenecks or unusual traffic patterns.

### 2. **Pod and Container Metrics**
   - **Pod CPU Usage**:
     - Metric: `container_cpu_usage_seconds_total`
     - What to watch: Total CPU usage per container.
     - Importance: Detect CPU throttling or over-utilization of pods.
   - **Pod Memory Usage**:
     - Metric: `container_memory_working_set_bytes`
     - What to watch: Total memory in use by a pod.
     - Importance: Identify memory leaks or pods that may require more resources.
   - **Pod Restarts**:
     - Metric: `kube_pod_container_status_restarts_total`
     - What to watch: Total number of restarts for a pod’s containers.
     - Importance: Frequent restarts could indicate underlying issues, like crashes or resource constraints.
   - **Container Uptime**:
     - Metric: `kube_pod_container_status_running`
     - What to watch: Number of seconds the container has been running.
     - Importance: Ensures that containers are staying up and running without unexpected terminations.
     
### 3. **Cluster Metrics**
   - **Pod Scheduling Rate**:
     - Metric: `kube_pod_status_phase`
     - What to watch: The phase of pods (Pending, Running, Succeeded, Failed).
     - Importance: Helps identify if pods are stuck in a Pending state (e.g., due to resource constraints).
   - **Number of Nodes**:
     - Metric: `kube_node_info`
     - What to watch: Total number of active nodes in the cluster.
     - Importance: Make sure all nodes are online and working as expected.
   - **Node Availability**:
     - Metric: `kube_node_status_condition`
     - What to watch: Conditions such as `Ready`, `OutOfDisk`, and `MemoryPressure`.
     - Importance: Monitor node health to detect whether nodes are functioning or experiencing problems.
   
### 4. **Kubernetes API Metrics**
   - **API Server Request Latency**:
     - Metric: `apiserver_request_duration_seconds`
     - What to watch: Latency in seconds for requests to the Kubernetes API.
     - Importance: High latencies can indicate problems with the API server or overloading.
   - **API Request Rate**:
     - Metric: `apiserver_request_total`
     - What to watch: Number of requests being made to the Kubernetes API.
     - Importance: Helps identify potential overuse of the API, which could cause throttling.

### 5. **Scheduler Metrics**
   - **Scheduling Latency**:
     - Metric: `scheduler_scheduling_algorithm_duration_seconds`
     - What to watch: Time taken to schedule pods.
     - Importance: High scheduling latency could indicate a lack of available resources or inefficiencies in the scheduling process.
   - **Scheduling Attempts**:
     - Metric: `scheduler_schedule_attempts_total`
     - What to watch: Count of scheduling attempts (Success/Failure).
     - Importance: Detect if there are many failed scheduling attempts, possibly due to resource constraints.

### 6. **Etcd Metrics**
   - **Etcd Disk I/O Latency**:
     - Metric: `etcd_disk_backend_commit_duration_seconds`
     - What to watch: Time taken to commit data to disk in etcd.
     - Importance: High disk I/O latency could impact the performance of the entire cluster.
   - **Etcd Leader Elections**:
     - Metric: `etcd_server_has_leader`
     - What to watch: Status of etcd leader election process.
     - Importance: Frequent leader elections may indicate instability in etcd, which can disrupt the cluster.

### 7. **Ingress and Service Metrics**
   - **Request Rate**:
     - Metric: `nginx_ingress_controller_requests`
     - What to watch: Number of HTTP requests per second through an Ingress.
     - Importance: Monitor traffic and detect spikes or sudden drops.
   - **Response Latency**:
     - Metric: `nginx_ingress_controller_request_duration_seconds`
     - What to watch: Response latency for requests through an Ingress.
     - Importance: High latencies can indicate problems with the Ingress, backend services, or networking.

### 8. **Application Metrics**
   - **Custom Metrics (from Prometheus exporters)**:
     - Metric: `http_requests_total`, `process_cpu_seconds_total`, `process_resident_memory_bytes`, etc.
     - What to watch: Application-specific metrics such as request rate, response times, or memory usage.
     - Importance: Tailor to your application's performance needs and track how well the application is running within the Kubernetes environment.

### 9. **Helm Chart/Deployment Metrics**
   - **Replica Availability**:
     - Metric: `kube_deployment_status_replicas_available`
     - What to watch: Number of available replicas for a deployment.
     - Importance: Ensure that the desired number of replicas are up and running.
   - **Rollout Status**:
     - Metric: `kube_deployment_status_updated_replicas`
     - What to watch: Track how many pods have been updated during a deployment.
     - Importance: Monitor progress of updates and rollbacks during deployments.

---

Monitoring these metrics using tools like **Prometheus**, **Grafana**, and **Kubernetes Dashboards** helps ensure that your cluster is running optimally, provides insights for scaling decisions, and allows early detection of problems like resource exhaustion or misconfigurations.