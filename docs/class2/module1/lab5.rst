Provide Firewall Security Policies For CDN Enabled Applications
===============================================================

Many enterprise sites have some or all of their content served up by Content Delivery Networks (CDN). This common use case leverages proxies to provide static content closer to the end client machines for performance. Because of this there may only be one or two IP addresses connecting to the origin website. The original IP address of the client in this case is often mapped to a common HTTP header X-Forwarded-For or some variation. In this deployment, the BIG-IP can translate the original source of the request in the XFF to the source IP address.

In this case we are going to leverage iRules to modify the traffic coming from the CDN networks so we can apply a firewall policy to it. The iRule to accomplish this is already installed on your BIG-IP. We need to apply it the External Virtual Server. Here is a sample of the iRule.

.. code-block:: tcl

   when HTTP_REQUEST {
      if { [HTTP::header exists "X-Forwarded-For"] } {
         snat [HTTP::header X-Forwarded-For]
         log local0. [HTTP::header X-Forwarded-For]
      }
   }

Examminig the iRule we find that it is called when an HTTP request happens. It then checks to see if the ``X-Forwarded-For`` header exists (We wouldn't want to SNAT to a non-existent IP address) and if it does it modifies the source IP address of the request to the IP address provided in the header.

Apply the iRule to the Virtual Server
-------------------------------------

**Navigation:** Click on the ``EXT_VIP_10.10.99.30`` virtual server

|image45|

**Navigation:** Click Manage under the iRule section

|image46|

**Navigation:** Once you have moved the iRule XFF-SNAT over to the Enabled
Section, Click Finished

Validate SNAT Function
----------------------

To test functionality, we will need to leverage curl from the CLI to insert the X-Forwarded-For header in to the request.

.. code-block:: console

   curl -k https://10.10.99.30/downloads/ -H 'Host: www.mysite.com'

Expected Result Snippet:

.. code-block:: html

   <html>
      <head>
        <title>Index of /downloads</title>
      </head>
   <body>

Validate that IP addresses sourced from China are blocked:

.. code-block:: console

   curl -k https://10.10.99.30/downloads/ -H 'Host: www.mysite.com' -H 'X-Forwarded-For: 1.202.2.1'

**Expected Result:** The site should now be blocked and eventually timeout

Validate that requests sourced from the X-Forwarded-For IP address of 172.16.99.5 are now allowed.

.. code-block:: console

   curl -k https://10.10.99.30/api -H 'Host:www.mysite.com' -H 'X-Forwarded-For: 172.16.99.5'

**Expected Result:**

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

|image47|

**Navigation:** iRule select the AFM\_403\_Downloads

Validate that denied requests are now responded with a Layer 7 **403 Error** Page.

.. code-block:: console

   curl -k https://10.10.99.30/downloads -H 'Host: www.mysite.com' -H 'X-Forwarded-For: 1.202.2.1'

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

.. ATTENTION:: Since a TCP solution would cause disasterous consequences, the HTML error response will traverse the CDN network back only to the originating client. Using a unique error code such as 418 (I Am A Teapot) would allow you to determine that the webserver is likely not the source of the response. It would also allow the CDN network providers to track these error codes. Try to find one that has a sense of humor.

.. NOTE:: This concludes Module 1 - Lab 5

.. |image45| image:: /_static/class2/image46.png
   :width: 7.04167in
   :height: 4.25000in
.. |image46| image:: /_static/class2/image47.png
   :width: 7.04167in
   :height: 2.81944in
.. |image47| image:: /_static/class2/image48.png
   :width: 7.04167in
   :height: 6.97222in
