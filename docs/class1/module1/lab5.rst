Lab 5: Provide Firewall Security Policies For CDN Enabled Applications
======================================================================

Many enterprise sites have some or all of their content served up by 
Content Delivery Networks (CDN). This common use case leverages proxies 
to provide static content closer to the end client machines for 
performance. Because of this there may only be one or two IP addresses 
connecting to the origin website. The original IP address of the client 
in this case is often mapped to a common HTTP header X-Forwarded-For 
or some variation. In this deployment, the BIG-IP can translate the 
original source of the request in the XFF to the source IP address.

In this case we are going to leverage iRules to modify the traffic 
coming from the CDN networks so we can apply a firewall policy to it. 
The iRule to accomplish this is already installed on your BIG-IP and 
applied to EXT_VIP_10_1_10_30. We have been leveraging it to run the 
tests in previous exercises.

.. code-block:: tcl

   when HTTP_REQUEST {
      if { [HTTP::header exists "X-Forwarded-For"] } {
         snat [HTTP::header X-Forwarded-For]
         log local0. [HTTP::header X-Forwarded-For]
      }
   }

Examminig the iRule we find that it is called when an HTTP request 
happens. It then checks to see if the ``X-Forwarded-For`` header 
exists (We wouldn't want to SNAT to a non-existent IP address) and 
if it does it modifies the source IP address of the request to the 
IP address provided in the header.

Verify that the iRule is assigned to the Virtual Server
-------------------------------------------------------

**Navigation:** Local Traffic > Virtual Servers

**Navigation:** Click on the ``EXT_VIP_10.1.10.30`` virtual server

**Navigation:** Click on the **Resources** tab.

|image45|

**Navigation:** Click on the **Manage** button next to iRules.

This is where you assign iRules.

**Navigation:** Click on the Cancel button since the iRule is already assigned

|image46|

Validate SNAT Function
----------------------

We tested functionality in prior exercises with the commands below. 
Leverage curl from the Cygwin Terminal to insert the 
X-Forwarded-For header in to the request.

.. code-block:: console

   curl -k https://10.1.10.30 -H 'Host: site1.com' -H 'X-Forwarded-For: 1.202.2.1'

**Expected Result:** The site should be blocked by the geo_restrict_rule_list and generate a 403 Forbidden response.

.. NOTE:: Optionally you can log into the CLI on the BIG-IP. Putty BIGIP_A --Uersname: root  Password: f5DEMOs4u Then tail -f /var/log/ltm. The iRule logs the SIP

Validate that requests sourced from the X-Forwarded-For IP address of 172.16.99.5 allowed.

.. code-block:: console

   curl -k https://10.1.10.30 -H 'Host:site1.com' -H 'X-Forwarded-For: 172.16.99.5'

**Expected Result:** Page will work

.. code-block:: console

   {
     "web-app": {
       "servlet": [
       {
       "servlet-name": "cofaxCDS",
       "servlet-class": "org.cofax.cds.CDSServlet",

Solve For TCP Issues With CDN Networks
--------------------------------------

The next step is to solve for the TCP connection issue with CDN providers. While we are provided the originating client IP address, dropping or reseting the connection can be problematic for other users of the application. This solution is accomplished via AFM iRules. The iRule is already provided for you. We need to apply it to the Network Firewall downloads\_policy Policy. It still is logged as a drop or reset in the firewall logs. We allow it to be processed slightly further so that a Layer 7 response can be provided.

**Navigation:** Security > Network Firewall > Rule Lists

**Navigation:** Select **geo_restrict_rule_list**

**Navigation:** Select **block_AF_CN_CA**

**Navigation:** Add the AFM_403_Downloads iRule to the rule list.

**Navigation** Click **Update**.

|image47|

Validate that denied requests are now responded with a Layer 7 **403 Error** Page.

.. code-block:: console

   curl -k https://10.1.10.30/ -H 'Host:site1.com' -H 'X-Forwarded-For: 1.202.2.1'

Expected Result: Instead of the traffic getting dropped, a 403 error
should be returned.

.. code-block:: html

   <html>
     <head>
       <title>403 Forbidden</title>
     </head>
     <body>
        403 Forbidden Download of Cryptographic Software Is Restricted
     </body>
   </html>

.. ATTENTION:: Since a TCP solution could cause users to be blocked without 
explanation , the HTML error response will traverse the CDN network back 
only to the originating client. Using a unique error code such as 418 (I 
Am A Teapot) would allow you to determine that the webserver is likely 
not the source of the response. It would also allow the CDN network 
providers to track these error codes. Try to find one that has a sense 
of humor.

This concludes Module 1 - Lab 5. Click **Next** to continue.

.. |image45| image:: /_static/class2/image46.png
   :width: 7.04167in
   :height: 4.25000in
.. |image46| image:: /_static/class2/image47.png
   :width: 7.04167in
   :height: 2.81944in
.. |image47| image:: /_static/class2/image48.png
   :width: 7.04167in
   :height: 6.97222in
