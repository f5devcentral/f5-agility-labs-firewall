Preventing Global DoS Sweep and Flood Attacks
=============================================

DoS Protection profile
---------------------

In the last section, the focus was on attacks originating from various hosts. In this section, we will 
focus on mitigating flood and sweep attacks from a single host. 

Single Endpoint Sweep
---------------------

The single endpoint sweep is an attempt for an attacker to send traffic across a range of ports on the target server, typically to scan for open ports.

1.	In the BIG-IP web UI, navigate to Security > DoS Protection > Device Configuration > Network Security.
2.	Expand the Single-Endpoint category in the vectors list.
3.	Click on Single Endpoint Sweep vector name.
4.	Configure the vector with the following parameters:
a.	State: Mitigate
b.	Threshold Mode: Fully Manual
c.	Detection Threshold EPS: 150
d.	Mitigation Threshold EPS: 200
e.	Add Source Address to Category: Checked
f.	Category Name: denial_of_service
g.	Sustained Attack Detection Time: 10 seconds
h.	Category Duration Time: 60 seconds
i.	Packet Type: Move All IPv4 to Selected

5.	Click Update to save your changes.
6.	Navigate to Security > Network Firewall > IP Intelligence > Policies.
7.	In the Global Policy section, change the IP Intelligence Policy to ip-intelligence.

8.	Click Update.
9.	Click on the ip-intelligence policy in the policy list below.
10.	Create a new Blacklist Matching Policy in the IP Intelligence Policy Properties section with the following attributes, leaving unspecified attributes with their default values:
a.	Blacklist Category: denial-of-service
b.	Action: drop
c.	Log Blacklist Category Matches: Yes
11.	Click Add to add the new Blacklist Matching Policy. 

12.	Click Update to save changes to the ip-intelligence policy.
13.	Open the BIG-IP SSH session and scroll the ltm log in real time with the following command: tail -f /var/log/ltm
14.	On the victim server, start a packet capture with an SSH filter by issuing sudo tcpdump -nn not port 22
15.	On the attack host, launch the attack by issuing the following command on the BASH prompt: 
sudo hping3 10.20.0.10 --flood --scan 1-65535 -d 128 -w 64 --syn 
16.	You will see the scan find a few open ports on the server, and the server will show the inbound sweep traffic. However, you will notice that the traffic to the server stops after a short time (10 seconds, the configured sustained attack detection time.) Leave the test running.
17.	After approximately 60 seconds, sweep traffic will return to the host. This is because the IP Intelligence categorization of the attack host has expired. After 10 seconds of traffic, the bad actor is again blacklisted for another 60 seconds. 
18.	Stop the sweep attack on the attack host by pressing CTRL + C.
19.	Return to the BIG-IP web UI and navigate to Security > Event Logs > DoS > Network > Events. Observe the log entries showing the details surrounding the attack detection and mitigation.
20.	Navigate to Security > Event Logs > Network > IP Intelligence. Observe the log entries showing the mitigation of the sweep attack via the ip-intelligence policy.
21.	Navigate to Security > Event Logs > Network > Shun. Observe the log entries showing the blacklist adds and deletes.
22.	Navigate to Security > Reporting > Network > IP Intelligence. Observe the statistics showing the sweep attack and mitigation. Change the View By drop-down to view the varying statistics.
23.	Navigate to Security > Reporting > DoS > Dashboard to view an overview of the DoS attacks and timeline. You can select filters in the filter pane to highlight the specific attack.
24.	Finally, navigate to Security > Reporting > DoS > Analysis. View detailed statistics around the attack.

Click **Next** to continue.