Creating AFM Network Firewall Rules
===================================

Default Actions
~~~~~~~~~~~~~~~

The BIG-IP\ :sup:`®` Network Firewall provides policy-based access
control to and from address and port pairs, inside and outside of your
network. Using a combination of contexts, the network firewall can apply
rules in many ways, including: at a global level, on a per-virtual
server level, and even for the management port or a self IP address.
Firewall rules can be combined in a firewall policy, which can contain
multiple context and address pairs, and is applied directly to a virtual
server.

By default, the Network Firewall is configured in ***ADC mode***, a
default allow configuration, in which all traffic is allowed through the
firewall, and any traffic you want to block must be explicitly
specified.

The system is configured in this mode by default so all traffic on your
system continues to pass after you provision the Advanced Firewall
Manager. You should create appropriate firewall rules to allow necessary
traffic to pass before you switch the Advanced Firewall Manager to
Firewall mode. In ***Firewall mode***, a default deny configuration, all
traffic is blocked through the firewall, and any traffic you want to
allow through the firewall must be explicitly specified.

The BIG-IP\ :sup:`®` Network Firewall provides policy-based access
control to and from address and port pairs, inside and outside of your
network. By default, the network firewall is configured in ADC mode,
which is a ***default allow*** configuration, in which all traffic is
allowed to virtual servers and self IPs on the system, and any traffic
you want to block must be explicitly specified. This applies only to the
Virtual Server & Self IP level on the system.

Important: Even though the system is in a default allow configuration,
if a packet matches no rule in any context on the firewall, a Global
Drop rule drops the traffic.

Rule Hierarchy
==============

With the BIG-IP\ :sup:`®` Network Firewall, you use a context to
configure the level of specificity of a firewall rule or policy. For
example, you might make a global context rule to block ICMP ping
messages, and you might make a virtual server context rule to allow only
a specific network to access an application.

Context is processed in this order:

-  Global

-  Route domain

-  Virtual server / self IP

-  Management port\*

-  Global drop\*

The firewall processes policies and rules in order, progressing from the
global context, to the route domain context, and then to either the
virtual server or self IP context. Management port rules are processed
separately, and are not processed after previous rules. Rules can be
viewed in one list, and viewed and reorganized separately within each
context. You can enforce a firewall policy on any context except the
management port. You can also stage a firewall policy in any context
except management.

Important: You cannot configure or change the Global Drop context. The
Global Drop context is the final context for traffic. Note that even
though it is a global context, it is not processed first, like the main
global context, but last. If a packet matches no rule in any previous
context, the Global Drop rule drops the traffic.

|image9|

Create and View Log Entries
===========================

In this section, you will generate various types of traffic through the
virtual server as you did previously, but now you will view the log
entries using the network firewall log. Open the ***Security > Event
Logs > Network > Firewall*** page on bigip01.agility.com (10.0.0.4). The
log file is empty because no traffic has been sent to the virtual server
since you enabled logging.

-  Open a new Web browser and access your ***wildcard\_vs***
   `*http://10.128.10.223* <http://10.128.10.223>`__

-  Edit the URL to
   `*http://10.128.10.223:8081* <http://10.128.10.223:8081>`__

-  Edit the URL to `*https://10.128.10.223* <https://10.128.10.223>`__

-  Open either Chrome or Firefox and access
   `*ftp://10.128.10.223* <ftp://10.128.10.223>`__

-  Open Putty and access 10.128.10.223, you do not need to log in.

-  Close all Web browsers and Putty sessions.

-  In the Configuration Utility, reload the Firewall log page.

   -  ***Security > Event Logs > Network > Firewall***

-  Sort the list in descending order by the Time column.

|image10|

Examine the Source Address and Destination Port values. Note how
requests for all services were established and none were blocked.
Although we will not configure external logging in this lab, you should
be aware that the BIG-IP supports high speed external logging in various
formats including ***SevOne***, ***Splunk*** and ***ArcSight***. Below
are some examples of AFM Firewall and DoS logs being presented by
SevOne:

