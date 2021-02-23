==========================================================================
Lab 4: Configure A Firewall Policy and Firewall Rules For Each Application
==========================================================================

A network firewall policy is a collection of network firewall rules that can be applied to a virtual server. 
In our lab, we will create two policies, each of which includes two rules. This policy will then be applied 
to the appropriate virtual servers and tested.

Create the *geo_restrict* Firewall Rule List and Firewall Policy
----------------------------------------------------------------

This example provides a firewall policy to the **www.site1.com** portion of the application. A real world
example of this would be with companies hosting cryptographic software which is subject to export 
restrictions. In this case we will use the Geolocation feature to block access from a couple countries 
only and only on the site1.com application.

**Navigation:** Security > Network Firewall > Policies

Click **Create**. Enter the name *site1\_policy*.

Leave all other fields using the default values.

|image256|

Click **Finished**.

Create a *geo\_restrict\_rule\_list* Rule List
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note:: Rules can also be created directly inside of policies. Creating rule lists allow for a set of rules to be reused in multiple policies.

**Navigation:** Security > Network Firewall > Rule Lists

Click **Create**.

+------------+-------------------------+
| **Name**   | geo_restrict_rule_list  |
+------------+-------------------------+

|image253|

Click **Finished**, then click on the *geo_restrict_rule_list* you just created.

Click *Add* to add a rule.

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

.. note:: Leave all other fields using the default values.

**Navigation:** Click **Finished**.

Create Permit Log Network Firewall Rule
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

.. note:: Leave all other fields using the default values.

Click **Finished**.

|image252|

Assign the geo_restrict_rule_list to the site1_policy
-----------------------------------------------------

**Navigation:** Security > Network Firewall > Policies

Click on **site1_policy**, then click **Add Rule List**.

In the name field, start typing *geo* in the rule list field. Select **geo_restrict_rule_list**.

Click **Done Editing**, then **Commit Changes to System**.

Validate the site is available before and after applying the Network Firewall
Policy. From the second Chrome tab, try to connect again to the application site https://site1.com. 

From the desktop, launch the Cywin Terminal.

.. code-block:: console

   curl -k https://10.1.10.30/ -H 'Host: site1.com'

|image255|

.. note:: This step validates the site is available before applying the Network Firewall Policy.

Assign The Policy To The Virtual Server
---------------------------------------

A unique feature of the BIG-IP Firewall Module allows L3-4 security policies to be assigned specifically to an application i.e. Virtual Server. So each application can have its own firewall policy separate from other application virtual servers.

Apply the Network Firewall Policy to Virtual Server
---------------------------------------------------

**Navigation:** Local Traffic > Virtual Servers

Click *int_vip_www.site1.com_1.1.1.1*.

**Navigation:** Click on the **Security** drop-down and select **Policies**.

Edit the Network Firewall section of the screen:

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

|image277|

.. note:: Leave all other fields using the default values.

Click **Update**.

In order to test this geo-ip based rule, we need to simulate a connection from a prohibited country.

Many enterprise sites have some or all of their content served up by Content Delivery Networks (CDN). 
This common use case leverages proxies to provide static content closer to the end client machines for 
performance. Because of this there may only be one or two IP addresses connecting to the origin website. 
The original IP address of the client in this case is often mapped to a common HTTP header X-Forwarded-For 
or some variation. In this deployment, the BIG-IP can translate the original source of the request in the 
XFF to the source IP address.

There is an iRule applied to EXT_VIP_10_1_10_30 which SNAT's the source IP to match the X-Forwarded-For header.

**XFF-SNAT iRule**

.. code-block:: tcl

   when HTTP_REQUEST {
      if { [HTTP::header exists "X-Forwarded-For"] } {
         snat [HTTP::header X-Forwarded-For]
         log local0. [HTTP::header X-Forwarded-For]
      }
   }

Using curl will allow us to specify the X-Forwarded-For header to specify a source IP address. Let's send a 
curl request to the VIP and specify the site we want to retrieve.

