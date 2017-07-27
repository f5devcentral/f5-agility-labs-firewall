Configure A Clone Pool For SSL Visibility To IDS Sensors Or Other Security Tools
================================================================================

SSL encrypted traffic poses a problem for most security devices. The performance of those devices is significantly impacted when trying to decrypt SSL traffic. Since the BIG-IP is designed to handle SSL traffic with specialized hardware and optimized software libraries, it is in the unique position to 'hand-off' a copy of the decrypted traffic to other devices.

In this solution, since the BIG-IP is terminating SSL on the external virtual server, when we forward the traffic to the secondary virtual server in clear-text we have an opportunity to make an unencrypted copy of the application traffic and send it to an external sensor such as an IDS for further security assessment.

On BIG-IP

Configure a new Pool.

**Navigation:** Local Traffic > Pools > Pool List > Click Create.

+-------------+----------------------+---------------+--------------------+
| **Name**    | **Health Monitor**   | **Members**   | **Service Port**   |
+=============+======================+===============+====================+
| IDS\_Pool   | gateway\_icmp        | 172.1.1.11    | \*                 |
+-------------+----------------------+---------------+--------------------+

|image58|

.. Note:: Leave all other fields using the default values.

**Navigation:** Click Finished.

Attach the *IDS\_Pool* as a clone pool to the server side of the external virtual server

**Navigation:** Local Traffic > Virtual Servers > Virtual Server List > EXT\_VIP\_10.10.99.30.

**Navigation:** Configuration > Advanced.

|image59|

**Navigation:** Scroll to the configuration for Clone Pools and select the IDS\_Pool

|image60|

**Navigation:** Click on update at the bottom of the page.

.. Note:: Leave all other fields using the default values.

**Navigation:** SSH in to the Syslog/Webserver

Run tcpdump –i eth2 port 80

.. code-block:: console

   root@syslogWebserver:~# tcpdump -i eth2 port 80

Initiate another attempt to connect to the website via curl or your web browser on the Windows host.

.. code-block:: console

   curl -k https://10.10.99.30 -H 'Host:www.mysite.com'

   <H1> MYSITE.COM </H1>

View the tcpdump output on the syslog-webserver.

.. code-block:: console

   tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
   listening on eth2, link-type EN10MB (Ethernet), capture size 262144 bytes
   17:25:42.585675 IP 10.10.99.222.50924 > 1.1.1.1.http: Flags [S], seq 912073522, win 4380, options [mss 1460,sackOK,eol], length 0
   17:25:42.585905 IP 1.1.1.1.http > 10.10.99.222.50924: Flags [S.], seq 1263282834, ack 912073523, win 4380, options [mss 1460,sackOK,eol], length 0
   17:25:42.585918 IP 10.10.99.222.50924 > 1.1.1.1.http: Flags [.], ack 1, win 4380, length 0
   17:25:42.585926 IP 10.10.99.222.50924 > 1.1.1.1.http: Flags [P.], seq 1:79, ack 1, win 4380, length 78
   17:25:42.586750 IP 1.1.1.1.http > 10.10.99.222.50924: Flags [.], ack 79, win 4458, length 0
   17:25:42.673178 IP 1.1.1.1.http > 10.10.99.222.50924: Flags [P.], seq 1:252, ack 79, win 4458, length 251
   17:25:42.673231 IP 10.10.99.222.50924 > 1.1.1.1.http: Flags [.], ack 252, win 4631, length 0
   17:25:42.676360 IP 10.10.99.222.50924 > 1.1.1.1.http: Flags [F.], seq 79, ack 252, win 4631, length 0
   17:25:42.676972 IP 1.1.1.1.http > 10.10.99.222.50924: Flags [.], ack 80, win 4458, length 0
   17:25:42.688028 IP 1.1.1.1.http > 10.10.99.222.50924: Flags [F.], seq 252, ack 80, win 4458, length 0
   17:25:42.688057 IP 10.10.99.222.50924 > 1.1.1.1.http: Flags [.], ack 253, win 4631, length 0

.. ATTENTION:: A copy of the web traffic destined for the internal virtual server is received by the monitoring device on 172.1.1.11. Alternatively you could attach the clone pool to the client side of the internal virtual server. How is the traffic getting to the server when the source and destination IP addresses are not on that interface?

.. NOTE:: This is the end of Module 1 - Lab 7.

.. |image58| image:: /_static/class2/image58.png
   :width: 5.65139in
   :height: 5.75556in
.. |image59| image:: /_static/class2/image59.png
   :width: 4.66626in
   :height: 4.24264in
.. |image60| image:: /_static/class2/image60.png
   :width: 4.83440in
   :height: 2.18569in