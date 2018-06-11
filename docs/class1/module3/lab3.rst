View DoS Logging
================

Use the BIG-IP configuration utility to view the DoS logging. While the
attacks are running, access **Security > DoS Protection > DoS
Overview**.

|image52|

Note that the attack vector properties are available for modification to
the right. This is useful during an attack if a value needs to be
immediately modified.

In the configuration utility access, the ***Security > Event Logs > DoS
> Network > Events*** page. If necessary, sort the list in descending
order by the Time column.

|image53|

There should be an entry that was created when the BIG-IP identified the
start of the DoS attack, and then one or more entries for dropped
packets every second that the DoS attack continued. Eventually there
will be an entry for when the BIG-IP determines that the DoS attack has
stopped.

|image54|

Note the ***Action*** and ***Dropped Packets*** column, this indicates
that the BIG-IP not only detected the attack, but it also mitigated the
attack by dropping the packets with the bad IP TTL value.

Repeat the same steps for all the network attacks in the file and be
sure to verify the DoS logs and ensure each event has a start and a
stop.

Once you are finished running and verifying all the attacks, we will
then examine the network DoS reporting capabilities within the BIG-IP.
In the configuration utility go to ***Security > Reporting > DoS >
Dashboard (note it may take a few moments for the data to fully
populate).*** You should see a screen similar to the one below.

|image55|

Note the real time CPU, RAM, and Throughput stats. When an attack has
stopped the line will stop, so it’s easy to see what attacks are still
active. Feel free to explore the dashboard and the data represented.

In the configuration utility go to ***Security > Reporting > DoS >
Analysis (note it may take a few moments for the data to fully
populate).*** You should see a screen similar to the one below.

|image56|

In the configuration utility go to ***Security > Reporting > Network >
TCP/IP Errors (note it may take a few moments for the data to fully
populate).*** You should see a screen similar to the one below.

|image57|

Examine the other options in the ***View By*** drop down menu. When you
are finished examining the options go to ***Security > Overview >
Summary*** screen. Try some of the various options in the top right of
each chart. You can change between ***Details***, ***Line Chart***,
***Pie Chart*** and ***Bar Charts***. Also note how you can export this
data to CSV or PDF format. Below are some examples of the summaries:

|image58|

All of the reports are historical and provide aggregate stats based upon
the selected time period (last day, month, year etc…). In version 11.6
real time DDoS monitoring was added so that an administrator can see
what attacks are currently active, how serious they are, and how long
they have been active. The real time DDoS attack reporting also provides
visibility into the health of the BIG-IP by showing real time CPU, RAM,
and Throughput consumption.

Paste in all of the DDoS attack commands into the Scapy window again. In
the BIG-IP GUI go to ***Security > Reporting > DoS > Overview
Summary***.

This concludes the AFM DDoS lab.

***Before proceeding, please change the following logging settings for
the remainder of the labs to work correctly:***

Login to bigip01.agility.com (10.0.0.4).

Navigate to Security > Event Logs > Logging Profiles

Click on global-network

Modify the Network Firewall Publisher to
***Log-Publisher-Network-Firewall***

|image59|

Click Update

Navigate to Security > DoS Protection > Device Configuration >
Properties

Modify the Log Publisher to ***Log-Publisher-Network-DOS-Protection***

|image60|

Click Commit Changes to System

.. |image52| image:: /_static/class1/image50.png
   :width: 6.50000in
   :height: 1.60000in
.. |image53| image:: /_static/class1/image51.png
   :width: 6.50000in
   :height: 0.84514in
.. |image54| image:: /_static/class1/image52.png
   :width: 6.50000in
   :height: 1.45486in
.. |image55| image:: /_static/class1/image53.png
   :width: 6.50000in
   :height: 3.01597in
.. |image56| image:: /_static/class1/image54.png
   :width: 6.47361in
   :height: 3.52639in
.. |image57| image:: /_static/class1/image55.png
   :width: 6.47361in
   :height: 3.21042in
.. |image58| image:: /_static/class1/image56.png
   :width: 6.49514in
   :height: 3.53681in
.. |image59| image:: /_static/class1/image57.png
   :width: 3.61111in
   :height: 2.40972in
.. |image60| image:: /_static/class1/image58.png
   :width: 3.74306in
   :height: 1.51389in

