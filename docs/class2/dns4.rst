Simulate a DNS DDoS Attack
==========================

DNS flood (or DoS) attacks
--------------------------

Denial-of-service (DoS) or flood attacks attempt to overwhelm a system by 
sending thousands of requests that are either malformed or simply attempt to 
overwhelm a system using a particular DNS query type or protocol extension, 
or a particular SIP request type. The BIG-IP system allows you to track such 
attacks, using the DoS Protection profile.

#. Open the SSH session to the victim server and ensure the ``top`` utility is running.
#. Once again, attack your DNS server from the attack host using the following syntax: ``dnsperf -s 10.1.10.6 -d queryfile-example-current -c 20 -T 20 -l 30 -q 10000 -Q 10000``
#. On the server SSH session running the top utility, notice the CPU utilization on your server remains in a range that ensures the DNS server is not overwhelmed. 
#. After the attack, navigate to **Security** > **Event Logs** > **DoS** > **DNS Protocol**. Observe the logs to see the mitigation actions taken by the BIG-IP.

Click **Next** to continue.