.. code-block:: console

   curl -k https://10.1.10.30/ -H 'Host: site1.com' 

Since we did not define the header, the firewall will see the RFC-1918 address of the jump host (10.1.10.199).

Use the -H option in curl to define the X-Forwarded-For Header. This will trigger the iRule assigned to the
External VIP to simulate specific IP addresses in the header

.. code-block:: console

   curl -k https://10.1.10.30/ -H 'Host:site1.com' -H 'X-Forwarded-For: 172.16.99.5'

Return to the firewall events (**Security** > **Event Logs** > **Network** > **Firewall**) log viewer and click **Search** to refresh. Observe the new entries

Next, we will simulate a connection an IP address in Bejing, China. Browse to 
https://whatismyipaddress.com/ip/1.202.2.1 ... this site shows that this IP address 
is most likely in Beijing, China.

.. tip:: You can check the geo classification of an address from the BIG-IP CLI using the command *geoip_lookup 1.202.2.1*

Now issue the curl command and specify the source IP address.

.. code-block:: console

   curl -k https://10.1.10.30/ -H 'Host: site1.com' -H 'X-Forwarded-For: 1.202.2.1'

This connection attempt will fail. Return to the BIG-IP GUI and refresh the firewall event log.  

.. warning:: you may need to zoom the browser or scroll right horizontally to see the "Action" column in the event logs.

|image265|

Create A Separate Policy For The site2 Virtual Server
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Now we want to create a second policy to restrict access to site2.

**Navigation:** Security > Network Firewall > Policies

Click **Create**. Specify the **Name** of *site2\_policy*.

|image257|

.. note:: Leave all other fields using the default values.

Click **Finished**.

Modify the policy with rules to allow TCP port 80 from host 
172.16.99.5 and deny all other adresses. This time we will 
build the rules directly into the policy instead of using 
a rule list.

Click on the *site2_policy* you just created, then click the **Add Rule** pull down on the upper right.

Add the following rule at beginning:

+----------------+----------------------------+
| **Name**       | allow_site_172.16.99.5     |
+================+============================+
| **Protocol**   | TCP (6)                    |
+----------------+----------------------------+
| **Source**     | Address: 172.16.99.5       |
+----------------+----------------------------+
| **Action**     | Accept                     |
+----------------+----------------------------+
| **Logging**    | Enabled (checked)          |
+----------------+----------------------------+

.. warning:: You may need to scroll right horizontally or zoom out in your browser to see the Logging column.

|image258|

.. note:: Leave all other fields using the default values.

Click **Done Editing**.

Now, create a Deny Log Network Firewall Rule.

.. note:: As we are deployed in “ADC Mode” where the default action on a virtual server is ‘Accept’, we must also create a default deny rule. For further discussion of Firewall vs ADC modes, please consult the F5 BIG-IP documentation at https://support.f5.com/kb/en-us/products/big-ip-afm/manuals/product/network-firewall-policies-implementations-13-0-0/8.html.

Click **Add Rule** pull down on the upper-right. Add a rule to the end of the policy.

+---------------+--------------------+
| **Name**      | deny_log           |
+===============+====================+
| **Action**    | Drop               |
+---------------+--------------------+
| **Logging**   | Enabled (checked)  |
+---------------+--------------------+

.. note:: Leave all other fields using the default values.

Click **Done Editing**.

|image259|

Click **Commit Changes To System**.

|image260|

Click **Finished**.

Apply the site2_policy policy to Virtual Server
-----------------------------------------------

**Navigation:** Local Traffic > Virtual Servers

Click on *int_vip_www.site2.com_2.2.2.2*. Select the **Security** drop-down and select **Policies**.

Update the settings to reflect the values below:

+----------------------+-----------------------------------------+
| **Virtual Server**   | int_vip_www.site2.com_2.2.2.2           |
+======================+=========================================+
| **Enforcement**      | Enabled                                 |
+----------------------+-----------------------------------------+
| **Policy**           | site2_policy                            |
+----------------------+-----------------------------------------+
| **Log Profile**      | enabled                                 |
+----------------------+-----------------------------------------+
| **Log Profile**      | firewall\_log\_profile                  |
+----------------------+-----------------------------------------+

