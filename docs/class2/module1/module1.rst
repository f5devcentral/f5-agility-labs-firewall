Module 1: F5 Multi-layer Firewall 
=================================

This module has seven labs in configuring an Advanced Multi-layer firewall applicable to many data center environments.

In this module, you will build a perimeter firewall with advanced Layer 7 security mitigations.

Estimated completion time: 1 hour

Objective:

-  Create multiple internal pools and virtual servers for different applications within your data center. e.g. www, API, /downloads

-  Create external hosted virtual server that allows the same IP address to be shared with multiple SSL enabled applications.

-  Configure LTM policy to direct traffic to appropriate virtual server

-  Configure local logging; test

-  Create a network firewall policy to protect the internal application
   virtual servers; test

-  Configure the external virtual server to tranform traffic coming through CDN networks so that firewall policies can be applied to specific clients; test

-  Modify the network firewall policy to block based on XFF; test

-  Apply Layer 7 responses (403 Denied) for CDN clients to firewall drop rules

-  Configure HTTP protocol security; test

-  Configure SSL Visibility to external security devices e.g. IDS; test

Labs 1 & 2 highlight the flexibility of leveraging an application
proxy such as the BIG-IP for your perimeter security utilizing common
traffic management techniques and some additional features unique to 
the BIG-IP as an Application Delivery Controller.

Labs 3 & 4 Breaks out applying differing security policies to the
multi-tiered application deployment.

Lab 5 Highlights the flexibility of the Multi-Layered Firewall to solve
common problems for hosting providers.

Lab 6 Applies Layer 7 protocol validation and security for HTTP to the
existing applications.

Lab 7 Provides a solution for sending decrypted traffic to other
security devices.

.. WARNING:: IP addresses in screenshots are examples only. Please read the
   step-by-step lab instructions to ensure that you use the correct IP
   addresses.

.. toctree::
   :maxdepth: 1
   :glob:

   lab*
