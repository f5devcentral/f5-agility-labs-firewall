Leverage LTM Policies To Direct SSL Terminated Applications To Secondary Virtual Servers
========================================================================================

Introduced in TLS 1.0 as a TLS extension, Server Name Indication (SNI) allows the client to send the hostname they are trying to connect to in the SSL handshake. This allows the Application Delivery Controllers (ADC) such as the BIG-IP and the Application servers to identify the appropriate application the client is trying to connect to. From this information, the ADC can respond with the proper SSL certificate to the client allowing the ADC to provide SSL enabled services for multiple applications from a single IP address.

LTM policies are another way to programatically modify traffic as it is flowing through the data plane of the BIG-IP. This functionality can also be accomplished with F5 iRules. The advantage this has over iRules is that LTM policies can be modified and appended to the existing configuration without replacing the entire application configuration. This lends itself to being updated through the CLI or via the REST API easily.

If you make a single change to an iRule, the entire iRule needs to be re-uploaded and applied.

The LTM policy is what directs application traffic to flow from the external virtual server to the internal virtual servers based on the Layer 7 request. In this case, since we are using SNI to terminate multiple applications (mysite,yoursite,theirsite, api, downloads) we need to be able to direct that traffic to the appropriate application pools. Some can even come back to the same application pool.

Whether it is based on the hostname or the URI path, the request can be forwarded to a different virtual server or an application pool of servers.

Create the LTM Policies
-----------------------

**Navigation:** Local Traffic > Policies : Policy List > Policy List Page,
then click Create

+-------------------+------------------------------------------------------------------------+
| **Policy Name**   | HTTPS\_Virtual\_Targeting\_PolicyL7                                    |
+===================+========================================================================+
| **Strategy**      | Execute ***best*** matching rule using the ***best-match*** strategy   |
+-------------------+------------------------------------------------------------------------+

**Navigation:** Click Create Policy

|image11|

**Navigation:** Local Traffic > Policies : Policy List >
/Common/HTTPS\_Virtual\_Targeting\_PolicyL7

|image12|

The policy configuration should now include a Rules section

**Navigation:** Click Create

You will need to create the following rules within your policy:

