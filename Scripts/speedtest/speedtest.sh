#! /bin/sh

BASE="/opt/librenms/html/plugins/Speedtest/"

# get the EPOCH date
DATE=$(/bin/date +%s)

#Get the raw data
speedtest-cli --simple --share --server 4240 > /opt/speedtest/speedtest.txt

#Clean it up and get raw Ping time in ms
RAW_MS=$(cat /opt/speedtest/speedtest.txt | grep P | sed -r 's/\s+//g'| cut -d":" -f2 | cut -d"m" -f1)

#Clean it up and get raw Download time in MiB
RAW_DL=$(cat /opt/speedtest/speedtest.txt | grep D | sed -r 's/\s+//g'| cut -d":" -f2 | cut -d"M" -f1)

#Clean it up and get raw Upload time in MiB
RAW_UP=$(cat /opt/speedtest/speedtest.txt | grep U | sed -r 's/\s+//g'| cut -d":" -f2 | cut -d"M" -f1)

#Clean it up and get raw URL
RAW_URL=$(cat /opt/speedtest/speedtest.txt | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*")
echo $RAW_URL > ${BASE}/URL_LINK

echo $DATE $RAW_UP $RAW_DL $RAW_MS >> /opt/speedtest/speedtest.log

#get data into rrd
cd /opt/speedtest/rrd
rrdtool update speedtest_ping.rrd $DATE:$RAW_MS
rrdtool update speedtest.rrd $DATE:$RAW_DL:$RAW_UP

#Clean up
rm /opt/speedtest/speedtest.txt