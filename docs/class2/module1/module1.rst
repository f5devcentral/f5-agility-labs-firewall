Module 1: F5 Multi-layer Firewall Lab 
=====================================

The purpose of the Lab Setup and Configuration Guide is to walk you
through the setup of F5 BIGIP to protect applications at multiple layers
of the OSI stack hence providing Application Security Control. This in
effect allows F5 BIG-IP to be multiple firewalls within a single
platform.

**Assumptions/Prerequisites**: You have attended the AFM 101 lab
sessions either this year or in previous years. Additionally this lab
guide assumes that you understand LTM/TMOS basics and are comfortable
with the process of creating Nodes, Pools, Virtual Servers, Profiles and
Setting up logging and reporting.

There are three labs detailed in this document.

**Lab 1**

This lab has six steps in configuring an Advanced Multi-layer firewall
applicable to many data center environments. Task 7 will demonstrate
additional protocol protections.

Tasks 1 - 2 highlights the flexibility of leveraging an application
proxy such as the BIG-IP for your perimeter security utilizing common
traffic management techniques.

Task 3 & 4 Breaks out applying differing security policies to the
multi-tiered application deployment.

Task 5 Highlights the flexibility of the Multi-Layered Firewall to solve
common problems for hosting providers.

Task 6 Applies Layer 7 protocol validation and security for HTTP to the
existing applications.

Task 7 Highlights protecting the DNS protocol.

**Lab 2**

This lab highlights Advanced Firewall Security (L2-7) layering on
authentication and access control with Access Policy Manager Application
Security (L7) for Multi-tenancy using Route Domains and network
firewalling. (LTM+AFM+APM)

**Lab 3**

This lab introduces iRules Language eXtensions (LX) or iRulesLX which
enables node.js on the BIG-IP platform. The lab uses Tcl iRules and
JavaScript code to make a MySQL call to look up a client IP address
providing access control in the Multi-Layered Firewall. 


.. NOTE:: IP addresses in screenshots are examples only. Please read the
   step-by-step lab instructions to ensure that you use the correct IP
   addresses.

.. toctree::
   :maxdepth: 1
   :glob:

   lab*
