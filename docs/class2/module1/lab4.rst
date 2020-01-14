Lab 4: Configure A Firewall Policy and Firewall Rules For Each Application
==========================================================================

A network firewall policy is a collection of network firewall rules that can be applied to a virtual server. 
In our lab, we will create two policies, each of which includes two rules. This policy will then be applied 
to the appropriate virtual servers and tested.

Create The geo_restrict Firewall Rule List and Firewall Policy.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example provides a firewall policy to the **www.site1.com** portion of the application. A real world
example of this would be with companies hosting cryptographic software which is subject to export 
restrictions. In this case we will use the Geolocation feature to block access from a couple countries 
only and only on the site1.com application.

**Navigation:** Security > Network Firewall > Policies, then click Create

+------------+---------------------+
| **Name**   | site1_policy        |
+------------+---------------------+

|image256|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished


Create an IP Drop Network Firewall Rule List

Note: we could have created a rule directly in the policy. Using Rule lists allows us to re-use this in multiple policies

**Navigation:** Security > Network Firewall > Rule Lists then click Create

+------------+-------------------------+
| **Name**   | geo_restrict_rule_list  |
+------------+-------------------------+

|image253|

**Navigation:** Click Finished

**Navigation:** Click the geo_restrict_rule_list you just created

**Navigation:** Click Add


+----------------+----------------------------------------+
| **Name**       | block_AF_CN_CA                         |
+================+========================================+
| **Order**      | First                                  |
+----------------+----------------------------------------+
| **Protocol**   | Any                                    |
+----------------+----------------------------------------+
| **Source**     | Country/Region: AF,CN,CA               |
+----------------+----------------------------------------+
| **Action**     | Drop                                   |
+----------------+----------------------------------------+
| **Logging**    | Enabled                                |
+----------------+----------------------------------------+


.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click repeat

**Navigation:** Click Add

+---------------+---------------+
| **Name**      | permit\_log   |
+===============+===============+
| **Order**     | Last          |
+---------------+---------------+
| **Action**    | Accept        |
+---------------+---------------+
| **Logging**   | Enabled       |
+---------------+---------------+

Create Permit Log Network Firewall Rule.

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

|image252|

Assign the geo_restrict_rule_list to the site1_policy

**Navigation:** Security > Network Firewall > Policies then click Add Rule List

In the name field  start typing geo in the rule listfield. Select geo_restrict_rule_list 

**Navigation:** Click Done Editing

**Navigation:** Click Commit Changes to System

.. NOTE:: We want to validate the site is available before and after applying the Network Firewall Policy

From client machine try to connect again to the application site.

URL: https://site1.com

We will use Cywin Terminal for more controlled testing in 

.. code-block:: console

   curl -k https://10.1.10.30/ -H 'Host: site1.com'

|image255|

.. NOTE:: We want to validate the site is available before and after applying the Network Firewall Policy

Assign The Policy To The Virtual Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A unique feature of the BIG-IP Firewall Module allows L3-4 security policies to be assigned specifically to an application i.e. Virtual Server. So each application can have its own firewall policy separate from other application virtual servers.

Apply the Network Firewall Policy to Virtual Server

**Navigation:** Local Traffic > Virtual Servers then click int_vip_www.site1.com_1.1.1.1

**Navigation:** Click on the Security Tab and select Policies


+----------------------+-----------------------------------------------+
| **Virtual Server**   | int_vip_www.site1.com_1.1.1.1                 |
+======================+===============================================+
| **Enforcement**      | Enabled                                       |
+----------------------+-----------------------------------------------+
| **Policy**           | site1_policy                                  |
+----------------------+-----------------------------------------------+
| **Log Profile**      | enabled                                       |
+----------------------+-----------------------------------------------+
| **Log Profile**      | firewall\_log\_profile                        |
+----------------------+-----------------------------------------------+

|image36|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Update

From client machine validate the behavior of the Policy an dthe associated Rule List

