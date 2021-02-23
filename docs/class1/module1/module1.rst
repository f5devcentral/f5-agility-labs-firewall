Module 1: F5 Multi-layer Firewall
=================================

This module has seven labs in configuring an Advanced Multi-layer firewall applicable to many data center environments.

In this module, you will build a perimeter firewall with advanced Layer 7 security mitigations.

Objective:

-  Inspect multiple internal pools and virtual servers for different applications within your data center. e.g. www, API, /downloads
-  Inspect external hosted virtual server that allows the same IP address to be shared with multiple SSL enabled applications.
-  Inspect and understand LTM policy to direct traffic to appropriate virtual server
-  Configure local logging; test
-  Create a network firewall policy to protect the internal application virtual servers; test
-  Configure the external virtual server to tranform traffic coming through CDN networks so that firewall policies can be applied to specific clients; test
-  Modify the network firewall policy to block based on XFF; test
-  Apply Layer 7 responses (403 Denied) for CDN clients to firewall drop rules
-  Configure HTTP protocol security; test
-  Configure SSL Visibility to external security devices e.g. IDS; test

Labs 1 & 2 highlight the flexibility of leveraging an application proxy such as the BIG-IP for your perimeter security utilizing common
traffic management techniques and some additional features unique to  the BIG-IP as an Application Delivery Controller.

.. toctree::
   :maxdepth: 1
   :caption: Contents:
   :glob:

   access
   lab*
