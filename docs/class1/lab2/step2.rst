Advanced Firewall Manager (AFM) Packet Tracer
=============================================

Create and View Packet Tracer Entries
-------------------------------------

In this section, you will generate various types of traffic as you did
previously, but now you will view the flow using the network packet
tracer. Login to bigip2.dnstest.lab

(192.168.1.150), navigate to **Security > Debug > Packet Tester**.

|image42|

Create a packet test with the following parameters:

+-------------------+------------------------+
| **Protocol**      | TCP                    |
+===================+========================+
| **TCP Flags**     | SYN                    |
+-------------------+------------------------+
| **Source**        | IP - 1.2.3.4           |
|                   | Port – 9999            |
|                   | Vlan – Outside         |
+-------------------+------------------------+
| **TTL**           | 255                    |
+-------------------+------------------------+
| **Destination**   | IP – 10.30.0.50        |
|                   | Port - 80              |
+-------------------+------------------------+
| **Trace Options** | Use Staged Policy – no |
|                   | Trigger Log - no       |
+-------------------+------------------------+

Click Run Trace to view the response. Your output should resmeble the
allowed flow as shown below:

|image43|

You can also click on the “Route Domain Rules” trace result and see
which rule is permitting the traffic.

|image44|

Click **New Packet Trace** (optionally do not clear the existing data –
aka leave checked).

Create a packet test with the following parameters:

+-------------------+------------------------+
| **Protocol**      | TCP                    |
+===================+========================+
| **TCP Flags**     | SYN                    |
+-------------------+------------------------+
| **Source**        | IP - 1.2.3.4           |
|                   | Port – 9999            |
|                   | Vlan – Outside         |
+-------------------+------------------------+
| **TTL**           | 255                    |
+-------------------+------------------------+
| **Destination**   | IP – 10.30.0.50        |
|                   | Port - **8081**        |
+-------------------+------------------------+
| **Trace Options** | Use Staged Policy – no |
|                   | Trigger Log - no       |
+-------------------+------------------------+

Click Run Trace to view the response. Your output should resemble the
allowed flow as shown below:

|image45|

This shows there is no rule associated with the route domain or a
virtual server which would permit the traffic. As such, the traffic
would be dropped/rejected.

.. |image42| image:: /_static/class1/image41.png
   :width: 6.48958in
   :height: 3.44792in
.. |image43| image:: /_static/class1/image42.png
   :width: 6.47361in
   :height: 2.94722in
.. |image44| image:: /_static/class1/image43.png
   :width: 6.5in
   :height: 2.66667in
.. |image45| image:: /_static/class1/image44.png
   :width: 6.49722in
   :height: 2.97708in

