Lab 6: Configure HTTP security
==============================

You can secure HTTP traffic by using a default configuration or by customizing the configuration. You can 
adjust the following security checks in an HTTP security profile:

- HTTP protocol compliance validation
- Evasion technique detection
- Length checking to help avoid buffer overflow attacks
- HTTP method validation
- Inclusion or exclusion of certain files by type
- Mandatory header enforcement

.. warning:: HTTP protocol security does not offer the dynamic, constantly-updated security that a web application firewall (WAF) offers. HTTP protocol security in AFM should be complimented by a WAF solution, such as F5's Advanced WAF, when comprehensive web security is required.

Configure An HTTP Security Profile And Apply It To The External Virtual Server
------------------------------------------------------------------------------

1. Return to the BIG-IP TMUI in Chrome.

2. Navigate to **Security** > **Protocol Security** > **Security Profiles** > **HTTP**.

3. Confirm that the **Security Profiles** tab is selected, then click **Create**.

+---------------------------------+------------------------+
| **Profile Name**                | demo_http_security     |
+=================================+========================+
| **Custom**                      | Checked                |
+---------------------------------+------------------------+
| **Profile is case sensitive**   | Checked                |
+---------------------------------+------------------------+
| **HTTP Protocol Checks**        | Check All              |
+---------------------------------+------------------------+

|image48|

.. note::  Leave all other fields using the default values.

4. Click the **Request Checks** tab. 

.. tip:: We're going to allow the default HTTP methods. Restricting the methods allowed to reach production servers is a great way to shrink the attack surface.

+------------------+--------------+
| **File Types**   | Select All   |
+------------------+--------------+

|image49|

5. Click the **Blocking Page** tab. Change the **Response Type** drop-down to *Custom Response*.

+---------------------+----------------------------------------------------------------+
| **Response Type**   | Custom Response                                                |
+=====================+================================================================+
| **Response Body**   | Insert “Please contact the helpdesk at x1234” as noted below   |
+---------------------+----------------------------------------------------------------+

|image50|

.. note:: Leave all other fields using the default values.

6. Click **Create**.

.. warning:: We did not put the policy in Blocking mode. We will do that after we verify functionality.

Now, let's apply the HTTP security profile to the external virtual server.

7. Navigate to **Local Traffic** > **Virtual Servers** > **Virtual Server List**.

8. Select *EXT_VIP_10.1.10.30*, then select the **Security** drop-down and choose **Policies**.

+-------------------------+------------------------+------------------------+
| **Protocol Security**   | Enabled                | demo_http_security     |
+-------------------------+------------------------+------------------------+
| **Log Profile**         | selected               | firewall_log_profile   |
+-------------------------+------------------------+------------------------+

|image51|

.. note:: Leave all other fields using the default values.

9. Click **Update**.

10. Return to tab #7 in Chrome and refresh the DVWA app at https://dvwa.com.

**Credentials: admin\/password**

|image52|

.. note:: This application is accessible, even though there are policy violations, because the “Block” option in the HTTP security policy is not selected.

11. Browse the application clicking on various links on the sidebar.

.. warning:: **If you change the admin password in DVWA, make sure you remember it for later!**

|image53|

.. note:: This traffic will generate network firewall log entries because the Alarm option in the HTTP security policy is selected.

12. On the BIG-IP, review the log entries created in the previous step by navigating to **Security** > **Event Logs** > **Protocol** > **HTTP**.

|image54|

.. note::  Your log entries may be different than the example shown above but the concept should be the same.

13. Edit the *demo_http_security* HTTP security profile by navigating to **Security** > **Protocol Security** > **Security Profiles** > **HTTP**.

14. Select the *demo_http_security* profile, then select the **Request Checks** tab.

+----------------------------+---------------------------------------------------------+
| **Methods**                | Remove Post From the Allowed Group.                     |
|                            |                                                         |
|                            | Check “Block”                                           |
+----------------------------+---------------------------------------------------------+

|image55|

.. note:: Leave all other fields using the default values.

15. Click **Finished**.

16. On the jump box, Log out of DVWA by selecting Log Out in the menu. Attempt to log back in. **This action requires a POST action and will be blocked because this is not allowed.**

URL: https://dvwa.com

**Credentials: admin\/password**

|image266|

17. Edit the *demo_http_security* HTTP security profile at **Security** > **Protocol Security** > **Security Profiles** > **HTTP**.

18. Select the *demo_http_security* profile, then undo the POST block in the **Request Checks** tab.

+----------------------------+---------------------------------------------------------+
| **Methods**                | - Add Post to the Allowed Group.                        |
|                            | - Un-check “Block”                                      |
+----------------------------+---------------------------------------------------------+

This is the end of Module 1 - Lab 6. Click **Next** to continue.

.. |image48| image:: ../images/image49.png
   :width: 5.41503in
   :height: 5.23780in
.. |image49| image:: ../images/image50.png
   :width: 5.25667in
   :height: 6.99992in
.. |image50| image:: ../images/image51.png
   :width: 7.04444in
   :height: 7.07986in
.. |image51| image:: ../images/image52.png
   :width: 7.04167in
   :height: 6.19444in
.. |image52| image:: ../images/image53.png
   :width: 3.27502in
   :height: 2.37667in
.. |image53| image:: ../images/image54.png
   :width: 3.84750in
   :height: 3.25278in
.. |image54| image:: ../images/image55.png
   :width: 7.04444in
   :height: 1.56667in
.. |image55| image:: ../images/image56.png
   :width: 4.52592in
   :height: 4.53707in
.. |image266| image:: ../images/image266.png
   :width: 5.16503in
   :height: 1.12839in
.. |image57| image:: ../images/image53.png
   :width: 3.27502in
   :height: 2.37667in
