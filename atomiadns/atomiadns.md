# OS
 >  ubuntu 14.04 LTS

# Atomia DNS server

# Add the Atomia APT Repository
  >  wget -q -O - http://public.apt.atomia.com/setup.sh.shtml | sed s/%distcode/`lsb_release -c | awk '{ print $2 }'`/g | sh
# Install the database schema
  >  apt-get install atomiadns-powerdns-database

# To configure the nameserver to get zones from your Atomia DNS installation, add following to /etc/atomiadns.conf
  >  soap_uri = http://ec2-34-230-75-218.compute-1.amazonaws.com/atomiadns
     soap_username = admin@admin.com
     soap_password = admin
     servername = powerdns1

# Install the PowerDNS sync agent:
  >  apt-get install atomiadns-powerdnssync

# Create a nameserver group
  >  atomiadnsclient --method AddNameserverGroup --arg default

# Add the nameserver as subscriber of the zones
  >  atomiapowerdnssync add_server default

# Start the daemon
  >  /etc/init.d/atomiadns-powerdnssync start

# Sync all zones
  >  atomiapowerdnssync full_reload_online

# Install powerdns
  >  dpkg -i pdns-static_3.0-rc1-1_amd64.deb(https://www.powerdns.com/downloads.html)
    (When it asks if you want to replace /etc/powerdns/pdns.conf, just press enter to keep the version that atomiadns-powerdns-database preconfigured for you)



# Atomia PowerDns API and Client


# atomiadns.conf
	>  db_name = zonedata
	   db_hostname = localhost
	   db_username = atomiadns
	   db_password = 53800acabb1e0277997a9b1070e08b5de5c7a6a1

#	soap_uri = http://localhost/atomiadns
	>  soap_username = admin@admin.com
	   soap_password = admin
	   powerdns_db_database = powerdns
	   powerdns_db_hostname = localhost
	   powerdns_db_username = powerdns
	   powerdns_db_password = 8503b99eb965d676b180749bbe40790e2cbbae66

	>  servername = powerdns1

# soap_uri = http://atomiadnshost/atomiadns

	>  require_auth = 1
	   auth_admin_user = admin@admin.com
	   auth_admin_pass = admin

	>  webapp_nameservers=localhost

  >  /etc/powerdns/pdns.conf

	>  launch=gmysql
	   gmysql-host=localhost
	   gmysql-user=powerdns
	   gmysql-dbname=powerdns
	   gmysql-password=8503b99eb965d676b180749bbe40790e2cbbae66
	   gmysql-dnssec=yes

#  local-address=34.228.145.127
	>  local-address=34.230.75.218(api server ip)
	

#  API CALL


## To Get Zone
> curl -i -X POST -d '[ "eflowz.tk"]' -H 'X-Auth-Username: admin@flowz.com' -H 'X-Auth-Password: 12345678' 'http://34.230.75.218/pretty/atomiadns.json/GetZone'

## To Add Zone
> curl -i -X POST -d '[ "flowz.gq", 3600, "ns1.flowz.gq.", "avasani.officebrain.com.", 3600, 3600, 3600, 3600, [ "ns1.flowz.gq.", "ns2.flowz.gq." ], "default" ]' -H 'X-Auth-Username: admin@flowz.com' -H 'X-Auth-Password: 12345678' 'http://34.230.75.218/pretty/atomiadns.json/AddZone';

## To Set Dns Records
> curl -i -X POST -d '[ "flowz.gq", [ { "ttl" : "3600", "label" : "test2", "class" : "IN", "type" : "A", "rdata" : "192.168.1.10" } ] ]' -H 'X-Auth-Username: admin@flowz.com' -H 'X-Auth-Password: 12345678' 'http://34.230.75.218/pretty/atomiadns.json/SetDnsRecords'

## To Delete Zone
> curl -i -X POST -d '[ "obflow.tk" ]' -H 'X-Auth-Username: avasani@officebrain.com' -H 'X-Auth-Password: VmJG8F' 'http://api.atomiadns.net/pretty/atomiadns.json/DeleteZone'

## To Get Nameserver
> curl -i -X POST -d '[ "ns1.eflowz.tk"]' -H 'X-Auth-Username: admin@flowz.com' -H 'X-Auth-Password: 12345678' 'http://34.230.75.218/pretty/atomiadns.json/GetNameserver'



	
