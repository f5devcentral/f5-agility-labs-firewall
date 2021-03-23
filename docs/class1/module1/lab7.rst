Lab 7: Configure a Clone Pool for SSL Visibility to IDS Sensors or Other Security Tools
=======================================================================================

SSL encrypted traffic poses a problem for many security devices. The performance of those 
devices is significantly reduced when trying to decrypt SSL traffic. Since the BIG-IP 
is designed to efficiently handle SSL traffic using specialized hardware and optimized software 
libraries, it is in the unique position to 'hand-off' a copy of the decrypted traffic 
to other devices.

In this solution, since the BIG-IP is terminating SSL, traffic is forwarded to the secondary virtual server in clear-text so that an unencrypted copy of the application traffic is sent to an external sensor such as an IDS for further security assessment.

1. Return to the BIG-IP TMUI in Chrome and inspect the preconfigured IDS_Pool.

2. Navigate to **Local Traffic** > **Pools** > **Pool List**.

3. Select the *IDS_Pool*, then click on the **Members** tab.

   .. Note:: Unencrypted traffic will be forwarded to this IP address.

4. Attach the *IDS\_Pool* as a clone pool to the server side of the external virtual server by navigating to 
   **Local Traffic** > **Virtual Servers** > V**irtual Server List** and clicking on *EXT\_VIP\_10_1_10_30*.

5. Select **Advanced** from the pulldown at the top of the Configuration section to view advanced configuration options.

   .. image:: ../images/advanced_options_dropdown.png

6. Scroll to the configuration for Clone Pool (Client) and select **None**. For the Clone Pool (Server), select **IDS_pool**.

   |image60|

   .. Note:: Leave all other fields using the default values.

8. Scroll to the bottom of the screen and click **Update**.

9. Select the Putty application from the desktop on the jump host.

10. Load **Lamp Server** from the sessions list.

11. Click **Open**. Accept the certificate warning, if presented. You should be automatically logged in as the F5 user with certificate authentication.

12. Input the TCPDUMP command to start capturing traffic:

.. code-block:: console

    sudo tcpdump -n –i eth1 -c 200 port 8081

13. Initiate another attempt to connect to the website via curl using the Cygwin application on the desktop. It 
    may be helpful to position the windows on the desktop side-by-side so that you can see both the Putty session 
    and the Cygwin session.

.. code-block:: console

   curl -k https://10.1.10.30:8081 -H 'Host:site1.com' -H 'X-Forwarded-For: 172.16.99.5'

   curl -k https://10.1.10.30:8081 -H 'Host:site3.com' -H 'X-Forwarded-For: 172.16.99.5'

Initiate another attempt to connect to the websites using the browser. These sites should be loaded in tabs 3 
and 5, but notice that we're using a different destination port.

.. code-block:: console

   https://site2.com:8081

   https://site4.com:8081

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

.. note:: Inspect the source and destination addresses. This traffic is cloned from the EXT_VIP.

This is the end of Module 1. Click **Next** to continue to Module 2.

.. |image58| image:: ../images/image58.png
   :width: 5.65139in
   :height: 5.75556in
.. |image59| image:: ../images/image59.png
   :width: 4.66626in
   :height: 4.24264in
.. |image60| image:: ../images/image60.png
   :width: 4.83440in
   :height: 2.18569in
