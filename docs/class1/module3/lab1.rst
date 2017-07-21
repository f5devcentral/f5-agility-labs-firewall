Create a Pool and Virtual Server using REST API
===============================================

Use the POSTMan collection named “Service Provider Specialist Event -
Lab 3a” to create the necessary pools and virtual servers for this
exercise.

Verify connectivity to the new virtual server by opening a browser and
connecting to `*http://10.128.10.20* <http://10.128.10.20>`__

Configuring DoS Protection
==========================

Since we are in a lab environment with no production traffic, we will
need to lower some of the default values for DoS detection values so
that attacks are seen in a timely manner. We are also going to verify
the DoS events are logged locally. Log into bigip01.agility.com
(10.0.0.4), access the ***Security > DoS Protection > Device***
***Configuration→ Properties*** page. From the ***Log Publisher*** list,
verify ***local-db-publisher*** is selected.

|image49|

-  Select Network Security from the Device Configuration drop down at
   the top

|image50|

-  Select the + sign next to ***Bad-Header – Ipv4***

-  Then select ***Bad IP TTL Value***.

-  Specify the following threshold values and Click ***Update*** when
   finished:

+-------------------------------+-------+
| Detection Threshold PPS       | 25    |
+-------------------------------+-------+
| Detection Threshold Percent   | 100   |
+-------------------------------+-------+
| Leak Limit/Rate Limit PPS     | 25    |
+-------------------------------+-------+

This is what set’s F5’s BIG-IP apart from other offerings. It monitors
for DoS activity and when a DoS event is detected, it will not block all
traffic from a IP address, as this could affect legitimate traffic such
as that behind a proxy. Instead, the Big-IP will limit only the
offending traffic allowing legitimate traffic to pass through. Below is
some background on how the detection mechanism works:

**Detection Threshold PPS**: This is the number of packets per
second (of this attack type) that the BIG-IP system uses to
determine if an attack is occurring. When the number of packets per
second goes above the threshold amount, the BIG-IP system logs and
reports the attack, and then continues to check every second, and
marks the threshold as an attack if the threshold is exceeded. The
default value is 10,000 packets per second, but we’ll change the
values to 25 packets per second for the purposes of this demo.

**Detection Threshold Percent**: This is the percentage increase
value that specifies an attack is occurring. The BIG-IP system
compares the current rate to an average rate from the last hour. For
example, if the average rate for the last hour is 1000 packets per
second, and you set the percentage increase threshold to 100, an
attack is detected at 100 percent above the average, or 2000 packets
per second. When the threshold is passed, an attack is logged and
reported.

The BIG-IP system then automatically institutes a rate limit equal
to the average for the last hour, and all packets above that limit
are dropped. The BIG-IP system continues to check every second until
the incoming packet rate drops below the percentage increase
threshold. Rate limiting continues until the rate drops below the
specified limit again. The default value is 500 percent, but we’ll
change the values to 100 percent for the purposes of this demo. This
is the lowest value allowed for this setting.

**Rate/Leak Limit**: This is the value, in packets per second that
cannot be exceeded by packets of this type. All packets of this type
over the threshold are dropped. Rate limiting continues until the
rate drops below the specified limit again. The default value is
10,000 packets per second, but we’ll change the values to 25 packets
per second.

We will set the thresholds for other DDoS events, but rather than go
through the GUI for each one, we will set the thresholds for all of them
at once using tmsh CLI commands. To do so go to the following URL to see
the tmsh commands that will be used:

`*http://10.128.20.150/ddos-commands.txt* <http://10.128.20.150/ddos-commands.txt>`__

Optionally, you can use the POSTMan collection “Service Provider
Specialist Event - Lab 3b” to modify the values on both devices.

Copy all the DDoS commands and then open up an SSH session (via Putty or
similar program) to the management IP address of bigip01.agility.com
(10.0.0.4). Login with the following credentials:

- User: root
- Password: 401elliottW!

Once you are connected paste in the tmsh commands from the web page into
the SSH session to set the DoS thresholds. The following parameters will
be set:

-  **Bad Header – IPv4**

-  Bad IP Version

-  Header Length > L2 Length

-  Header Length Too Short

-  IP Error Checksum

-  IP Length > L2 Length

-  IP Source Address == Destination Address

-  L2 length >> IP length

-  No L4

-  **Bad Headers - TCP**

-  Bad TCP Checksum

-  Bad TCP Flags (All Flags Set)

-  FIN Only Set

-  SYN & FIN Set

-  TCP Header Length > L2 Length

-  TCP Header Length Too Short (Length < 5)

-  **Flood**

-  ICMP Flood

-  **Fragmentation**

-  IP Fragment

Close the PuTTY session to disconnect from the BIG-IP.

.. |image47| image:: /_static/class1/image1.jpg
   :width: 3.27778in
   :height: 1.14444in
.. |image48| image:: /_static/class1/image41.jpg
   :width: 1.95031in
   :height: 1.01251in
.. |image49| image:: /_static/class1/image47.png
   :width: 6.50000in
   :height: 2.14583in
.. |image50| image:: /_static/class1/image48.png
   :width: 6.50000in
   :height: 3.44792in
