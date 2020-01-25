Lab 1: Pre-configured  pools and  virtual servers
===================================================

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

Inspect Application Pools
------------------------

On BIG-IP

Verify the following pools using the following tabel of pool information.  


**Navigation:** Local Traffic > Pools > Pool List

.. list-table::
   :header-rows: 1

   * - **Name**
     - **Health Monitor**
     - **Members**
     - **Service Port**
   * - pool\_www.site1.com
     - thttp
     - 10.1.20.11
     - 80
   * - pool\_www.site2.com
     - http
     - 10.1.20.12
     - 80
   * - pool\_www.site3.com
     - http
     - 10.1.20.13
     - 80
   * - pool\_www.site4.com
     - http
     - 10.1.20.14
     - 80
   * - pool\_www.site5.com
     - http
     - 10.1.20.15
     - 80
   * - pool\_www.dvwa.com
     - tcp\_half\_open
     - 10.1.20.17
     - 80


|image162|


Inspect Application Virtual Servers
-----------------------------------------------

By using the term 'internal' we are creating the virtual servers on what is essentially a loopback VLAN which prevents them from being exposed. The EXT_VIP in this exercise is used to forward traffic with specific characteristics to the internal VIP's. THis is accomplished by assigning a traffic policy to the VIP. The traffic policy is described and inspected in the next section. For this class, the Wildcard Virtual servers (Blue Square  status indicator)  are used in a different lab 


**Navigation:** Local Traffic > Virtual Servers > Virtual Server List


|image163|


Inspect the Local Traffic Network Map

**Navigation:** Local Traffic > Network Map

|image7|

.. NOTE:: The virtual servers should now show a green circle for status.

.. NOTE:: This completes Module 1 - Lab 1



.. |image162| image:: /_static/class2/image162.png
.. |image163| image:: /_static/class2/image163.png
.. |image1| image:: /_static/class2/image3.png
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
.. |image7| image:: /_static/class2/image7.png
   :width: 7.05000in
   :height: 4.46949in
.. |image8| image:: /_static/class2/image10.png
   :width: 7.05556in
   :height: 2.63889in
.. |image9| image:: /_static/class2/image11.png
   :width: 7.05556in
.. |image10| image:: /_static/class2/image12.png
   :width: 7.05556in

