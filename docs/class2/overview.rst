Detecting and Protecting Against DDoS and DNS Protocol Attacks
==============================================================

About detecting and protecting against DoS, DDoS, and DNS protocol attacks
--------------------------------------------------------------------------

Attackers can target the BIG-IP® system in a number of ways. The BIG-IP 
system addresses several possible DoS, DDoS, and DNS attack routes. These 
DoS attack mitigation methods are available when the BIG-IP® Advanced 
Firewall Manager™ is licensed and provisioned.

DoS and DDoS attacks
--------------------

A DoS attack is a denial of service attack where a computer is used to flood a 
server, usually with TCP and UDP packets. A DDoS attack is where multiple 
systems target a single system with a DoS attack. The targeted network is 
then bombarded with packets from multiple locations. While DoS attacks are
usually only effective when packets are malicious or attack services that are
easily overwhelmed. DDoS attacks can be disastrous simply from the volume of 
traffic.

With Advanced Firewall Manager, you can configure the system to automatically 
track traffic and CPU usage patterns over time and adapt automatically to 
possible DoS attacks across a range of DoS vectors. You can initiate DoS 
detection for the whole system, and in profiles that are associated with 
specific virtual servers. Configure responses to system-level DoS attack 
vectors in the DoS Device Configuration.

Automatic threshold configuration is available for a range of non-error packet 
types on the AFM system. Use automatic thresholds to adapt responses to DoS 
attack vectors based on the traffic history on the system.

A list of all AFM DoS vectors can be found at https://support.f5.com/csp/article/K41305885.

Click **Next** to continue.
