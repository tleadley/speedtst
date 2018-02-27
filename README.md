# Speedtest

This is a simple bash shell script to run speedtest-cli and feed the results into a round robin database to be consumed by `rrdtool`.

![Screenshot](https://raw.github.com/tleadley/speedtst/screenshots/speedtest.PNG?raw=true "Speed Test Screenshot")

`update-graph.sh` creates daily, weekly, monthly and annual graphs. You are on your own to embed these as you desire in a status report or web page.

## Installation
* Download and install the two folders, one for the plugin and the other for the scripts
* Copy the scripts contents to /opt and the other plugin folder contents to the librenms plugins directory
* Install [speedtest-cli] from repo
* cd /opt/speedtest/rrd to create the RRD files with the included text file
* sudo apt install speedtest-cli
* Set up a cron job

I run this script every 30 minutes:
```
*/30 * * * * librenms /opt/speedtest/speedtest.sh && /opt/speedtest/update-graph.sh

```
