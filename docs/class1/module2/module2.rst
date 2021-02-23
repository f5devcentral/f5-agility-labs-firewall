Module 2: AFM Packet Tester, Flow Inspector, Stale Rule Lab
===========================================================

The Packet Tester is a troubleshooting tool that allows a user to inject a packet 
into the traffic processing of BIG-IP® AFM™ and track the resulting processing by 
the Network Firewall, DoS prevention settings, and IP Intelligence. If the packet 
hits an Network Firewall, DoS Protection, or IP Intelligence rule, the rule and 
rule context is displayed. This allows you to troubleshoot packet issues with 
certain types of packets, and to check that rules for certain packets are 
correctly configured.

Flow inspector will allow you to query the stateful connection table on the BIG-IP using
filters in the TMUI. This is helpful to view "live" during troubleshooting sessions. 

Finally, a stale rule report will help you find abandoned or unused firewall rules
to make reviews and cleanups easier.

Click **Next** to get started.

.. toctree::
   :maxdepth: 5
   :glob:

   lab*
