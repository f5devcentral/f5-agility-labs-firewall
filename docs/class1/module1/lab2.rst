Advanced Firewall Manager (AFM)
===============================

Advanced Firewall Manager (AFM) is a new module that was added to TMOS
in version 11.3. F5

BIG-IP Advanced Firewall Manager™ (AFM) is a high-performance ICSA
certified, stateful, full-proxy

network firewall designed to guard data centers against incoming threats
that enter the network on the most widely deployed protocols—including
HTTP/S, SMTP, DNS, SIP, and FTP.

By aligning firewall policies with the applications, they protect,
BIG-IP AFM streamlines application deployment, security, and monitoring.
With its scalability, security, and simplicity, BIG-IP AFM forms the
core of the F5 application delivery firewall solution.

|image8|

Some facts below about AFM, and its functionality:

-  Advanced Firewall Manager (AFM) provides “Shallow” packet inspection
   while Application Security Manager (ASM) provides “Deep” packet
   inspection. By this we mean that AFM is concerned with source IP
   address and port, destination IP address and port, and protocol (this
   is also known as 5-tuple/quintuple filtering).

-  AFM is used to allow/deny a connection before deep packet inspection
   ever takes place, think of it as the first line of firewall defense.

-  AFM is many firewalls in one. You can apply L4 firewall rules to ALL
   addresses on the BIG-IP or you can specify BIG-IP configuration
   objects (route domains, virtual server, self-IP, and Management-IP).

-  AFM runs in 2 modes: ***ADC mode*** and ***Firewall*** mode. ***ADC
   mode*** is called a “blacklist”, all traffic is allowed to BIG-IP
   except traffic that is explicitly DENIED (this is a negative security
   model). ***Firewall mode*** is called a “whitelist”, all traffic is
   denied to BIG-IP except traffic that is explicitly ALLOWED. The
   latter is typically used when the customer only wants to use us as a
   firewall or with LTM.

-  We are enabling “SERVICE DEFENSE IN DEPTH” versus traditional
   “DEFENSE IN DEPTH”. This means, instead of using multiple shallow and
   deep packet inspection devices inline increasing infrastructure
   complexity and latency, we are offering these capabilities on a
   single platform.

-  AFM is an ACL based firewall. In the old days, we used to firewall
   networks using simple packet filters. With a packet filter, if a
   packet doesn’t match the filter it is allowed (not good). With AFM,
   if a packet does not match criteria, the packet is dropped.

-  AFM is a stateful packet inspection (SPI) firewall. This means that
   BIG-IP is aware of new packets coming to/from BIG-IP, existing
   packets, and rogue packets.

-  AFM adds more than 80 L2-4 denial of service attack vector detections
   and mitigations. This may be combined with ASM to provide L4-7
   protection.

-  Application Delivery Firewall is the service defense in depth
   layering mentioned earlier. On top of a simple L4 network firewall,
   you may add access policy and controls from L4-7 with APM (Access
   Policy Manager), or add L7 deep packet inspection with ASM (web
   application firewall), You can add DNS DOS mitigation with LTM DNS
   Express and GTM + DNSSEC. These modules make up the entire
   application delivery firewall (ADF) solution.

.. |image8| image:: /_static/class1/image9.png
   :width: 6.50000in
   :height: 1.87222in

