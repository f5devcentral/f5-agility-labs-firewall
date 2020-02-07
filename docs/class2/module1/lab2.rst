Lab 2: Leverage LTM Policies To Direct SSL Terminated Applications To Secondary Virtual Servers
===============================================================================================

What is SNI? Introduced in TLS 1.0 as a TLS extension, Server Name Indication (SNI) allows the client to send the hostname they are trying to connect to in the SSL handshake. This allows the Application Delivery Controllers (ADC) such as the BIG-IP and the Application servers to identify the appropriate application the client is trying to connect to. From this information, the ADC can respond with the proper SSL certificate to the client allowing the ADC to provide SSL enabled services for multiple applications from a single IP address.

LTM policies are another way to programatically modify traffic as it is flowing through the data plane of the BIG-IP. This functionality can also be accomplished with F5 iRules. The advantage this has over iRules is that LTM policies can be modified and appended to the existing configuration without replacing the entire application configuration. This lends itself to being updated through the CLI or via the REST API easily.

If you make a single change to an iRule, the entire iRule needs to be re-uploaded and applied.

The LTM policy is what directs application traffic to flow from the external virtual server to the internal virtual servers based on the Layer 7 request. In this case, since we are using SNI to terminate multiple applications (mysite,yoursite,theirsite, api, downloads) we need to be able to direct that traffic to the appropriate application pools. Some can even come back to the same application pool.

Whether it is based on the hostname or the URI path, the request can be forwarded to a different virtual server or an application pool of servers.

Inspect the LTM Policies
------------------------
.. NOTE:: As shown in this diagram, there is an external VIP and internal VIPs.  The external VIP has the local traffic policies on it.  


|ltp-diagram|


**Navigation:** Local Traffic > Policies : Policy List 

**Navigation:** Select HTTPS_Virtual_Targeting_Policy_L7V3 from the published policies

|image262|

Verify that the  Policy is assigned To The External Virtual Server
------------------------------------------------------------------

**Navigation:** Local Traffic > Virtual Servers : Virtual Server List


**Navigation:** Click the EXT_VIP_10_1_10_30


**Navigation:** Click the Resources Tab

|image263|

.. NOTE:: there is a  policy and an iRule  is assigned to the VIP:


Create An ACL to allow web traffic and SSH
------------------------------------------

On bigip01.f5demo.com (10.1.1.4) create a rule list to allow Web
traffic. A logical container must be created before the individual rules
can be added. You will create a list with three rules, to allow port 80
(HTTP), 443 (HTTPS), and 22 (SSH)  to servers 10.1.20.11 through 10.1.20.17 We will
also create a rule which allows HTTPS traffic to access 10.1.10.30

Create a container for the rules by going to:

**Navigation:** Security > Network Firewall > Rule Lists

**Navigation:** select Create

For the **Name** enter **web_rule_list**, provide an optional

description and then click **Finished**

|image270|

|image269|

Edit the **web_rule_list** by selecting it in the Rule Lists table, then
click the **Add** button in the Rules section. Here you will add two
rules into the list; the first is a rule to allow HTTP and HTTPS traffic
to the LAMP Servers

|image276|

+-------------------------+-------------------------------------------------------------------------------------------------+
| **Name**                | allow_http_and_https                                                                            |
+=========================+=================================================================================================+
| **Protocol**            | TCP                                                                                             |
+-------------------------+-------------------------------------------------------------------------------------------------+
| **Source**              | Leave at Default of **Any**                                                                     |
+-------------------------+-------------------------------------------------------------------------------------------------+
| **Destination Address** | **Specify Address Range** 10.1.20.11 to 10.1.20.17, then click **Add**                          |
+-------------------------+-------------------------------------------------------------------------------------------------+
| **Destination Port**    | **Specify…** Port **80**, then click **Add**   **Specify…** Port **443**, then click **Add**    |
+-------------------------+-------------------------------------------------------------------------------------------------+
| **Action**              | **Accept**                                                                                      |
+-------------------------+-------------------------------------------------------------------------------------------------+
| **Logging**             | Enabled                                                                                         |
+-------------------------+-------------------------------------------------------------------------------------------------+

|image271|

**Navigation:** Click Repeat

click the **Add** button in the Rules section. Here you will add two
rules into the list; the first is a rule to allow HTTP.

