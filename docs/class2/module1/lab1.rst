Lab 1: Advanced Firewall with Protocol Security
===============================================

In this lab, you will build an extensive perimeter firewall with
advanced Layer 7 security mitigations

Estimated completion time: 45 minutes

Objective:

-  Create multiple internal pools and virtual servers for different
   applications

-  Create external hosted virtual server

-  Configure LTM policy to direct traffic to appropriate virtual server

-  Configure local logging; test

-  Configure a network firewall policy to protect the external virtual
   server

-  Create a network firewall policy to protect the internal application
   virtual servers; test

-  Apply the XFF-SNAT iRule to the external virtual server; test

-  Modify the network firewall policy to block based on XFF; test

-  Apply Layer 7 (403 Denied) to respond to firewall drop rules

-  Configure HTTP protocol security; test

-  Configure DNS protocol security; test

Lab Requirements:

-  Remote Desktop Protocol (RDP) client utility

   -  Windows: Built-in

   -  Mac (Microsoft Client):
      https://itunes.apple.com/us/app/microsoft-remote-desktop/id715768417?mt=12

   -  Mac (Open Source Client):
      http://sourceforge.net/projects/cord/files/cord/0.5.7/CoRD_0.5.7.zip/download

   -  Unix/Linux (Source – Requires Compiling): http://www.rdesktop.org/

-  Connectivity to the facility provided Internet service

-  Unique destination IP address for RDP to your lab

Estimated completion time: 1 Hour

TASK 1 – Configure pools and internal virtual servers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A virtual server is used by BIG-IP to identify specific types of
traffic. Other objects such as profiles, policies, pools and iRules are
applied to the virtual server to add features and functionality. In the
context of security, since BIG-IP is a default-deny device, a virtual
server is necessary to accept specific types of traffic.

The pool is a logical group of hosts that is applied to and will receive
traffic from a virtual server.

On your personal device

Look at the supplemental login instructions for:

External Hostnames

External IP addressing diagram

Login IDs and Passwords are subject to change as well.

|image1|

On BIG-IP

Create a pool using the following information:

**Navigation:** Local Traffic > Pools > Pool List, then click Create

+----------------------------+----------------------+-----------------+--------------------+
| **Name**                   | **Health Monitor**   | **Members**     | **Service Port**   |
+============================+======================+=================+====================+
| pool\_www.mysite.com       | tcp\_half\_open      | 10.10.121.129   | 80                 |
+----------------------------+----------------------+-----------------+--------------------+
| pool\_www.mysite.com-api   | tcp\_half\_open      | 10.10.121.132   | 80                 |
+----------------------------+----------------------+-----------------+--------------------+
| pool\_www.theirsite.com    | tcp\_half\_open      | 10.10.121.131   | 80                 |
+----------------------------+----------------------+-----------------+--------------------+
| pool\_www.yoursite.com     | tcp\_half\_open      | 10.10.121.130   | 80                 |
+----------------------------+----------------------+-----------------+--------------------+

|image2|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

|image3|

.. NOTE:: The pools should now show a green circle for status.

Create the internal virtual servers using the following information:

**Navigation:** Local Traffic > Virtual Servers > Virtual Server List, then
click Create

