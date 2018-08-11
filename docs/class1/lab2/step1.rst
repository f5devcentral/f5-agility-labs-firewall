Lab Overview
============

New in the v13 release of the BIG-IP Advanced Firewall Manager is the capability to insert a packet trace into the internal flow so you can analyze what component within the system is allowing or blocking packets based on your configuration of features and rule sets.

|image41|

The packet tracing is inserted at L3 immediately prior to the Global IP
intelligence. Because it is after the L2 section, this means that:

- we cannot capture in tcpdump so we can’t see them in flight, and

- no physical layer details will matter as it relates to testing.

That said, it’s incredibly useful for what is and is not allowing your
packets through. You can insert tcp, udp, sctp, and icmp packets, with a
limited set of (appropriate to each protocol) attributes for each.

.. |image41| image:: /_static/class1/image40.png
   :width: 6.5in
   :height: 3.44792in