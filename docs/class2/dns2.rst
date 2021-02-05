Detecting and Preventing DNS DoS Attacks on a Virtual Server
============================================================

Establishing a DNS server baseline
----------------------------------

Before we can attack our DNS server, we should establish a baseline for how many QPS our DNS server can handle. For this lab, let’s find the magic number of QPS that causes 50% CPU utilization on the BIND process.

1.	Connect to the Victim Server SSH session by double-clicking the Victim Server (Ubuntu) shortcut on the jump host desktop.
2.	From the BASH prompt, enter top and press Enter to start the top utility.
3.	You will see a list of running processes sorted by CPU utilization, like the output below:
4.	Connect to the Attack Host SSH session by double-clicking the Attack Host (Ubuntu) shortcut on the jump host desktop.
5.	Start by sending 500 DNS QPS for 30 seconds to the host using the following syntax:
dnsperf -s 10.20.0.10 -d queryfile-example-current -c 20 -T 20 -l 30 -q 10000 -Q 500
6.	Observe CPU utilization over the 30 second window for the named process. If the CPU utilization is below 45%, increase the QPS by increasing the -Q value. If the CPU utilization is above 55%, decrease the QPS.
7.	Record the QPS required to achieve a sustained CPU utilization of approximately 50%. Consider this the QPS that the server can safely sustain for demonstration purposes.
8.	Now, attack the DNS server with 10,000 QPS using the following syntax:
dnsperf -s 10.20.0.10 -d queryfile-example-current -c 20 -T 20 -l 30 -q 10000 -Q 10000
9.	You’ll notice that the CPU utilization on the victim server skyrockets, as well as DNS query timeout errors appearing on the attack server’s SSH session. This shows your DNS server is overwhelmed.

Click **Next** to continue.