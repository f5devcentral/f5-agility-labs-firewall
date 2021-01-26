Getting Started
===============

Check your email for an invitation from noreply@registration.udf.f5.com (Check your SPAM folder if you cant locate the email

The email will contain yur username and temporart Passwords

Click the how to join a training class 

.. Note:: You will not need to generate an SSH key for this course. All connectivity will be done from the "Jump Host"

Click the hyperlink Log in **here** 

|image301| :: /_static/class2/image301.png

Select the course you wnat to take and press **Launch**

|image302| :: /_static/class2/image302.png

Press the blue **Join** button to enter the  class

Review the **Deployment Description**

Select the Deployment Tab at the top of the screen

|image303| :: /_static/class2/image303.png

Wait about 10 minutes for the **F5 Products** and **Systems** to complete Startup

.. Note:: The Windows  Jump host takes a few minutes to complete startup.. Be patient even if it shows a green indication

Select the **Access** link below the **Windows Jumpbox** and select **RDP** and the correct resolution for your monitor

Select **More Choices**  / **Use A Different Account** from the RDP login screen

**Credentials**

username: external_user

password: P@ssw0rd!

|image304| :: /_static/class2/image304.png

.. note:: Disregard the Licensing Error

Firewall Rule Hierarchy
-----------------------

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

|image300|

.. TIP:: You cannot configure or change the Global Drop context. The Global Drop context is the final context for traffic. Note that even though it is a global context, it is not processed first, like the main global context, but last. If a packet matches no rule in any previous context, the Global Drop rule drops the traffic.

.. TIP:: Use the Chrome Browser on the Jump Host desktop to configure BIG-IP 1 10.1.1.4. The login credentials are on the BIG-IP login page 


Lab 1: Pre-configured  pools and  virtual servers
===================================================

A virtual server is used by BIG-IP to identify specific types of
traffic. Other objects such as profiles, policies, pools and iRules are
applied to the virtual server to add features and functionality. In the
context of security, since BIG-IP is a default-deny device, a virtual
server is necessary to accept specific types of traffic.

The pool is a logical group of hosts that is applied to and will receive
traffic from a virtual server.

On your personal  device

Look at the supplemental login instructions for:

* External Hostnames

* External IP addressing diagram

* Login IDs and Passwords are subject to change as well.

|image1| :: /_static/class2/image1.png

.. Note:: Use the Chrome Browser to Connect to BIG-IP01--- https://10.1.1.4 Credentials are displayed in the login screen

Inspect Application Pools
-------------------------

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
     - http
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
-----------------------------------

By using the term 'internal' we are creating the virtual servers on what is essentially a loopback VLAN which prevents them from being exposed. The EXT_VIP in this exercise is used to forward traffic with specific characteristics to the internal VIP's. This is accomplished by assigning a traffic policy to the VIP. The traffic policy is described and inspected in the next section. For this class, the Wildcard Virtual servers (Blue Square  status indicator)  are not used. 

**Navigation:** Local Traffic > Virtual Servers > Virtual Server List

|image163| image:: /_static/class1/image163.png

Inspect the Local Traffic Network Map

**Navigation:** Local Traffic > Network Map

|image7|

.. NOTE:: The virtual servers should show a green circle for status.

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
   :height: 5.46949in
.. |image8| image:: /_static/class2/image10.png
   :width: 7.05556in
   :height: 2.63889in
.. |image9| image:: /_static/class2/image11.png
   :width: 7.05556in
.. |image10| image:: /_static/class2/image12.png
   :width: 7.05556in
.. |image300| image:: /_static/class2/image300.png
   :width: 7.05556in
.. |image301| image:: /_static/class2/image301.png
   :width: 7.05556in
.. |image302| image:: /_static/class2/image302.png
   :width: 7.05556in
.. |image303| image:: /_static/class2/image303.png
   :width: 7.05556in
.. |image304| image:: /_static/class2/image304.png
   :width: 7.05556in
