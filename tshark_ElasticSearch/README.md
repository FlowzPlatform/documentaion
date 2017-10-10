# Introduction

Wireshark is the most popular packet capture and analysis software, and open source. It can recognize more than 2,000 protocols containing over 200,000 fields. Its GUI is familiar to most network and security professionals.

In addition to a GUI it provides the command-line utility tshark to capture live traffic as well as read and parse capture files. As its output, tshark can produce reports and statistics, but also parsed packet data in different text formats.

One of the output formats supported by tshark since version 2.2 (released in September 2016) is a JSON format for the Elasticsearch Bulk API:

1. Install Wireshark
 > sudo add-apt-repository ppa:wireshark-dev/stable
 > sudo apt-get update
 > sudo apt-get install wireshark
 > sudo wireshark

2. Install tshark
 > sudo apt-get update
 > sudo apt-get install tshark

3. Run Elasticsearch as a Docker
 > docker run -d -p 9200:9200 -p 9300:9300 elasticsearch

4. Explore Elastic Search data using Sense
 > Add Sense as a Extension in chrome
 > localhost:9200

5. Run kibana as a Docker
 > docker run --name some-kibana -e   ELASTICSEARCH_URL=http://some-elasticsearch:9200 -p 5601:5601 -d kibana

6. Run below command to capture network traffic of Interface and store it as a    JSON format
 > tshark -i eth0 -T ek > packets.json

7. Install FileBeat to continuesly store data in elasticsearch
 > curl -L -O  https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.6.2-amd64.deb

 > sudo dpkg -i filebeat-5.6.2-amd64.deb

8. Configure filebeat (/etc/filebeat/filebeat.yml)

 >filebeat.prospectors:
 >- input_type: log
 >  paths:
 >  - /home/software/Desktop/filebeat/packets.json
 > document_type: "pcap_file"
 > json.keys_under_root: true
 >output:
 > elasticsearch:
 >  hosts: ["localhost:9200"]
 >  index: "packets"
 >  template.enabled: false

9. Run Filebeat service
 > sudo service filebeat start
 > sudo service filebeat status