Many enterprise sites have some or all of their content served up by Content Delivery Networks (CDN). 
This common use case leverages proxies to provide static content closer to the end client machines for 
performance. Because of this there may only be one or two IP addresses connecting to the origin website. 
The original IP address of the client in this case is often mapped to a common HTTP header X-Forwarded-For 
or some variation. In this deployment, the BIG-IP can translate the original source of the request in the 
XFF to the source IP address.

Use Cywin Terminal to allow us to specify the sX-Forwarded -For header. . There is an iRule
applied to   EXT_VIP_10_1_10_30 which SNAT's the source IP to match the X-Forwarded-For header

**XFF-SNAT iRule**

.. code-block:: tcl 

when HTTP_REQUEST {
  if {[HTTP::header exists "X-Forwarded-For"]}  {
  snat [HTTP::header X-Forwarded-For]
  log local0. '[HTTP::header X-Forwarded-For]'
  }
}

.. code-block:: console

   curl -k https://10.1.10.30/ -H 'Host: site1.com' 

.. Note: Since we did nit define the header, the firewall will see the RFC 1918 Addres of the jump host 
   (10.1.10.199) which is allowed

URL: https://site1.com

Use the -H option in curl to define the X-Forwarded-For Header. This will trigger the iRule addigned to the
External VIP to simulate specific IP addresses in the header

RFC 1918 addresses are considerd US addresses by the Geolocation database

.. code-block:: console

   curl -k https://10.1.10.30/ -H 'Host:site1.com' -H 'X-Forwarded-For: 172.16.99.5'

Next we will simulate a connection an IP address in Bejing, China

The BIG-IP Geolocation database is supplied by Digital Element http://www.digitalelement.com/ 

https://whatismyipaddress.com/ip/1.202.2.1 shows that this address is in Beijing , China

.. code-block:: console

   curl -k https://10.1.10.30/ -H 'Host: www.site1.com' -H 'X-Forwarded-For: 1.202.2.1'


Create A Separate Policy For The site2 Virtual Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now we want to create a second policy for access to site2

Create Network Firewall Policy

**Navigation:** Security > Network Firewall > Policies, then click Create

+------------+---------------+
| **Name**   | site2_policy   |
+------------+---------------+

|image257|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

Create Allow TCP Port 80 From Host 172.16.99.5 Network Firewall Rule. This time we will build the rules directly 
into the policy instead or using a Rule List

**Navigation:** Click on the site2_policy you just created 

**Navigation:** Click Add Rule pull down on the upper right - Add rule at beginning


+----------------+----------------------------+
| **Name**       | allow_site2_ 172.16.99.5   |
+================+============================+
| **Protocol**   | TCP (6)                    |
+----------------+----------------------------+
| **Source**     | Address: 172.16.99.5       |
+----------------+----------------------------+
| **Action**     | Accept                     |
+----------------+----------------------------+
| **Logging**    | Enabled                    |
+----------------+----------------------------+

|image258|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Done Editing

Create Deny Log Network Firewall Rule

**Navigation:** Click Add Rule pull down on the upper right - Add rule at end

.. NOTE:: As we are deployed in “ADC Mode” where the default action on a virtual server is ‘Accept’, we must also create a default deny rule.

For further discussion of Firewall vs ADC modes, please consult the F5 BIG-IP documentation.

https://support.f5.com/kb/en-us/products/big-ip-afm/manuals/product/network-firewall-policies-implementations-13-0-0/8.html


+---------------+-------------+
| **Name**      | deny_log    |
+===============+=============+
| **Action**    | Drop        |
+---------------+-------------+
| **Logging**   | Enabled     |
+---------------+-------------+

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Done Editing

|image259|

Review the rules and Click Commit Changes To System

|image260|

**Navigation:** Click Finished

Apply the Network Firewall Policy to Virtual Server

**Navigation:** Local Traffic > Virtual Servers

**Navigation:** Click on int_vip_www.site2.com_2.2.2.2

**Navigation:** Select the Security Tab and select Policies 

+----------------------+-----------------------------------------+
| **Virtual Server**   | int_vip_www.site2.com_2.2.2.2           |
+======================+=========================================+
| **Network Firewall** | Enabled                                 |
+----------------------+-----------------------------------------+
| **Policy**           | site2_policy                            |
+----------------------+-----------------------------------------+
| **Log Profile**      | enabled                                 |
+----------------------+-----------------------------------------+
| **Log Profile**      | firewall\_log\_profile                  |
+----------------------+-----------------------------------------+

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Update

