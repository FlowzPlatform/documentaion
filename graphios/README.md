# Introduction
  Graphios is a script to emit nagios perfdata to various upstream metrics processing and time-series (graphing) systems. It's currently compatible with [graphite], [statsd], [Librato] and [InfluxDB], with possibly [Heka], and [RRDTool] support coming soon. Graphios can emit Nagios metrics to any number of supported upstream metrics systems simultaenously.

# Installation

  1.
     >pip install graphios

  2. Clone it yourself

     >git clone https://github.com/shawn-sterling/graphios.git
     >cd graphios

Then do one of the following three things (depending what you like best):

  1. Python setup
     >python setup.py install

  2. Create + Install RPM
     >python setup.py bdist_rpm
     >yum localinstall bdist/graphios-$version.rpm

  3. Copy the files where you want them to be
     >cp graphios*.py /my/dir
     >cp graphios.cfg /my/dir

# Configuration
  1. graphios.cfg
     The default location for graphios.cfg is in /etc/graphios/graphios.cfg

  2. nagios.cfg

     Your nagios.cfg is going to need to modified to send the graphite data to the perfdata files. Depending on how you installed graphios this step may have been done for you.


  3. nagios commands
     >mkdir /var/spool/nagios/graphios

     define command {
     command_name            graphite_perf_host
     command_line            /bin/mv /var/spool/nagios/graphios/host-perfdata  /var/spool/nagios/graphios/host-perfdata.$TIMET$

     }

    define command {
    command_name            graphite_perf_service
    command_line            /bin/mv /var/spool/nagios/graphios/service-perfdata /var/spool/nagios/graphios/service-perfdata.$TIMET$
    }

  4. Run it!
    >/home/ubuntu/graphios/graphios.py --config=/etc/graphios/graphios.cfg

  5. Optional init script: graphios

     Take a look in the init/ directory and find your OS of choice.

     For debian/ubuntu: cp init/debian/graphios /etc/init.d/ cp init/debian/graphios.conf /etc/init chmod 755 /etc/init.d/graphios

     For rhel/centos/sl < 6: cp init/rhel/graphios /etc/init.d chmod 755 /etc/init.d/graphios

     For systems with systemd: cp init/systemd/graphios.service /usr/lib/systemd/system

     NOTE: You may need to change the location and username that the script runs as. this varies slightly depending on where you decided to put graphios.py

     The lines you will likely have to change:

    > prog="/opt/nagios/bin/graphios.py"
    >  # or use the command line options:
    >  #prog="/opt/nagios/bin/graphios.py --log-file=/dir/mylog.log  --spool-directory=/dir/my/sool"
      GRAPHIOS_USER="nagios"

  6. Your host and service configs

     define host {
     name                        myhost
     check_command               check_host_alive
     _graphiteprefix             monitoring.nagios01.pingto
     }
