# Speedtest

This is a simple bash shell script to run speedtest-cli and feed the results into a round robin database to be consumed by `rrdtool`.

`update-graph.sh` creates daily, weekly, monthly and annual graphs. You are on your own to embed these as you desire in a status report or web page.

## Installation
* Download and install the two Gzip files
* Extract the speedtest.tar.gz to /opt and the other speedtest_plugin.tar.gz to the librenms plugins directory
* Install [speedtest-cli] from repo 
* cd /opt/speedtest/rrd to create the RRD files with the included text file
* sudo apt install speedtest-cli
* Set up a cron job

I run this script every 30 minutes:
```
*/30 * * * * librenms /opt/speedtest/speedtest.sh && /opt/speedtest/update-graph.sh
```

