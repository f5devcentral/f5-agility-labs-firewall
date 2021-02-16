Detecting and Preventing DNS DoS Attacks on a Virtual Server
============================================================

Establishing a DNS server baseline
----------------------------------

Before we can attack our DNS server, we should establish a baseline for how many QPS our DNS server can handle. For this lab, let’s find the magic number of QPS that causes 50% CPU utilization on the BIND process.

1. Connect to the Victim Server SSH session by double-clicking the **Victim Server (Ubuntu)** shortcut on the jump host desktop.

.. image:: _images/image020.png
  :alt: screenshot

2. From the BASH prompt, enter ``top`` and press **Enter** to start the top utility.

.. image:: _images/image021.png
  :alt: screenshot

3. You will see a list of running processes sorted by CPU utilization, like the output below. Observe the values under the ``%CPU`` column. The DNS daemon will appear in this list as ``named`` and may not be visible until the test begins.

.. image:: _images/image022.png
  :alt: screenshot

4. Connect to the Attack Host SSH session by double-clicking the **Attack Host (Ubuntu)** shortcut on the jump host desktop. Move the windows so that you can see the output of the top command on the attack victim while executing commands on the attack host.

.. image:: _images/image023.png
  :alt: screenshot

5. Start by sending 15,000 DNS QPS for 30 seconds to the host using the following syntax: 
    - ``dnsperf -s 10.1.10.6 -d queryfile-example-current -b 8192000 -c 60 -t 30 -T 20 -l 30 -q 1000000 -Q 18000``

.. image:: _images/image024.png
  :alt: screenshot

6. Observe CPU utilization over the 30 second window for the named process. 

.. image:: _images/image025.png
  :alt: screenshot

7. Re-run the test to create a baseline QPS limit. If the CPU utilization is below 45%, increase the QPS by increasing the -Q value. If the CPU utilization is above 55%, decrease the QPS.

8. Record the QPS required to achieve a sustained CPU utilization of approximately 50%. Consider this the QPS that the server can safely sustain for demonstration purposes. In this example, 18,000 QPS achieves 50% CPU on the attack victim as shown below.

9. Now, attack the DNS server with double your baseline QPS using the following syntax (modify the -Q value): 
    - ``dnsperf -s 10.1.10.6 -d queryfile-example-current -c 20 -T 20 -l 30 -q 100000 -Q 30000``

.. image:: _images/image026.png
  :alt: screenshot

10. You’ll notice that the CPU utilization on the victim server skyrockets. 
11. You will also likely see DNS query timeout errors appearing on the attack server’s SSH session. This shows your DNS server is overwhelmed.

.. image:: _images/image027.png
  :alt: screenshot

Click **Next** to continue.