|image11|

Create a Rule List
==================

Rule lists are a way to group a set of individual rules together and
apply them to the active rule base as a group. A typical use of a rule
list would be for a set of applications that have common requirements
for access protocols and ports. As an example, most web applications
would require TCP port 80 for HTTP and TCP port 443 for SSL/TLS. You
could create a Rule list with these protocols, and apply them to each of
your virtual servers.

Let’s examine some of the default rule lists that are included with AFM.
Go to ***Security >Network Firewall > Rule Lists***. They are:

-  \_sys\_self\_allow\_all

-  \_sys\_self\_allow\_defaults

-  \_sys\_self\_allow\_management

|image12|

If you click on ***\_sys\_self\_allow\_management*** you’ll see that it
is made up of two different rules that will allow management traffic
(port 22/SSH and port 443 HTTPS). Instead of applying multiple rules
over and over across multiple virtual servers, you can put them in a
rule list and then apply the rule list as an ACL.

|image13|

On bigip01.agility.com (10.0.0.4) create a rule list to allow Web
traffic. A logical container must be created before the individual rules
can be added. You will create a list with three rules, to allow port 80
(HTTP), allow port 443 (HTTPS) and reject traffic from a specific IP
subnet. First you need to create a container for the rules by going to
***Security > Network Firewall > Rule Lists*** and select ***Create*.**
For the ***Name*** enter ***web\_rule\_list***, provide an optional
description and then click ***Finished*.**

|image14|

Edit the ***web\_rule\_list*** by selecting it in the Rule Lists table,
then click the ***Add*** button in the Rules section. Here you will add
three rules into the list; the first is a rule to allow HTTP.

|image15|

+---------------------------+------------------------------------------------------+
| **Name**                  | allow\_http                                          |
+---------------------------+------------------------------------------------------+
| **Protocol**              | TCP                                                  |
+---------------------------+------------------------------------------------------+
| **Source**                | Leave at Default of ***Any***                        |
+---------------------------+------------------------------------------------------+
| **Destination Address**   | Any                                                  |
+---------------------------+------------------------------------------------------+
| **Destination Port**      | Specify Single Port ***80***, then click ***Add***   |
+---------------------------+------------------------------------------------------+
| **Action**                | Accept                                               |
+---------------------------+------------------------------------------------------+
| **Logging**               | Enabled                                              |
+---------------------------+------------------------------------------------------+

|image16|

Select **Repeat** when done.

Create a rule to allow HTTPS.

+---------------------------+-------------------------------------------------+
| **Name**                  | allow\_https                                    |
+---------------------------+-------------------------------------------------+
| **Protocol**              | TCP                                             |
+---------------------------+-------------------------------------------------+
| **Source**                | Leave at Default of Any                         |
+---------------------------+-------------------------------------------------+
| **Destination Address**   | Any                                             |
+---------------------------+-------------------------------------------------+
| **Destination Port**      | Specify Single Port 443, then click ***Add***   |
+---------------------------+-------------------------------------------------+
| **Action**                | Accept                                          |
+---------------------------+-------------------------------------------------+
| **Logging**               | Enabled                                         |
+---------------------------+-------------------------------------------------+

Select **Finished** when done. Create another rule by clicking ***Add***
to reject all access from the 10.0.10.0/24 network.

+---------------------------+----------------------------------------------+
| **Name**                  | reject\_10\_0\_10\_0                         |
+---------------------------+----------------------------------------------+
| **Protocol**              | Any                                          |
+---------------------------+----------------------------------------------+
| **Source**                | Address 10.0.10.0/24, then click ***Add***   |
+---------------------------+----------------------------------------------+
| **Destination Address**   | Any                                          |
+---------------------------+----------------------------------------------+
| **Destination Port**      | Any                                          |
+---------------------------+----------------------------------------------+
| **Action**                | Reject                                       |
+---------------------------+----------------------------------------------+
| **Logging**               | Enabled                                      |
+---------------------------+----------------------------------------------+