+-----------------------------------------------+------------+------------+--------------------+-----------------------+------------+----------------------------+
| **Name**                                      | **Dest**   | **Port**   | **HTTP Profile**   | **Enabled on VLAN**   | **SNAT**   | **Default Pool**           |
+===============================================+============+============+====================+=======================+============+============================+
| int\_vip\_www.mysite.com\_1.1.1.1             | 1.1.1.1    | 80         | YES                | loopback              | AUTO       | pool\_www.mysite.com       |
+-----------------------------------------------+------------+------------+--------------------+-----------------------+------------+----------------------------+
| int\_vip\_www.mysite.com-api\_1.1.1.2         | 1.1.1.2    | 80         | YES                | loopback              | AUTO       | pool\_www.mysite.com-api   |
+-----------------------------------------------+------------+------------+--------------------+-----------------------+------------+----------------------------+
| int\_vip\_www.mysite.com-downloads\_1.1.1.3   | 1.1.1.3    | 80         | YES                | loopback              | AUTO       | pool\_www.mysite.com       |
+-----------------------------------------------+------------+------------+--------------------+-----------------------+------------+----------------------------+
| int\_vip\_www.theirsite.com\_2.2.2.2          | 2.2.2.2    | 80         | YES                | loopback              | AUTO       | pool\_www.theirsite.com    |
+-----------------------------------------------+------------+------------+--------------------+-----------------------+------------+----------------------------+
| int\_vip\_www.yoursite.com\_3.3.3.3           | 3.3.3.3    | 80         | YES                | loopback              | AUTO       | pool\_www.yoursite.com     |
+-----------------------------------------------+------------+------------+--------------------+-----------------------+------------+----------------------------+

|image4|

|image5|

|image6|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

|image7|

.. NOTE:: The virtual server should now show a green circle for status.

Create the external virtual server using the following information:

**Navigation:** Local Traffic > Virtual Servers > Virtual Server List, then
click Create

+-------------------------+---------------+------------+--------------------+----------------------------------------------------+------------------------+
| **Name**                | **Dest**      | **Port**   | **HTTP Profile**   | **SSL Profile (Client)**                           | **Default Pool**       |
+=========================+===============+============+====================+====================================================+========================+
| EXT\_VIP\_10.10.99.30   | 10.10.99.30   | 443        | YES                | `www.mysite.com <http://www.mysite.com>`__         | pool\_www.mysite.com   |
|                         |               |            |                    |                                                    |                        |
|                         |               |            |                    | `www.theirsite.com <http://www.theirsite.com>`__   |                        |
|                         |               |            |                    |                                                    |                        |
|                         |               |            |                    | `www.yoursite.com <http://www.yoursite.com>`__     |                        |
+-------------------------+---------------+------------+--------------------+----------------------------------------------------+------------------------+

|image8|

|image9|

|image10|

.. NOTE:: The pool is not necessary and might not be what you want from
a security perspective but it’s here as a fallback and to let the
virtual server turn green

.. NOTE:: Please STOP here until after lecture

TASK 2 – Configure And Attach The LTM Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The LTM policy is what allows traffic to flow from the external virtual
server to the internal virtual servers based on the Layer 7 request.
Whether it is based on the hostname or the URI path, the request can be
forwarded to a different virtual server or an application pool of
servers.

**Navigation:** Local Traffic > Policies : Policy List > Policy List Page,
then click Create

+-------------------+------------------------------------------------------------------------+
| **Policy Name**   | HTTPS\_Virtual\_Targeting\_PolicyL7                                    |
+-------------------+------------------------------------------------------------------------+
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

