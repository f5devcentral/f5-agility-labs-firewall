Configure A Firewall Policy and Firewall Rules For Each Application
-------------------------------------------------------------------

A network firewall policy is a collection of network firewall rules that can be applied to a virtual server. In our lab, we will create two policies, each of which includes two rules. This policy will then be applied to the appropriate virtual servers and tested.

Create The downloads\_policy Firewall Policy And Rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example provides a firewall policy to the **www.mysite.com\/downloads** portion of the application. A real world example of this would be with companies hosting cryptographic software which is subject to export restrictions. In this case we will use the Geolocation feature to block access from a couple countries only and only on the /downloads portion of the application, while access to **www** remains unaffected.

**Navigation:** Security > Network Firewall > Policies, then click Create

+------------+---------------------+
| **Name**   | downloads\_policy   |
+------------+---------------------+

|image30|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

Create an IP Drop Network Firewall Rule

**Navigation:** Click Add

|image31|

+----------------+----------------------------------------+
| **Name**       | block\_export\_restricted\_countries   |
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

|image32|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

+---------------+---------------+
| **Name**      | permit\_log   |
+===============+===============+
| **Order**     | Last          |
+---------------+---------------+
| **Action**    | Accept        |
+---------------+---------------+
| **Logging**   | Enabled       |
+---------------+---------------+

Create Permit Log Network Firewall Rule

|image33|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

|image34|

From client machine try to connect again to the application site.

URL: https://www.mysite.com/downloads/

|image35|

.. NOTE:: We want to validate the site is available before and after applying the Network Firewall Policy

Assign The Policy To The Virtual Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A unique feature of the BIG-IP Firewall Module allows L3-4 security policies to be assigned specifically to an application i.e. Virtual Server. So each application can have its own firewall policy separate from other application virtual servers.

Apply the Network Firewall Policy to Virtual Server

+----------------------+-----------------------------------------------+
| **Virtual Server**   | int\_vip\_www.mysite.com-downloads\_1.1.1.3   |
+======================+===============================================+
| **Enforcement**      | Enabled                                       |
+----------------------+-----------------------------------------------+
| **Policy**           | downloads\_policy                             |
+----------------------+-----------------------------------------------+
| **Log Profile**      | firewall\_log\_profile                        |
+----------------------+-----------------------------------------------+

|image36|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Update

From client machine validate that you can still reach the application as you did in Lab3.

URL: https://www.mysite.com/downloads/

|image37|

.. NOTE:: We want to ensure the site is still available
   after applying the policy. We will get into testing the block later.

Create A Separate Policy For The API Virtual Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now we want to create a second policy for access to the \/api\/
application

Create Network Firewall Policy

**Navigation:** Security > Network Firewall > Policies, then click Create

+------------+---------------+
| **Name**   | api\_policy   |
+------------+---------------+

|image38|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

Create Allow TCP Port 80 From Host 172.16.99.5 Network Firewall Rule

**Navigation:** Click Add

|image39|

+----------------+------------------------+
| **Name**       | allow\_api\_access     |
+================+========================+
| **Order**      | First                  |
+----------------+------------------------+
| **Protocol**   | TCP (6)                |
+----------------+------------------------+
| **Source**     | Address: 172.16.99.5   |
+----------------+------------------------+
| **Action**     | Accept                 |
+----------------+------------------------+
| **Logging**    | Enabled                |
+----------------+------------------------+

|image40|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

.. NOTE:: As we are deployed in “ADC Mode” where the default action on a virtual server is ‘Accept’, we must also create a default deny rule.

For further discussion of Firewall vs ADC modes, please consult the F5 BIG-IP documentation.

https://support.f5.com/kb/en-us/products/big-ip-afm/manuals/product/network-firewall-policies-implementations-13-0-0/8.html

+---------------+-------------+
| **Name**      | deny\_log   |
+===============+=============+
| **Order**     | Last        |
+---------------+-------------+
| **Action**    | Drop        |
+---------------+-------------+
| **Logging**   | Enabled     |
+---------------+-------------+

Create Deny Log Network Firewall Rule

|image41|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

Apply the Network Firewall Policy to Virtual Server

+----------------------+-----------------------------------------+
| **Virtual Server**   | int\_vip\_www.mysite.com-api\_1.1.1.2   |
+======================+=========================================+
| **Enforcement**      | Enabled                                 |
+----------------------+-----------------------------------------+
| **Policy**           | api\_policy                             |
+----------------------+-----------------------------------------+
| **Log Profile**      | firewall\_log\_profile                  |
+----------------------+-----------------------------------------+

|image42|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Update

From client machine

URL: https://www.mysite.com/api

|image43|

.. ATTENTION:: You should no longer be able to access the /api site because the only allowed address is 172.16.99.5. You can verify this in the logs. What is the IP address that is trying to connect?

|image44|

.. NOTE:: This concludes Module 1 - Lab 4

.. |image30| image:: /_static/class2/image32.png
   :width: 7.04167in
   :height: 1.70833in
.. |image31| image:: /_static/class2/image33.png
   :width: 7.04167in
   :height: 2.33333in
.. |image32| image:: /_static/class2/image34.png
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