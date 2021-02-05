Detecting and Protecting Against DDoS and DNS Protocol Attacks
==============================================================

About detecting and protecting against DoS, DDoS, and DNS protocol attacks
--------------------------------------------------------------------------

Attackers can target the BIG-IP® system in a number of ways. The BIG-IP 
system addresses several possible DoS, DDoS, and DNS attack routes. These 
DoS attack prevention methods are available when theBIG-IP® Advanced 
Firewall Manager™ is licensed and provisioned.

DoS and DDoS attacks
--------------------

Denial-of-service (DoS) and distributed denial-of-service (DDoS) attacks attempt 
to render a machine or network resource unavailable to users. DoS attacks involve 
the efforts of one or more sources to disrupt the services of one or more hosts 
connected to the Internet.

With Advanced Firewall Manager, you can configure the system to automatically 
track traffic and CPU usage patterns over time and adapt automatically to 
possible DoS attacks across a range of DoS vectors. You can initiate DoS 
detection for the whole system, and in profiles that are associated with 
specific virtual servers. Configure responses to system-level DoS attack 
vectors in the DoS Device Configuration.

Automatic threshold configuration is available for a range of non-error packet 
types on the AFM system. Use automatic thresholds to adapt responses to DoS 
attack vectors based on the traffic history on the system.



Malformed DNS packets
---------------------

Malformed DNS packets can be used to consume processing power on the BIG-IP 
system, ultimately causing slowdowns like a DNS flood. The BIG-IP system drops 
malformed DNS packets, and allows you to configure how you track such attacks. 
This configuration is set in the DoS Protection profile.

A list of all AFM DoS vectors can be found at https://support.f5.com/csp/article/K41305885.

Click **Next** to continue.