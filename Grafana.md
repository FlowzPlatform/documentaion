### (1) From the CATALOG section in rancher ADD Prometheus.
```
This will install all the requirements for Grafana and Prometheus, 
Like : node_exporter, Cadvisor, Grafana and Prometheus.
```
### (2) From the Proemetheus Stack open Grafana which is running in default 3000 Port.
```
Enter Default username: admin
 and  Default password: admin
```
### (3) Once you are in Grafana home(dashboard) page you are ready to go.
### (4) Now create new dashboard and add different graphs. 
```
Like : CPU usage, Memory, Hard-disk, Network. 
```
### (5) Best way is to import dashboard from .json file 


   [Mysql-monitoring.json](https://github.com/FlowzPlatform/documentation/blob/master/Flowz_Grafana_Dashboard/MY-SQL%20monitoring-1530192869956.json)


### (6) now you have to change in this dashboard.

*** 
```
              (1) Variables's value :  ---> node_exporter's ip
                                       ---> Cadvisor's ip
                                       
              (2) in CPU Graph : ---> instance value (node_exporter's ip)
                                 --->  container image name
```
***                         
                         
