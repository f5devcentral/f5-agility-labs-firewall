Advanced Firewall Manager (AFM) Packet Tracer
=============================================

Create and View Packet Tracer Entries
-------------------------------------

In this section, you will generate various types of traffic as you did
previously, but now you will view the flow using the network packet
tracer. Login to bigip01.f5demo.com

(10.1.1.4), navigate to **Security > Debug > Packet Tester**.

|image441|

Create a packet test with the following parameters:

+-------------------+------------------------+
| **Protocol**      | TCP                    |
+===================+========================+
| **TCP Flags**     | SYN                    |
+-------------------+------------------------+
| **Source**        | IP - 1.2.3.4           |
|                   | Port – 9999            |
|                   | Vlan – external        |
+-------------------+------------------------+
| **TTL**           | 255                    |
+-------------------+------------------------+
| **Destination**   | IP – 10.1.20.11        |
|                   | Port - 80              |
+-------------------+------------------------+
| **Trace Options** | Use Staged Policy – no |
|                   | Trigger Log - no       |
+-------------------+------------------------+

Click Run Trace to view the response. Your output should resmeble the
allowed flow as shown below:

|image442|

You can also click on the “Route Domain Rules” trace result and see
which rule is permitting the traffic.

|image443|

Click **New Packet Trace** (optionally do not clear the existing data –
aka leave checked).

Create a packet test with the following parameters:

+-------------------+------------------------+
| **Protocol**      | TCP                    |
+===================+========================+
| **TCP Flags**     | SYN                    |
+-------------------+------------------------+
| **Source**        | IP - 172.16.99.5       |
|                   | Port – 9999            |
|                   | Vlan – External        |
+-------------------+------------------------+
| **TTL**           | 255                    |
+-------------------+------------------------+
| **Destination**   | IP – 2.2.2.2           |
|                   | Port - **80**          |
+-------------------+------------------------+
| **Trace Options** | Use Staged Policy – no |
|                   | Trigger Log - no       |
+-------------------+------------------------+

Click Run Trace to view the response. Your output should resemble the
allowed flow as shown below:

|image444|

Next to the packet Trace button note the Clear Data Check box **Uncheck it**  so you dont hve to input all the fields again

+-------------------+------------------------+
| **Protocol**      | TCP                    |
+===================+========================+
| **TCP Flags**     | SYN                    |
+-------------------+------------------------+
| **Source**        | IP - 172.16.99.7       |
|                   | Port – 9999            |
|                   | Vlan – external        |
+-------------------+------------------------+
| **TTL**           | 255                    |
+-------------------+------------------------+
| **Destination**   | IP – 2.2.2.2           |
|                   | Port - **80**          |
+-------------------+------------------------+
| **Trace Options** | Use Staged Policy – no |
|                   | Trigger Log - no       |
+-------------------+------------------------+

This traffic will be blocked by the virtual Server rule

**Navigation** Click on the Vitrual Server Rules Icon to get more specific information

This demonstrates the rules built in the first lab

.. |image441| image:: /_static/class2/image441.png
   :width: 6.48958in
   :height: 3.44792in
.. |image442| image:: /_static/class2/image442.png
   :width: 6.47361in
   :height: 2.94722in
.. |image443| image:: /_static/class2/image443.png
   :width: 6.5in
   :height: 2.66667in
.. |image444| image:: /_static/class2/image444.png
   :width: 6.49722in
   :height: 2.97708in