+-------------------------+-----------------------------------------------------------+
| **Name**                | allow_https_10_1_10_30                                    |
+=========================+===========================================================+
| **Protocol**            | TCP                                                       |
+-------------------------+-----------------------------------------------------------+
| **Source**              | Leave at Default of **Any**                               |
+-------------------------+-----------------------------------------------------------+
| **Destination Address** | **Specify...**\ 10.1.10.30 then click **Add**             |
+-------------------------+-----------------------------------------------------------+
| **Destination Port**    | **Specify…** Port **443**, then click **Add**             |
+-------------------------+-----------------------------------------------------------+
| **Action**              | **Accept-Decisively**                                     |
+-------------------------+-----------------------------------------------------------+
| **Logging**             | Enabled                                                   |
+-------------------------+-----------------------------------------------------------+

|image272|

**Navigation:** Click Finished

Assign the Rule List to a Policy 
--------------------------------

**Navigation:** Security > Network Firewall > Policies

**Navigation** Click Create

For the **Name** enter **rd_0_policy**, provide an optional description
and then click **Finished**.
(Note: We commonly use “RD” in our rules to help reference the “Route
Domain”, default is 0)**

|image273|

Edit the **rd_0_policy** by selecting it in the Policy Lists table, then
click the **Add Rule List** button. Here you will add the rule list you
created in the previous section. For the **Name,** start typing
**web_rule_list**, you will notice the name will auto complete, select
the rule list **/Common/web_rule_list**, provide an optional description
and then click **Done Editing.**

|image274|


You will notice the changes are unsaved and need to be committed to the
system. This is a nice feature to have enabled to verify you want to
commit the changes you’ve just made without a change automatically being
implemented.

To commit the change, simply click **“Commit** Changes **to System**
located at the top of the screen.

Assign the rd_0_policy to Route Domain 0

**Navigation:** Network > Route Domains

**Navigauion:** Click on the "0" to select Route Domain 0

**Navigation:** Select the Security Tab

Set **Enforcement** to **Enable** and select the **rd_0_policy** 

**Navigation** Click Update

|Image275|

Validate Lab 2 Configuration
----------------------------



**Validation:** This lab is using self-signed certificates. You can
either open a web browser on the test client or run CURL from the CLI to
validate your configuration.

**You will need to accept the certificate to proceed to the application sites**

.. code-block:: console

    URL: https://site1.com

    URL: https://site2.com

    URL: https://site3.com

    URL: https://site4.com

    URL: https://site5.com

    URL: https://dvwa.com    Username:  admin    Password: password

**With curl you need to use the -k option to ignore certificate validation**

From a terminal window (use Cygwin on Win7 Client Desktop, or go to the c:\\curl directory from windows command shell ). Curl will let us do some of the additional testing in later sections.

.. code-block:: console

    curl -k https://10.1.10.30 -H Host:site1.com

    curl -k https://10.1.10.30 -H Host:site2.com

    curl -k https://10.1.10.30 -H Host:site3.com

    curl -k https://10.1.10.30 -H Host:site4.com

    curl -k https://10.1.10.30 -H Host:site5.com

    curl -k https://10.1.10.30 -H Host:dvwa.com

|image264|
 

.. NOTE:: for site 1 connected to  10.1.20.11, site 2 10.1.20.12  etc:

.. NOTE:: This completes Module 1 - Lab 2:

.. |ltp-diagram| image:: /_static/class2/ltp-diagram.png
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
.. |image13| image:: /_static/class2/policy_shot.png
   :width: 7.04167in
   :height: 4.02500in
.. |image14| image:: /_static/class2/policy2.png
   :width: 7.05000in
   :height: 4.29861in
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
.. |image262| image:: /_static/class2/image262.png
   :width: 7.05000in
   :height: 5.60208in
.. |image263| image:: /_static/class2/image263.png
   :width: 7.05000in
   :height: 4.60208in
.. |image264| image:: /_static/class2/image264.png
   :width: 7.05000in
   :height: 3.60208in
.. |image269| image:: /_static/class2/image269.png
   :width: 7.05000in
   :height: 3.60208in
.. |image270| image:: /_static/class2/image270.png
   :width: 6.05000in
   :height: 2.60208in
.. |image271| image:: /_static/class2/image271.png
   :width: 7in
   :height: 7in
.. |image272| image:: /_static/class2/image272.png
   :width: 7in
   :height: 7in
.. |image273| image:: /_static/class2/image273.png
   :width: 6.05000in
   :height: 2.60208in
.. |image274| image:: /_static/class2/image274.png
   :width: 7.05000in
   :height: 2.90208in
.. |image275| image:: /_static/class2/image275.png
   :width: 6.05000in
   :height: 3.60208in
.. |image276| image:: /_static/class2/image276.png
   :width: 7.05556in
   :height: 3.45833in











