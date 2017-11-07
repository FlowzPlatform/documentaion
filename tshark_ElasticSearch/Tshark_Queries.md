# To capture DNS data:
>sudo tshark -f "udp port 53 or tcp port 53" -T ek > /path/to/folder/dns.json
>sudo tshark  -f "dst port 53 or src port 53" -T ek > /path/to/folder/dns.json

# To capture particular Host's data:
>sudo tshark -f "host IP of host" -T ek > //path/to/folder/host.json
>sudo tshark -f "host IP of host1 and IP of host2" -T ek > /path/to/folder/host.json

# To capture Http data:
>sudo tshark -f 'tcp port 80 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)' -T ek > /path/to/folder/http.json

# To capture particular application's data:
>sudo tshark -f "host IP and (udp src port (application port) or udp dst port (application port))" -T ek> /path/to/folder/app.json

# To capture tcp data:
>sudo tshark -f "tcp" -T ek > /path/to/folder/tcp.json
