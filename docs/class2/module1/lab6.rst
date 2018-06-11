Configure HTTP security
=======================

HTTP security profiles are used to apply basic HTTP security to a
virtual server. Significantly more advanced HTTP security is available
by adding ASM (Application Security Manager).

Configure An HTTP Security Profile And Apply It To The External Virtual Server
------------------------------------------------------------------------------

On the BIG-IP:

**Navigation:** Security > Protocol Security > Security Profiles > HTTP,
then click Create.

+---------------------------------+------------------------+
| **Profile Name**                | demo\_http\_security   |
+=================================+========================+
| **Custom**                      | Checked                |
+---------------------------------+------------------------+
| **Profile is case sensitive**   | Checked                |
+---------------------------------+------------------------+
| **HTTP Protocol Checks**        | Check All              |
+---------------------------------+------------------------+

|image48|

.. NOTE::  Leave all other fields using the default values.

**Navigation:** Click Request Checks Tab.

+------------------+--------------+
| **File Types**   | Select All   |
+------------------+--------------+

|image49|

.. NOTE::  Leave all other fields using the default values.

**Navigation:** Click Blocking Page Tab.

+---------------------+----------------------------------------------------------------+
| **Response Type**   | Custom Response                                                |
+=====================+================================================================+
| **Response Body**   | Insert “Please contact the helpdesk at x1234” as noted below   |
+---------------------+----------------------------------------------------------------+

|image50|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

Apply the HTTP security profile to the external virtual server.

**Navigation:** Local Traffic > Virtual Servers > Virtual Server List >
EXT\_VIP\_10.10.99.30

+-------------------------+------------------------+------------------------+
| **Protocol Security**   | Enabled                | demo\_http\_security   |
+-------------------------+------------------------+------------------------+

|image51|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Update.

Open a new web browser tab, access the virtual server and log into the
application.

URL: https://www.mysite.com/dvwa

**Credentials: _admin\/password_**

|image52|

.. NOTE:: This application is accessible, even though there are policy violations, because the “Block” option in the HTTP security policy is not selected.

Browse the application.

**Navigation:** Click on various links on the sidebar.

|image53|

.. NOTE:: This traffic will generate network firewall log entries because the Alarm option in the HTTP security policy is selected.

On BIG-IP

Review the log entries created in the previous step.

**Navigation:** Security > Event Logs > Protocol > HTTP

|image54|

.. NOTE::  Your log entries may be different than the example shown above but the concept should be the same.

Edit the demo\_http\_security HTTP security profile.

**Navigation:** Security > Protocol Security > Security Profiles > HTTP

+----------------------------+---------------------------------------------------------+
| **HTTP Protocol Checks**   | Uncheck all except "Host header contains IP address”.   |
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

.. ATTENTION:: This application should not be accessible because the ”Host header contains IP address” and “Block” options in the HTTP security policy are selected.

Open a new web browser tab and access the virtual server.

URL: https://www.mysite.com/dvwa

|image57|

.. ATTENTION:: This application should now be accessible because we requested it through the FQDN instead of an IP address

.. NOTE:: Explore some of the other settings avaialable to you in the security policy

.. NOTE:: This is the end of Module 1 - Lab 6

.. |image48| image:: /_static/class2/image49.png
   :width: 5.41503in
   :height: 5.23780in
.. |image49| image:: /_static/class2/image50.png
   :width: 5.25667in
   :height: 6.99992in
.. |image50| image:: /_static/class2/image51.png
   :width: 7.04444in
   :height: 7.07986in
.. |image51| image:: /_static/class2/image52.png
   :width: 7.04167in
   :height: 6.19444in
.. |image52| image:: /_static/class2/image53.png
   :width: 3.27502in
   :height: 2.37667in
.. |image53| image:: /_static/class2/image54.png
   :width: 3.84750in
   :height: 3.25278in
.. |image54| image:: /_static/class2/image55.png
   :width: 7.04444in
   :height: 1.56667in
.. |image55| image:: /_static/class2/image56.png
   :width: 4.52592in
   :height: 4.53707in
.. |image56| image:: /_static/class2/image57.png
   :width: 5.16503in
   :height: 1.12839in
.. |image57| image:: /_static/class2/image53.png
   :width: 3.27502in
   :height: 2.37667in