|image261|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Update

From client machine

From client machine validate the behavior of the Policy an dthe associated Rule List

We will use Cywin Terminal to allow us to specify the source IP address. This is done by leveraging
an iRule which SNAT's the source IP to match the X-Forwarded-For header. This iRule is applied to 
EXT_VIP_10_1_10_30

.. code-block:: console

   curl -k https://10.1.10.30/ -H 'Host: site2.com'  


Next we will use a more specific command which leverages the iRule addigned to the
External VIP to simulate specifi IP addresses

RFC 1918 addresses are considerd US addresses by the Geolocation database

.. code-block:: console

   curl -k https://10.1.10.30/ -H 'Host:site2.com' -H 'X-Forwarded-For: 172.16.99.5'

The BIG-IP Geolocation database is supplied by Digital Element http://www.digitalelement.com/ 

https://whatismyipaddress.com/ip/1.202.2.1 shows that this address is in Beijing , China

.. code-block:: console

   curl -k https://10.1.10.30/ -H 'Host: www.site2.com' -H 'X-Forwarded-For: 1.202.2.1'

.. NOTE:: We want to ensure the site is still available
   after applying the policy. We will get into testing the block later

.. NOTE:: This concludes Module 1 - Lab 4

.. |image256| image:: /_static/class2/image256.png
   :width: 7.04167in
   :height: 1.70833in
.. |image31| image:: /_static/class2/image33.png
   :width: 7.04167in
   :height: 2.33333in
.. |image3200| image:: /_static/class2/image34.png
   :width: 7.05556in
   :height: 6.47222in
.. |image33| image:: /_static/class2/image35.png
   :width: 7.04167in
   :height: 5.02778in
.. |image34| image:: /_static/class2/image36.png
   :width: 7.04167in
   :height: 2.45833in
.. |image35| image:: /_static/class2/image37.png
   :width: 7.05556in
   :height: 3.30556in
.. |image36| image:: /_static/class2/image38.png
   :width: 7.05556in
   :height: 6.91667in
.. |image37| image:: /_static/class2/image37.png
   :width: 7.05000in
   :height: 3.30295in
.. |image38| image:: /_static/class2/image39.png
   :width: 7.04167in
   :height: 1.75000in
.. |image39| image:: /_static/class2/image40.png
   :width: 7.04167in
   :height: 2.50000in
.. |image40| image:: /_static/class2/image41.png
   :width: 7.05556in
   :height: 6.86111in
.. |image41| image:: /_static/class2/image42.png
   :width: 7.04167in
   :height: 5.04167in
.. |image42| image:: /_static/class2/image43.png
   :width: 7.04167in
   :height: 6.33333in
.. |image43| image:: /_static/class2/image44.png
   :width: 7.04167in
   :height: 4.19444in
.. |image44| image:: /_static/class2/image45.png
   :width: 7.04167in
   :height: 0.63889in
.. |image252| image:: /_static/class2/image252.png
   :width: 7.04167in
   :height: 1.70833in
.. |image253| image:: /_static/class2/image253.png
   :width: 7.04167in
   :height: 1.70833in
.. |image254| image:: /_static/class2/image254.png
   :width: 6.04167in
   :height: 7.63889in
.. |image255| image:: /_static/class2/image255.png
   :width: 7.04167in
   :height: 3.63889in
.. |image257| image:: /_static/class2/image257.png
   :width: 7.04167in
   :height: 1.70833in
.. |image258| image:: /_static/class2/image258.png
   :width: 7.04167in
   :height: 2.70833in
.. |image259| image:: /_static/class2/image259.png
   :width: 7.04167in
   :height: 3.70833in
.. |image260| image:: /_static/class2/image260.png
   :width: 7.04167in
   :height: 3.70833in
.. |image261| image:: /_static/class2/image261.png
   :width: 7.04167in
   :height: 7.70833in