+--------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **Rule Name**                  |                   |                  |               |                                               |
+--------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **www.mysite.com**             | HTTP Host         | Host             | is            | www.mysite.com                                |
+--------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **ACTION**                     | Forward Traffic   | Virtual Server   |               | int\_vip\_www.mysite.com\_1.1.1.1             |
+--------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **www.yoursite.com**           | HTTP Host         | Host             | is            | www.yoursite.com                              |
+--------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **ACTION**                     | Forward Traffic   | Virtual Server   |               | int\_vip\_www.yoursite.com\_3.3.3.3           |
+--------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **www.theirsite.com**          | HTTP Host         | Host             | is            | www.theirsite.com                             |
+--------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **ACTION**                     | Forward Traffic   | Virtual Server   |               | int\_vip\_www.theirsite.com\_2.2.2.2          |
+--------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **www.mysite.com-api**         | HTTP Host         | host             | is            | www.mysite.com                                |
+--------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
|                                | HTTP URI          | path             | begins with   | /api                                          |
+--------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **ACTION**                     | Forward Traffic   | Virtual Server   |               | int\_vip\_www.mysite.com-api\_1.1.1.2         |
+--------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
|                                | Replace           | http uri         | path          | with **/**                                    |
+--------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **www.mysite.com-downloads**   | HTTP Host         | host             | is            | www.mysite.com                                |
+--------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
|                                | HTTP URI          | path             | begins with   | /downloads                                    |
+--------------------------------+-------------------+------------------+---------------+-----------------------------------------------+
| **ACTION**                     | Forward Traffic   | Virtual Server   |               | int\_vip\_www.mysite.com-downloads\_1.1.1.3   |
+--------------------------------+-------------------+------------------+---------------+-----------------------------------------------+

**Navigation:** Remember to click Add after adding the matching string

|image13|

**Navigation:** Click Save

Additional Example for /api. The replacement line is required to strip
the path from the request for the site to work.

|image14|

Complete the additional policies according to the list above.

Once complete publish the policy.

**Navigation:** Local Traffic > Policies: Policy List >
/Common/HTTPS\_Virtual\_Targeting\_PolicyL7

**Navigation:** Click Publish

|image15|

Now apply the policy to the external virtual server

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

**Validation:** This lab is using self-signed certificates. You can
either open a web browser on the test client or run CURL from the CLI to
validate your configuration.

Note: you may have to edit the hosts file on your Win7 Client to add:

.. code-block:: console

   10.10.99.30 www.mysite.com
   
   10.10.99.30 www.yoursite.com
   
   10.10.99.30 www.theirsite.com

|image23|

From a terminal window (use Cygwin on Win7 Client Desktop). Curl will
let us do some of the additional testing in later sections.

.. code-block:: console

   curl -k https://10.10.99.30 -H 'Host:www.mysite.com'``

   <H1> MYSITE.COM </H1>

   curl -k https://10.10.99.30 -H 'Host:www.theirsite.com'
   
   <H1> THEIRSITE.COM </H1>
   
   curl -k https://10.10.99.30 -H 'Host:www.yoursite.com'
   
   <H1> YOURSITE.COM </H1>
   
   curl -k https://10.10.99.30/api -H 'Host:www.mysite.com'

A bunch of nonsense JSON should be returned.

.. code-block:: console

   {
      "web-app": {
        "servlet": [
           {
              "servlet-name": "cofaxCDS",
              "servlet-class": "org.cofax.cds.CDSServlet"
           }
    ...   

``curl -k https://10.10.99.30/downloads/ -H 'Host:www.mysite.com'``

A larger page with this title should be displayed.

.. code-block:: html

   <html>
   <head>
     <title>Index of /downloads</title>
   </head>
   <body>

**→NOTE:** This is the end of Task 2

TASK 3 – Configure local logging
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Security logging needs to be configured separately from LTM logging. In
our lab, we will configure a local log publisher and log profile. The
log profile will then be applied to the virtual server and tested.

On BIG-IP

Create a log publisher using the following information:

**Navigation:** System > Logs > Configuration > Log Publishers, then click
Create

+-------------------------------+----------------------------+
| **Name**                      | firewall\_log\_publisher   |
+-------------------------------+----------------------------+
| **Destinations (Selected)**   | local-db                   |
+-------------------------------+----------------------------+

|image24|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

Create a log profile using the following information:

**Navigation:** Security > Event Logs > Logging Profiles, then click Create

+-------------------------+--------------------------+
| **Name**                | firewall\_log\_profile   |
+=========================+==========================+
| **Protocol Security**   | Checked                  |
+-------------------------+--------------------------+
| **Network Firewall**    | Checked                  |
+-------------------------+--------------------------+

Edit log profile protocol security tab using the following information:

**Navigation:** Click on the Protocol Security tab

+----------------+----------------------------+
| **Publisher**  | firewall\_log\_publisher   |
+----------------+----------------------------+

|image25|

.. NOTE:: Leave all other fields using the default values.

Edit log profile network firewall tab using the following information:

**Navigation:** Click on the Network Firewall tab

+----------------------------------+-------------------------------------------+
| **Network Firewall Publisher**   | firewall\_log\_profile                    |
+----------------------------------+-------------------------------------------+
| **Log Rule Matches**             | Check Accept                              |
|                                  | Check Drop                                |
|                                  | Check Reject                              |
+----------------------------------+-------------------------------------------+
| **Log IP Errors**                | Checked                                   |
+----------------------------------+-------------------------------------------+
| **Log TCP Errors**               | Checked                                   |
+----------------------------------+-------------------------------------------+
| **Log TCP Events**               | Checked                                   |
+----------------------------------+-------------------------------------------+
| **Log Translation Fields**       | Checked                                   |
+----------------------------------+-------------------------------------------+
| **Storage Format**               | Field-List (Move all to Selected Items)   |
+----------------------------------+-------------------------------------------+

|image26|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

Apply the newly created log profile to the external virtual server
created in the previous task.

**Navigation:** Local Traffic > Virtual Servers > Virtual Server List

**Navigation:** Click on EXT\_VIP\_10.10.99.30

**Navigation:** Security tab > Policies

+-------------------+--------------------------+
| **Log Profile**   | firewall\_log\_profile   |
+-------------------+--------------------------+

|image27|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Update

View empty network firewall logs.

**Navigation:** Security > Event Logs > Network > Firewall

|image28|

Open a new web browser tab and access the virtual server or repeat the
curl statements from the previous sections.

URL: https://www.mysite.com

.. NOTE:: This test creates network firewall log entries.

View new network firewall log entries.

**Navigation:** Security > Event Logs > Network > Firewall

|image29|

.. NOTE:: This is the end of task 3.

TASK 4 – Configure a network firewall policy and rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A network firewall policy is a collection of network firewall rules that
can be applied to a virtual server. In our lab, we will create two
policies, each of which includes two rules. This policy will then be
applied to the appropriate virtual servers and tested.

On BIG-IP

Create Network Firewall Policy

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
+----------------+----------------------------------------+
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
+---------------+---------------+
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

From client machine

URL: https://www.mysite.com/downloads/

|image35|

.. NOTE:: We want to validate the site is available before and
   after applying the Network Firewall Policy

On BIG-IP

Apply the Network Firewall Policy to Virtual Server

+----------------------+-----------------------------------------------+
| **Virtual Server**   | int\_vip\_www.mysite.com-downloads\_1.1.1.3   |
+----------------------+-----------------------------------------------+
| **Enforcement**      | Enabled                                       |
+----------------------+-----------------------------------------------+
| **Policy**           | downloads\_policy                             |
+----------------------+-----------------------------------------------+
| **Log Profile**      | firewall\_log\_profile                        |
+----------------------+-----------------------------------------------+

|image36|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Update

From client machine

URL: https://www.mysite.com/downloads/

|image37|

.. NOTE:: We want to ensure the On BIG-IP the site is still available
after applying the policy. We will get into testing the block later.

Now we want to create a second policy for access to the /api/
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
+----------------+------------------------+
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

As we are deployed in “ADC Mode” where the default action on a virtual
server is ‘Accept’ we must also create a default deny rule.

+---------------+-------------+
| **Name**      | deny\_log   |
+---------------+-------------+
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
+----------------------+-----------------------------------------+
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

.. NOTE:: We can no longer access the /api site because the only
   allowed address is 172.16.99.5. You can verify this in the logs

|image44|

.. NOTE:: This concludes Task 4

TASK 5 – Configure SNAT for CDN networks or other proxies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Many enterprise sites have some or all of their content served up by
Content Delivery Networks (CDN). This common use case leverages proxies
to provide static content closer to the end client machines. Because of
this there may only be one or two IP addresses connecting to the origin
website. The original IP address of the client in this case is often
mapped to a common HTTP header XFF. In this deployment, the BIG-IP can
translate the original source of the request in the XFF to the source IP
address.

The iRule to accomplish this is already installed on your BIG-IP. We
need to apply it the External Virtual Server. Here is a sample of the
iRule.

.. code-block:: tcl

   when HTTP_REQUEST {
     if {[HTTP::header exists "X-Forwarded-For"]} {
       snat [HTTP::header X-Forwarded-For]
       log local0. '[HTTP::header X-Forwarded-For]'
     }
   }

Apply the iRule to the Virtual Server

**Navigation:** *Click on the* EXT\_VIP\_10.10.99.30 *virtual server*

|image45|

**Navigation:** Click Manage under the iRule section

|image46|

**Navigation:** Once you have moved the iRule XFF-SNAT over to the Enabled
Section, Click Finished

To test functionality, we will need to leverage curl from the CLI to
insert the X-Forwarded-For header.

``curl -k https://10.10.99.30/downloads/ -H 'Host: www.mysite.com'``

Expected Result:

.. code-block:: html

   <html>
   <head>
   <title>Index of /downloads</title>
   </head>
   <body>

Validate that IP addresses sourced from China are blocked:

``curl -k https://10.10.99.30/downloads/ -H 'Host: www.mysite.com' -H 'X-Forwarded-For: 1.202.2.1'``

Expected Result: The site should now be blocked

Validate that requests sourced from the X-Forwarded-For IP address of
172.16.99.5 are now allowed.

``curl -k https://10.10.99.30/api -H 'Host:www.mysite.com' -H 'X-Forwarded-For: 172.16.99.5'``

Expected Result:

.. code-block:: console

   {
      "web-app": {
        "servlet": [
           {
              "servlet-name": "cofaxCDS",
              "servlet-class": "org.cofax.cds.CDSServlet"
           }
    ...   

The next step is to solve for the TCP connection issue with CDN
providers. This is accomplished via AFM iRules. The iRule is already
provided for you. We need to apply it to the Network Firewall
downloads\_policy Policy.

|image47|

**Navigation:** iRule select the AFM\_403\_Downloads

Validate that denied requests are now responded with a Layer 7 403
Error.

``curl -k https://10.10.99.30/downloads -H 'Host: www.mysite.com' -H 'X-Forwarded-For: 1.202.2.1'``

Expected Result: Instead of the traffic getting dropped, a 403 error
should be returned.

.. code-block:: console

   <html>
   <head>
   <title>403 Forbidden</title>
   </head>
   <body>
   403 Forbidden Download of Cryptographic Software Is Restricted
   </body>
   </html>

TASK 6 – Configure HTTP security
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

HTTP security profiles are used to apply basic HTTP security to a
virtual server. Significantly more advanced HTTP security is available
by adding ASM (Application Security Manager).

On BIG-IP

Configure a HTTP security profile.

**Navigation:** Security > Protocol Security > Security Profiles > HTTP,
then click Create.

+---------------------------------+------------------------+
| **Profile Name**                | demo\_http\_security   |
+---------------------------------+------------------------+
| **Custom**                      | Checked                |
+---------------------------------+------------------------+
| **Profile is case sensitive**   | Checked                |
+---------------------------------+------------------------+
| **HTTP Protocol Checks**        | Check All              |
+---------------------------------+------------------------+

|image48|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Request Checks Tab.

+------------------+--------------+
| **File Types**   | Select All   |
+------------------+--------------+

|image49|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Blocking Page Tab.

+---------------------+----------------------------------------------------------------+
| **Response Type**   | Custom Response                                                |
+---------------------+----------------------------------------------------------------+
| **Response Body**   | Insert “Please contact the helpdesk at x1234” as noted below   |
+---------------------+----------------------------------------------------------------+

|image50|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

Apply HTTP security profile to virtual server.

**Navigation:** Local Traffic > Virtual Servers > Virtual Server List >
EXT\_VIP\_10.10.99.30

+-------------------------+------------------------+
| **Protocol Security**   | Enabled                |
|                         |                        |
|                         | demo\_http\_security   |
+-------------------------+------------------------+

|image51|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Update.

Open a new web browser tab, access the virtual server and log into the
application.

URL: https://www.mysite.com/dvwa

Credentials: admin/password

|image52|

.. NOTE:: This application is accessible, even though there are policy
   violations, because the “Block” option in the HTTP security policy is
   not selected.

Browse the application.

**Navigation:** Click on various links on the sidebar.

|image53|

.. NOTE:: This traffic will generate network firewall log entries
   because the “Alarm” option in the HTTP security policy is selected.

On BIG-IP

Review the log entries created in the previous step.

**Navigation:** Security > Event Logs > Protocol > HTTP

|image54|

.. NOTE:: Your log entries may be different than the example shown
   above.

Edit the demo\_http\_security HTTP security profile.

**Navigation:** Security > Protocol Security > Security Profiles > HTTP

+----------------------------+---------------------------------------------------------+
| **HTTP Protocol Checks**   | Uncheck all except “Host header contains IP address”.   |
|                            |                                                         |
|                            | Check “Block”                                           |
+----------------------------+---------------------------------------------------------+

|image55|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished.

On Windows jumpbox

Open a new web browser tab and access the virtual server.

URL: https://10.10.99.30/dvwa

|image56|

.. NOTE:: This application is not accessible because the ”Host header
   contains IP address” and “Block” options in the HTTP security policy are
   selected.

Open a new web browser tab and access the virtual server.

URL: https://www.mysite.com/dvwa

|image57|

.. NOTE:: This application is accessible because we requested a FQDN
   instead of an IP address.

.. NOTE:: Do not log into DVWA at this time.

.. NOTE:: This is the end of task 6.

TASK 7 – Configure DNS security
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DNS security profiles are used to filter DNS requests by query type.
This is useful for allowing specific DNS query types to pass through AFM
to the authoritative DNS infrastructure, while blocking the reminder.
Additional DNS security such as DNS Request Policy Zones (aka DNS
Firewall), DNS DDoS mitigation, DNSSEC & more is available in GTM
(Global Traffic Manager). In this lab, DNS resolution is provided by
GTM, which is already preconfigured.

On BIG-IP

Configure a DNS profile.

**Navigation:** DNS > Delivery > Profiles > DNS, Click Create.

+------------+----------------------+
| **Name**   | demo\_dns\_profile   |
+------------+----------------------+

|image58|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished.

Configure a DNS listener.

**Navigation:** DNS > Delivery > Listeners > Listener List, Click Create.

+-------------------+-----------------------+
| **Name**          | demo\_dns\_listener   |
+-------------------+-----------------------+
| **Destination**   | 10.10.99.30           |
+-------------------+-----------------------+
| **DNS Profile**   | demo\_dns\_profile    |
+-------------------+-----------------------+

|image59|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished.

On Windows jumpbox

Using the nslookup utility, test DNS resolution for dvwa.f5demo.com.

**Navigation:** Click the Command Prompt icon on the Windows Taskbar. Type
nslookup and hit Enter.

**Navigation:** Type in nslookup> server 10.10.99.30.

|image60|

.. NOTE:: A DNS response of “Address: 192.168.1.50” shows that
   resolution for A records is working properly.

**Navigation:** Close the Windows Command Prompt.

On BIG-IP

Configure a DNS Security Profile to filter resolution for A records.

**Navigation:** Security > Protocol Security > Security Profiles > DNS,
Click Create.

+---------------------------------+-----------------------+
| **DNS Security**                | Enabled               |
+---------------------------------+-----------------------+
| **DNS Security Profile Name**   | demo\_dns\_security   |
+---------------------------------+-----------------------+

|image61|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished.

Apply the DNS Security Profile to the DNS Profile.

**Navigation:** DNS > Delivery > Profiles > DNS, Click demo\_dns\_profile.

+---------------------------------+-----------------------+
| **DNS Security**                | Enabled               |
+---------------------------------+-----------------------+
| **DNS Security Profile Name**   | demo\_dns\_security   |
+---------------------------------+-----------------------+

|image62|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Update.

On Windows jumpbox

Using the nslookup utility, test DNS resolution for dvwa.f5demo.com.

**Navigation:** Click the Command Prompt icon on the Windows Taskbar. Type
nslookup and hit Enter.

|image63|

**Navigation:** Close the Windows Command Prompt.

.. NOTE:: A “DNS request timed out.” error shows that resolution for A
records is now being filtered based on the newly applied DNS security
profile.

.. NOTE:: This is the end of task 6.

.. |image1| image:: /_static/class2/image3.png
   :width: 7.04167in
   :height: 3.51389in
.. |image2| image:: /_static/class2/image4.png
   :width: 6.74931in
   :height: 5.88401in
.. |image3| image:: /_static/class2/image5.png
   :width: 7.05556in
   :height: 1.33333in
.. |image4| image:: /_static/class2/image56.png
   :width: 7.05556in
   :height: 3.22222in
.. |image5| image:: /_static/class2/image57.png
   :width: 7.05556in
   :height: 7.31944in
.. |image6| image:: /_static/class2/image58.png
   :width: 7.05000in
   :height: 3.46949in
.. |image7| image:: /_static/class2/image59.png
   :width: 7.05000in
   :height: 1.50278in
.. |image8| image:: /_static/class2/image78.png
   :width: 7.05556in
   :height: 2.63889in
.. |image9| image:: /_static/class2/image79.png
   :width: 7.05556in
   :height: 6.20833in
.. |image10| image:: /_static/class2/image80.png
   :width: 7.05556in
   :height: 3.45833in
.. |image11| image:: /_static/class2/image81.png
   :width: 7.08611in
   :height: 1.97069in
.. |image12| image:: /_static/class2/image82.png
   :width: 7.04167in
   :height: 2.62500in
.. |image13| image:: /_static/class2/image83.png
   :width: 7.05000in
   :height: 2.63403in
.. |image14| image:: /_static/class2/image85.png
   :width: 7.05000in
   :height: 3.29861in
.. |image15| image:: /_static/class2/image87.png
   :width: 7.05556in
   :height: 1.68056in
.. |image16| image:: /_static/class2/image89.png
   :width: 7.05000in
   :height: 2.35764in
.. |image17| image:: /_static/class2/image90.png
   :width: 7.04167in
   :height: 2.25000in
.. |image18| image:: /_static/class2/image91.png
   :width: 7.05556in
   :height: 0.80556in
.. |image19| image:: /_static/class2/image92.png
   :width: 7.05556in
   :height: 3.34722in
.. |image20| image:: /_static/class2/image93.png
   :width: 7.04167in
   :height: 2.56944in
.. |image21| image:: /_static/class2/image94.png
   :width: 7.04167in
   :height: 2.59722in
.. |image22| image:: /_static/class2/image95.png
   :width: 7.04167in
   :height: 4.31944in
.. |image23| image:: /_static/class2/image96.png
   :width: 7.05000in
   :height: 1.60208in
.. |image24| image:: /_static/class2/image97.png
   :width: 7.05278in
   :height: 2.93819in
.. |image25| image:: /_static/class2/image98.png
   :width: 7.04444in
   :height: 2.53958in
.. |image26| image:: /_static/class2/image99.png
   :width: 4.83169in
   :height: 5.41497in
.. |image27| image:: /_static/class2/image100.png
   :width: 7.04167in
   :height: 5.88889in
.. |image28| image:: /_static/class2/image101.png
   :width: 7.25278in
   :height: 1.01170in
.. |image29| image:: /_static/class2/image102.jpeg
   :width: 6.73811in
   :height: 1.69444in
.. |image30| image:: /_static/class2/image104.png
   :width: 7.04167in
   :height: 1.70833in
.. |image31| image:: /_static/class2/image105.png
   :width: 7.04167in
   :height: 2.33333in
.. |image32| image:: /_static/class2/image106.png
   :width: 7.05556in
   :height: 6.47222in
.. |image33| image:: /_static/class2/image107.png
   :width: 7.04167in
   :height: 5.02778in
.. |image34| image:: /_static/class2/image108.png
   :width: 7.04167in
   :height: 2.45833in
.. |image35| image:: /_static/class2/image109.png
   :width: 7.05556in
   :height: 3.30556in
.. |image36| image:: /_static/class2/image110.png
   :width: 7.05556in
   :height: 6.91667in
.. |image37| image:: /_static/class2/image109.png
   :width: 7.05000in
   :height: 3.30295in
.. |image38| image:: /_static/class2/image111.png
   :width: 7.04167in
   :height: 1.75000in
.. |image39| image:: /_static/class2/image112.png
   :width: 7.04167in
   :height: 2.50000in
.. |image40| image:: /_static/class2/image113.png
   :width: 7.05556in
   :height: 6.86111in
.. |image41| image:: /_static/class2/image114.png
   :width: 7.04167in
   :height: 5.04167in
.. |image42| image:: /_static/class2/image115.png
   :width: 7.04167in
   :height: 6.33333in
.. |image43| image:: /_static/class2/image116.png
   :width: 7.04167in
   :height: 4.19444in
.. |image44| image:: /_static/class2/image117.png
   :width: 7.04167in
   :height: 0.63889in
.. |image45| image:: /_static/class2/image119.png
   :width: 7.04167in
   :height: 4.25000in
.. |image46| image:: /_static/class2/image120.png
   :width: 7.04167in
   :height: 2.81944in
.. |image47| image:: /_static/class2/image121.png
   :width: 7.04167in
   :height: 6.97222in
.. |image48| image:: /_static/class2/image122.png
   :width: 5.41503in
   :height: 5.23780in
.. |image49| image:: /_static/class2/image123.png
   :width: 5.25667in
   :height: 6.99992in
.. |image50| image:: /_static/class2/image124.png
   :width: 7.04444in
   :height: 7.07986in
.. |image51| image:: /_static/class2/image125.png
   :width: 7.04167in
   :height: 6.19444in
.. |image52| image:: /_static/class2/image13.png
   :width: 3.27502in
   :height: 2.37667in
.. |image53| image:: /_static/class2/image126.png
   :width: 3.84750in
   :height: 3.25278in
.. |image54| image:: /_static/class2/image127.png
   :width: 7.04444in
   :height: 1.56667in
.. |image55| image:: /_static/class2/image128.png
   :width: 4.52592in
   :height: 4.53707in
.. |image56| image:: /_static/class2/image129.png
   :width: 5.16503in
   :height: 1.12839in
.. |image57| image:: /_static/class2/image13.png
   :width: 3.27502in
   :height: 2.37667in
.. |image58| image:: /_static/class2/image130.png
   :width: 6.17178in
   :height: 6.00521in
.. |image59| image:: /_static/class2/image131.png
   :width: 7.05000in
   :height: 6.24861in
.. |image60| image:: /_static/class2/image132.png
   :width: 7.05278in
   :height: 4.15903in
.. |image61| image:: /_static/class2/image133.png
   :width: 5.11108in
   :height: 2.76716in
.. |image62| image:: /_static/class2/image134.png
   :width: 5.99386in
   :height: 7.22733in
.. |image63| image:: /_static/class2/image135.png
   :width: 7.04444in
   :height: 3.57500in