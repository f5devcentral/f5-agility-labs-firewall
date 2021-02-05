DNS DDoS Mitigations for Continued Service

At this point, you’ve successfully configured the BIG-IP to limit the amount of 
resource utilization on the BIG-IP. Unfortunately, even valid DNS requests can 
be caught in the mitigation we’ve configured. There are further steps that can 
be taken to mitigate the attack that will allow non-malicious DNS queries.

You can also enable Bad Actor detection on a per-vector basis to identify IP 
addresses that engage in attacks where one IP address is targeting many 
destinations; the system can automatically blacklist Bad Actor IP addresses 
with specific thresholds and time limits. In addition, you can use Attacked 
Destination Detection to determine IP addresses that are being attacked from 
many sources (many to one attacks). The attacked addresses are added to a list 
and packets are rate limited to that attacked address.


Bad Actor Detection

Bad actor detection and blacklisting allows us to completely block communications from malicious hosts at the BIG-IP, completely preventing those hosts from reaching the back-end servers. To demonstrate: 

1.	Navigate to Security > DoS Protection > DoS Profiles.
2.	Click on the dns-dos-profile profile name.
3.	Click on the Protocol Security tab then select DNS Security.
4.	Click on the DNS A Query attack type name.
5.	Modify the vector as follows:
a.	Bad Actor Detection: Checked
b.	Per Source IP Detection Threshold EPS: 80
c.	Per Source IP Mitigation Threshold EPS: 100
d.	Add Source Address to Category: Checked
e.	Category Name: denial_of_service
f.	Sustained Attack Detection Time: 15 seconds
g.	Category Duration Time: 60 seconds

6.	Make sure you click Update to save your changes.
7.	Navigate to Security > Network Firewall > IP Intelligence > Policies and create a new IP Intelligence policy with the following values, leaving unspecified attributes at their default values:
a.	Name: dns-bad-actor-blocking
b.	Default Log Actions section:
i.	Log Blacklist Category Matches: Yes
c.	Blacklist Matching Policy
i.	Create a new blacklist matching policy:
1.	Blacklist Category: denial_of_service
2.	Click Add to add the policy.

8.	Click Finished.
9.	Navigate to Local Traffic > Virtual Servers > Virtual Server List.
10.	Click on the udp_dns_VS virtual server name.
11.	Click on the Security tab and select Policies.
12.	Enable IP Intelligence and choose the dns-bad-actor-blocking policy.

13.	Make sure you click Update to save your changes.
14.	Navigate to Security > Event Logs > Logging Profiles.
15.	Click the global-network logging profile name.
16.	Under the Network Firewall tab, set the IP Intelligence Publisher to local-db-publisher and check Log Shun Events.

17.	Click Update to save your changes.
18.	Click the dns-dos-profile-logging logging profile name.
19.	Check Enabled next to Network Firewall.

20.	Under the Network Firewall tab, change the Network Firewall and IP Intelligence Publisher to local-db-publisher and click Update.

21.	Bring into view the Victim Server SSH session running the top utility to monitor CPU utilization.
22.	On the Attack Server host, launch the DNS attack once again using the following syntax:
dnsperf -s 10.20.0.10 -d queryfile-example-current -c 20 -T 20 -l 30 -q 10000 -Q 10000
23.	You’ll notice CPU utilization on the victim server begin to climb, but slowly drop. The attack host will show that queries are timing out as shown below. This is due to the BIG-IP blacklisting the bad actor.

24.	Navigate to Security > Event Logs > Network > IP Intelligence. Observe the bad actor blocking mitigation logs.
25.	Navigate to Security > Event Logs > Network > Shun. This screen shows the bad actor being added to (and later deleted from) the shun category.

26.	Navigate to Security > Reporting > Protocol > DNS. Change the View By drop-down to view various statistics around the DNS traffic and attacks.

27.	Navigate to Security > Reporting > Network > IP Intelligence. The default view may be blank. Change the View By drop-down to view various statistics around the IP Intelligence handling of the attack traffic.
28.	Navigate to Security > Reporting > DoS > Dashboard to view an overview of the DoS attacks and timeline. You can select filters in the filter pane to highlight specific attacks.

29.	Finally, navigate to Security > Reporting > DoS > Analysis. View detailed statistics around each attack.

Click **Next** to continue.