Select ***Finished*** when done. When you exit you’ll notice the reject
rule is after the ***allow\_http*** and ***allow\_https*** rules. This
means that HTTP and HTTPS traffic from 10.0.10.0/24 will be accepted,
while all other traffic from this subnet will be rejected based on the
ordering of the rules as seen below:

|image17|

Create a Policy with a Rule List
================================

Policies are a way to group a set of individual rules together and apply
them to the active policy base as a group. A typical use of a policy
list would be for a set of rule lists that have common requirements for
access protocols and ports.

Create a policy list to allow the traffic you created in the rule list
in the previous section. A logical container must be created before the
individual rules can be added. First you need to create a container for
the policy by going to ***Security > Network Firewall > Policies*** and
select ***Create*.** For the ***Name*** enter ***rd\_0\_policy***,
provide an optional description and then click ***Finished*.**

|image18|

Edit the ***rd\_0\_policy*** by selecting it in the Policy Lists table,
then click the ***Add*** button in the Rules section. Here you will add
the rule list you created in the previous section. For the ***Name***
enter ***web\_policy***, provide an optional description, for type
select ***Rule List,*** select the Rule List “\ ***web\_rule\_list***\ ”
and then click ***Finished*.**

|image19|

When finished your policy should look similar to the screenshot below.

|image20|

Add the Rule List to a Route Domain
===================================

In this section, you are going to attach the rule to a route domain
using the ***Security*** selection in the top bar within the ***Route
Domain*** GUI interface. Go to ***Network***, then click on ***Route
Domains***, then select the hyperlink for route domain ***0***. Now
click on the ***Security*** top bar selection, which is a new option
that was added in version 11.3. From the Network Firewall Enforcement
dropdown menu select enabled. Select the policy you just created
“rd\_0\_policy” and click update.

Review the rules that are now applied to this route domain.

|image21|

We will insert a reject clause into the existing rule list so that you
can examine different types of log entries. Go to ***Security > Network
Firewall > Rule Lists***. Select the ***web\_rule\_list*** you created
earlier so that you may edit it, and then click the ***Add*** button.

|image22|

For ***Name*** configure ***reject\_all***, and leave all options
default except set ***Action*** for ***Reject***, and set ***Logging***
to ***Enabled***, then click ***Finished***.

|image23|

Your rule set should look similar to the screenshot below:

|image24|

.. |image9| image:: /_static/class1/image10.png
   :width: 4.74410in
   :height: 5.21054in
.. |image10| image:: /_static/class1/image11.png
   :width: 7.25069in
   :height: 1.99792in
.. |image11| image:: /_static/class1/image12.png
   :width: 6.50000in
   :height: 1.86458in
.. |image12| image:: /_static/class1/image13.png
   :width: 6.50000in
   :height: 1.46319in
.. |image13| image:: /_static/class1/image14.png
   :width: 6.50000in
   :height: 0.80278in
.. |image14| image:: /_static/class1/image15.png
   :width: 3.26105in
   :height: 1.47052in
.. |image15| image:: /_static/class1/image16.png
   :width: 6.30515in
   :height: 1.66925in
.. |image16| image:: /_static/class1/image17.png
   :width: 3.34926in
   :height: 3.60993in
.. |image17| image:: /_static/class1/image18.png
   :width: 6.50000in
   :height: 0.48681in
.. |image18| image:: /_static/class1/image19.png
   :width: 4.92847in
   :height: 1.35694in
.. |image19| image:: /_static/class1/image20.png
   :width: 4.04722in
   :height: 1.93264in
.. |image20| image:: /_static/class1/image21.png
   :width: 6.47361in
   :height: 1.78958in
.. |image21| image:: /_static/class1/image22.png
   :width: 6.49514in
   :height: 2.50556in
.. |image22| image:: /_static/class1/image23.png
   :width: 6.50000in
   :height: 0.78750in
.. |image23| image:: /_static/class1/image24.png
   :width: 2.49327in
   :height: 2.28456in
.. |image24| image:: /_static/class1/image25.png
   :width: 6.50000in
   :height: 0.91667in
