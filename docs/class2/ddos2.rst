Simulating a Christmas Tree Packet Attack
=========================================

In this example, we’ll set the BIG-IP to detect and mitigate an attack where all flags on a 
TCP packet are set. This is commonly referred to as a Christmas tree packet and is intended 
to increase processing on in-path network devices and end hosts to the target.

Configure Logging
-----------------

Configuring a logging destination will allow you to verify the BIG-IPs detection and mitigation 
of attacks, in addition to the built-in reporting.

1.	In the BIG-IP web UI, navigate to **Security** > **DoS Protection** > **Device Configuration** > **Properties**.
2.	Under **Log Pubisher**, select *local-db-publisher*.
3.	Click the **Commit Changes to System** button.

Initiate the Attack
-------------------

We’ll use the hping utility to send 25,000 packets to our server, with random source IPs to simulate a DDoS attack where multiple hosts are attacking our server. We’ll set the SYN, ACK, FIN, RST, URG, PUSH, Xmas and Ymas TCP flags.

1.	In the BIG-IP web UI, navigate to **Security** > **DoS Protection** > **Device Configuration** > **Network Security**.
2.	Expand the *Bad-Header-TCP* category in the vectors list.
3.	Click on the **Bad TCP Flags (All Flags Set)** vector name.
4.	Configure the vector with the following parameters:
a.	**State**: *Mitigate*
b.	**Threshold Mode**: *Fully Manual*
c.	**Detection Threshold EPS**: *Specify 50*
d.	**Detection Threshold Percent**: *Specify 200*
e.	**Mitigation Threshold EPS**: *Specify 100*
5.	Click **Update** to save your changes.
6.	Open the BIG-IP SSH session and scroll the ltm log in real time with the following command: ``tail -f /var/log/ltm``
7.	On the attack host, launch the attack by issuing the following command on the BASH prompt: 
``sudo hping3 10.1.10.6 --flood --rand-source --destport 80 -c 25000 --syn --ack --fin --rst --push --urg --xmas --ymas``
8.	You’ll see the BIG-IP ltm log show that the attack has been detected:
9.	After approximately 60 seconds, press CTRL+C to stop the attack.
10.	Return to the BIG-IP web UI. Navigate to **Security** > **Event Logs** > **DoS** > **Network** > **Events**. Observer the log entries showing the details surrounding the attack detection and mitigation.
11.	Navigate to **Security** > **Reporting** > **DoS** > **Analysis**. Single-click on the attack ID in the filter list to the right of the charts and observe the various statistics around the attack.

Click **Next** to continue.