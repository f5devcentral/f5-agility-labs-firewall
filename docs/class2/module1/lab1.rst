Configure pools and internal virtual servers
============================================

A virtual server is used by BIG-IP to identify specific types of
traffic. Other objects such as profiles, policies, pools and iRules are
applied to the virtual server to add features and functionality. In the
context of security, since BIG-IP is a default-deny device, a virtual
server is necessary to accept specific types of traffic.

The pool is a logical group of hosts that is applied to and will receive
traffic from a virtual server.

On your personal device

Look at the supplemental login instructions for:

* External Hostnames

* External IP addressing diagram

* Login IDs and Passwords are subject to change as well.

|image1|

Create Application Pools
------------------------

On BIG-IP

Create a pool using the following information:

**Navigation:** Local Traffic > Pools > Pool List, then click Create

.. list-table::
   :header-rows: 1

   * - **Name**
     - **Health Monitor**
     - **Members**
     - **Service Port**
   * - pool\_www.mysite.com
     - tcp\_half\_open
     - 10.10.121.129
     - 80
   * - pool\_www.mysite.com-api
     - tcp\_half\_open
     - 10.10.121.132
     - 80
   * - pool\_www.theirsite.com
     - tcp\_half\_open
     - 10.10.121.131
     - 80
   * - pool\_www.yoursite.com
     - tcp\_half\_open
     - 10.10.121.130
     - 80

|image2|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

|image3|

.. NOTE:: The pools should now show a green circle for status.

Create **Internal** Application Virtual Servers
-----------------------------------------------

By using the term 'internal' we are creating the virtual servers on what is essentially a loopback VLAN which prevents them from being exposed.

Create the internal virtual servers using the following information:

**Navigation:** Local Traffic > Virtual Servers > Virtual Server List, then
click Create

.. list-table::
   :widths: 50 50
   :header-rows: 1

   * - **Name**
     - **Properties**
   * - ``int_vip_www.mysite.com_1.1.1.1``
     - **Dest**: ``1.1.1.1``

       **Port**: ``80``

       **HTTP Profile**: YES

       **Enabled on VLAN**: ``loopback``

       **SNAT**: AUTO

       **Default Pool**: ``pool_www.mysite.com``

   * - ``int_vip_www.mysite.com-api_1.1.1.2``
     - **Dest**: ``1.1.1.2``

       **Port**: ``80``

       **HTTP Profile**: YES

       **Enabled on VLAN**: ``loopback``

       **SNAT**: AUTO

       **Default Pool**: ``pool_www.mysite.com-api``

   * - ``int_vip_www.mysite.com-downloads_1.1.1.3``
     - **Dest**: ``1.1.1.3``

       **Port**: ``80``

       **HTTP Profile**: YES

       **Enabled on VLAN**: ``loopback``

       **SNAT**: AUTO

       **Default Pool**: ``pool_www.mysite.com``

   * - ``int_vip_www.theirsite.com_2.2.2.2``
     - **Dest**: ``2.2.2.2``

       **Port**: ``80``

       **HTTP Profile**: YES

       **Enabled on VLAN**: ``loopback``

       **SNAT**: AUTO

       **Default Pool**: ``pool_www.theirsite.com``

   * - ``int_vip_www.yoursite.com_3.3.3.3``
     - **Dest**: ``3.3.3.3``

       **Port**: ``80``

       **HTTP Profile**: YES

       **Enabled on VLAN**: ``loopback``

       **SNAT**: AUTO

       **Default Pool**: ``pool_www.yoursite.com``

|image4|

|image5|

|image6|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click **Finished**

|image7|

.. NOTE:: The virtual servers should now show a green circle for status.

Create An External Virtual Server To Host Multiple SSL Enabled Websites
-----------------------------------------------------------------------

Create the external virtual server using the following information:

**Navigation: _Local Traffic > Virtual Servers > Virtual Server List_**, then
click **Create**

.. list-table::
   :header-rows: 1

   * - **Name**
     - **Dest**
     - **Port**
     - **HTTP Profile**
     - **SSL Profile (Client)**
     - **Default Pool**
   * - EXT\_VIP\_10.10.99.30
     - 10.10.99.30
     - 443
     - YES
     - www.mysite.com

       www.theirsite.com

       www.yoursite.com
     - pool\_www.mysite.com

|image8|

|image9|

|image10|

.. NOTE:: The default pool is not necessary and might not be what you want from a security perspective but it’s here as a fallback and to let the virtual server turn green

.. ATTENTION:: Try accessing the virtual servers you created from the Windows host via ping or a web browser. The web browser on the Windows host has links saved to access it. **If you try yourself, use https://** since you enabled encyrption when you created the virtual server. Were you able to connect to any of applications? What was available? **Why are some accessible while others are not?**

.. NOTE:: This completes Module 1 - Lab 1

.. |image1| image:: /_static/class2/image3.png
   :width: 7.04167in
   :height: 3.51389in
.. |image2| image:: /_static/class2/image4.png
   :width: 6.74931in
   :height: 5.88401in
.. |image3| image:: /_static/class2/image5.png
   :width: 7.05556in
   :height: 1.33333in
.. |image4| image:: /_static/class2/image6.png
   :width: 7.05556in
   :height: 3.22222in
.. |image5| image:: /_static/class2/image7.png
   :width: 7.05556in
   :height: 7.31944in
.. |image6| image:: /_static/class2/image8.png
   :width: 7.05000in
   :height: 3.46949in
.. |image7| image:: /_static/class2/image9.png
   :width: 7.05000in
   :height: 1.50278in
.. |image8| image:: /_static/class2/image10.png
   :width: 7.05556in
   :height: 2.63889in
.. |image9| image:: /_static/class2/image11.png
   :width: 7.05556in
.. |image10| image:: /_static/class2/image12.png
   :width: 7.05556in
