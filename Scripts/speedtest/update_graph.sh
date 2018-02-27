#! /bin/sh

cd /opt/speedtest/rrd
#create the daily graphs

rrdtool graph speedtest.png -J -a PNG --title="Speed Test" --vertical-label "Mb/s" -s -1day DEF:D=speedtest.rrd:DOWN:AVERAGE DEF:DMIN=speedtest.rrd:DOWN:MIN DEF:DMAX=speedtest.rrd:DOWN:MAX DEF:U=speedtest.rrd:UP:AVERAGE DEF:UMIN=speedtest.rrd:UP:MIN DEF:UMAX=speedtest.rrd:UP:MAX CDEF:Y0=U,0,* CDEF:NegU=U,-1,* VDEF:Yavg=Y0,AVERAGE VDEF:Davg=D,AVERAGE VDEF:Uavg=NegU,AVERAGE AREA:D#61ab3d:Download AREA:NegU#3d61ab:Upload LINE1:Uavg#cc1100 LINE1:Davg#cc3300:"Avg" LINE1:Yavg#111111 GPRINT:D:LAST:"Last DL\: %2.1lf Mb/s" GPRINT:U:LAST:"Last UL\: %2.1lf Mb/s" GPRINT:Davg:"Average Speed %2.1lf Mb/s" -h 250 -w 525 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa > /dev/null 2>&1

rrdtool graph speedtest_ping.png -J -a PNG --title="Ping Test" --color CANVAS#000000 --vertical-label "ms" -s -1day DEF:P=speedtest_ping.rrd:PING:AVERAGE DEF:PMIN=speedtest_ping.rrd:PING:MIN DEF:PMAX=speedtest_ping.rrd:PING:MAX VDEF:Pavg=P,AVERAGE LINE1:Pavg#cc3300:"Average" LINE2:P#3d61ab:"Ping (ms)\n" GPRINT:Pavg:"Average Ping %2.1lf ms\n" -h 250 -w 525 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa > /dev/null 2>&1

cp *.png /opt/librenms/html/plugins/Speedtest/image