+----------------------------------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **Rule Name**                                            |                   |                  |               |                                               |
+==========================================================+===================+==================+===============+===============================================+
| `**www.mysite.com** <http://www.mysite.com>`__           | HTTP Host         | Host             | is            | www.mysite.com                                |
+----------------------------------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **ACTION**                                               | Forward Traffic   | Virtual Server   |               | int\_vip\_www.mysite.com\_1.1.1.1             |
+----------------------------------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| `**www.yoursite.com** <http://www.yoursite.com>`__       | HTTP Host         | Host             | is            | www.yoursite.com                              |
+----------------------------------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **ACTION**                                               | Forward Traffic   | Virtual Server   |               | int\_vip\_www.yoursite.com\_3.3.3.3           |
+----------------------------------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| `**www.theirsite.com** <http://www.theirsite.com>`__     | HTTP Host         | Host             | is            | www.theirsite.com                             |
+----------------------------------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **ACTION**                                               | Forward Traffic   | Virtual Server   |               | int\_vip\_www.theirsite.com\_2.2.2.2          |
+----------------------------------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| `**www.mysite.com-api** <http://www.mysite.com-api>`__   | HTTP Host         | host             | is            | www.mysite.com                                |
+----------------------------------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
|                                                          | HTTP URI          | path             | begins with   | /api                                          |
+----------------------------------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **ACTION**                                               | Forward Traffic   | Virtual Server   |               | int\_vip\_www.mysite.com-api\_1.1.1.2         |
+----------------------------------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
|                                                          | Replace           | http uri         | path          | with **/**                                    |
+----------------------------------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **www.mysite.com-downloads**                             | HTTP Host         | host             | is            | www.mysite.com                                |
+----------------------------------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
|                                                          | HTTP URI          | path             | begins with   | /downloads                                    |
+----------------------------------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **ACTION**                                               | Forward Traffic   | Virtual Server   |               | int\_vip\_www.mysite.com-downloads\_1.1.1.3   |
+----------------------------------------------------------+-------------------+------------------+---------------+-----------------------------------------------+

**Navigation:** Remember to click Add after adding the matching string

|image13|

**Navigation:** Click Save

Additional Example for /api. The replacement line is required to strip
the path from the request for the site to work.

|image14|

**Complete the additional policies according to the list above.**

Once complete publish the policy.

**Navigation:** Local Traffic > Policies: Policy List >
/Common/HTTPS\_Virtual\_Targeting\_PolicyL7

**Navigation:** Click Publish

|image15|

Apply The Policy To The External Virtual Server
-----------------------------------------------

**Navigation:** Local Traffic > Virtual Servers : Virtual Server List

|image16|

**Navigation:** Click the EXT\_VIP\_10.10.90.30

|image17|

**Navigation:** Click the Resources Tab

|image18|

**Navigation:** Under Policies Click Manage

|image19|

**Navigation:** Select the HTTPS\_Virtual\_Targeting\_PolicyL7

|image20|

**Navigation:** Click the Double Arrow to move the policy into the left-hand
column and click Finished.

|image21|

The result should look like the screenshot below.

|image22|

Validate Lab 2 Configuration
----------------------------

**Validation:** This lab is using self-signed certificates. You can
either open a web browser on the test client or run CURL from the CLI to
validate your configuration.

**You will need to accept the certificate to proceed to the application sites**

**With curl you need to use the -k option to ignore certificate validation**

.. NOTE:: You may have to edit the hosts file on your Win7 Client to add:

.. code-block:: console

   10.10.99.30 www.mysite.com

   10.10.99.30 www.yoursite.com

   10.10.99.30 www.theirsite.com

|image23|

From a terminal window (use Cygwin on Win7 Client Desktop). Curl will
let us do some of the additional testing in later sections.

.. code-block:: console

   curl -k https://10.10.99.30 -H 'Host:www.mysite.com'

   <H1> MYSITE.COM </H1>

   curl -k https://10.10.99.30 -H 'Host:www.theirsite.com'

   <H1> THEIRSITE.COM </H1>

   curl -k https://10.10.99.30 -H 'Host:www.yoursite.com'

   <H1> YOURSITE.COM </H1>

   curl -k https://10.10.99.30/api -H 'Host:www.mysite.com'

.. code-block:: console

   {
      "web-app": {
        "servlet": [
           {
              "servlet-name": "cofaxCDS",
              "servlet-class": "org.cofax.cds.CDSServlet"
           }
    ...   

.. NOTE:: A bunch of nonsense JSON should be returned.

.. code-block:: console

   curl -k https://10.10.99.30/downloads/ -H 'Host:www.mysite.com'

.. code-block:: html

   <html>
   <head>
     <title>Index of /downloads</title>
   </head>
   <body>

.. NOTE:: A larger page with this title should be displayed.

.. NOTE:: This completes Module 1 - Lab 2

.. |image9| image:: /_static/class2/image11.png
   :width: 7.05556in
   :height: 6.20833in
.. |image10| image:: /_static/class2/image12.png
   :width: 7.05556in
   :height: 3.45833in
.. |image11| image:: /_static/class2/image13.png
   :width: 7.08611in
   :height: 1.97069in
.. |image12| image:: /_static/class2/image14.png
   :width: 7.04167in
   :height: 2.62500in
.. |image13| image:: /_static/class2/image15.png
   :width: 7.05000in
   :height: 2.63403in
.. |image14| image:: /_static/class2/image16.png
   :width: 7.05000in
   :height: 3.29861in
.. |image15| image:: /_static/class2/image17.png
   :width: 7.05556in
   :height: 1.68056in
.. |image16| image:: /_static/class2/image18.png
   :width: 7.05000in
   :height: 2.35764in
.. |image17| image:: /_static/class2/image19.png
   :width: 7.04167in
   :height: 2.25000in
.. |image18| image:: /_static/class2/image20.png
   :width: 7.05556in
   :height: 0.80556in
.. |image19| image:: /_static/class2/image21.png
   :width: 7.05556in
   :height: 3.34722in
.. |image20| image:: /_static/class2/image22.png
   :width: 7.04167in
   :height: 2.56944in
.. |image21| image:: /_static/class2/image23.png
   :width: 7.04167in
   :height: 2.59722in
.. |image22| image:: /_static/class2/image24.png
   :width: 7.04167in
   :height: 4.31944in
.. |image23| image:: /_static/class2/image25.png
   :width: 7.05000in
   :height: 1.60208in