# To show all DNS Queries
>(layers.dns.dns_flags_dns_flags_rcode:"0")&&(_exists_:layers.dns.text_dns_a)

# Top five DNS Client
>layers.dns.dns_flags_dns_flags_response:"1"
and group by layers.ip.ip_ip_dst_host

# Top five DNS Server
>layers.dns.dns_flags_dns_flags_response:"1"
and group by layers.ip.ip_ip_src_host

# DNS query failed due to server failed to response query
>(layers.dns.dns_flags_dns_flags_rcode:"2")&&(layers.dns.dns_flags_dns_flags_response:"1")

# DNS query failed due to Domain not exists
>(layers.dns.dns_flags_dns_flags_rcode:"3")&&(layers.dns.dns_flags_dns_flags_response:"1")

# DNS query failed due to Query Format Error
>(layers.dns.dns_flags_dns_flags_rcode:"1")&&(layers.dns.dns_flags_dns_flags_response:"1")


# Top Five TCP Protocol
>layers.frame.frame_frame_protocols:*tcp*
and group by layers.frame.frame_frame_protocols

# Data transfer of top five protocols
>layers.frame.frame_frame_protocols:*tcp* ,
sum layers.tcp.tcp_tcp_len ,
group by layers.frame.frame_frame_protocols


# TCP data
>layers.frame.frame_frame_protocols:"eth:ethertype:ip:tcp"


# SSL data
>layers.frame.frame_frame_protocols:"eth:ethertype:ip:tcp:ssl"

# SMTP data
>layers.frame.frame_frame_protocols:"eth:ethertype:ip:tcp:smtp"

# XMPP data
>layers.frame.frame_frame_protocols:"eth:ethertype:ip:tcp:xmpp"


# To show HTTP Requests
>(_exists_:layers.http.http_request_uri_http_request_uri_path)


# Lost Packets of TCP
> (layers.tcp.tcp_tcp_seq:"2" && layers.tcp.tcp_flags_tcp_flags_ack:"1") && (layers.tcp.tcp_flags_tcp_flags_push:"1" || layers.tcp.tcp_flags_tcp_flags_fin:"1")

# Lost packets of HTTP
>(layers.tcp.tcp_tcp_seq:"2" && layers.tcp.tcp_flags_tcp_flags_ack:"1") && (layers.tcp.tcp_flags_tcp_flags_push:"1" || layers.tcp.tcp_flags_tcp_flags_fin:"1") &&(layers.frame.frame_frame_protocols:*http*)