|image261|

.. note:: Leave all other fields using the default values.

Click **Update**.

From the jump host, we will now validate the behavior of the policy and the associated rule list.

Again, from the desktop, launch Cywin Terminal to allow us to specify the source IP 
address. This is done by leveraging an iRule which SNAT's the source IP to match the 
X-Forwarded-For header. This iRule is applied to *EXT_VIP_10_1_10_30*.

First, let's send a request from the IP address we allowed via firewall rule.

.. code-block:: console

   curl -k https://10.1.10.30/ -H 'Host:site2.com' -H 'X-Forwarded-For: 172.16.99.5'

Next, try the same request from an IP address that is not in the accept rule. This should fail.

.. code-block:: console

   curl -k https://10.1.10.30/ -H 'Host:site2.com' -H 'X-Forwarded-For: 172.16.99.7'

Review the logs in the BIG-IP and see that the traffic was dropped and logged.

This concludes Module 1 - Lab 4. Click **Next** to continue.

.. |image256| image:: _images/class2/image256.png
   :width: 7.04167in
   :height: 1.70833in
.. |image31| image:: _images/class2/image33.png
   :width: 7.04167in
   :height: 2.33333in
.. |image3200| image:: _images/class2/image34.png
   :width: 7.05556in
   :height: 6.47222in
.. |image33| image:: _images/class2/image35.png
   :width: 7.04167in
   :height: 5.02778in
.. |image34| image:: _images/class2/image36.png
   :width: 7.04167in
   :height: 2.45833in
.. |image35| image:: _images/class2/image37.png
   :width: 7.05556in
   :height: 3.30556in
.. |image36| image:: _images/class2/image38.png
   :width: 7.05556in
   :height: 6.91667in
.. |image37| image:: _images/class2/image37.png
   :width: 7.05000in
   :height: 3.30295in
.. |image38| image:: _images/class2/image39.png
   :width: 7.04167in
   :height: 1.75000in
.. |image39| image:: _images/class2/image40.png
   :width: 7.04167in
   :height: 2.50000in
.. |image40| image:: _images/class2/image41.png
   :width: 7.05556in
   :height: 6.86111in
.. |image41| image:: _images/class2/image42.png
   :width: 7.04167in
   :height: 5.04167in
.. |image42| image:: _images/class2/image43.png
   :width: 7.04167in
   :height: 6.33333in
.. |image43| image:: _images/class2/image44.png
   :width: 7.04167in
   :height: 4.19444in
.. |image44| image:: _images/class2/image45.png
   :width: 7.04167in
   :height: 0.63889in
.. |image252| image:: _images/class2/image252.png
   :width: 7.04167in
   :height: 1.70833in
.. |image253| image:: _images/class2/image253.png
   :width: 7.04167in
   :height: 1.70833in
.. |image254| image:: _images/class2/image254.png
   :width: 6.04167in
   :height: 7.63889in
.. |image255| image:: _images/class2/image255.png
   :width: 7.04167in
   :height: 3.63889in
.. |image257| image:: _images/class2/image257.png
   :width: 7.04167in
   :height: 1.70833in
.. |image258| image:: _images/class2/image258.png
   :width: 7.04167in
   :height: 2.70833in
.. |image259| image:: _images/class2/image259.png
   :width: 7.04167in
   :height: 3.70833in
.. |image260| image:: _images/class2/image260.png
   :width: 7.04167in
   :height: 3.70833in
.. |image261| image:: _images/class2/image261.png
   :width: 7.04167in
   :height: 7.70833in
.. |image265| image:: _images/class2/image265.png
   :width: 6
   :height: 1.25
.. |image277| image:: _images/class2/image277.png
   :width: 7.04167in
   :height: 7.70833in
