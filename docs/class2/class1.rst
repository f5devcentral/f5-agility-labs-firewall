|classname|
=================================================
|classname|

|lastupdated|

|copyright|


Welcome to the |classname| setup and hands-on exercise series.

The purpose of the Lab Setup and Configuration Guide is to walk you
through the setup of F5 BIGIP to protect applications at multiple layers
of the OSI stack hence providing Application Security Control. This in
effect allows F5 BIG-IP to be multiple firewalls within a single
platform.

***Assumptions/Prerequisites***: You have attended the AFM 101 lab
sessions either this year or in previous years. Additionally this lab
guide assumes that you understand LTM/TMOS basics and are comfortable
with the process of creating Nodes, Pools, Virtual Servers, Profiles and
Setting up logging and reporting.

There are three modules detailed in this document.

**Module 1: F5 Multi-layer Firewall**

**Module 2: F5 Dynamic Firewall Rules With iRules LX**

**Module 3: IPS Intrusion Detection and Prevention system**

**Lab Requirements:**

-  Remote Desktop Protocol (RDP) client utility

   -  Windows: Built-in

   -  Mac (Microsoft Client):
      https://itunes.apple.com/us/app/microsoft-remote-desktop/id715768417?mt=12

   -  Mac (Open Source Client):
      http://sourceforge.net/projects/cord/files/cord/0.5.7/CoRD_0.5.7.zip/download

   -  Unix/Linux (Source – Requires Compiling): http://www.rdesktop.org/

.. NOTE:: You may use your web browser for console access if necessary but screen
   sizing may be affected.

.. NOTE:: IP Filtering locks down connectivity to the remote labs.
   If you are required to VPN into your corporate office to get Internet access,
   please determine your external IP address via https://www.whatismyip.com and provide
   an instructor with that information for your pod.

-  Connectivity to the facility provided Internet service

-  Unique destination IP address for RDP to your lab

.. toctree::
   :maxdepth: 3
   :glob:

   module*/module*
