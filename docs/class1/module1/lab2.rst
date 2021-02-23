====================================================
Lab 2: Permitting traffic to pass to virtual servers
====================================================

Create an ACL to allow web traffic and SSH
------------------------------------------

The rules created in this section allow basic connectivity to the resources.
We will add enforcement rules at the virtual server level to demonstrate functionality.

On the BIG-IP, we'll create a rule list to allow traffic. A logical container will be 
created before the individual rules can be added. You will create a list with rules to 
allow port 80 (HTTP), 443 (HTTPS), and 22 to servers 10.1.20.11 through 10.1.20.17.
We will also create a rules which allows HTTP and HTTPS traffic to access 10.1.10.30.

1. On the BIG-IP UI, navigate to **Security** > **Network Firewall** > **Rule Lists**.
2. Click **Create** and use the following parameters to create a rule list.
    **Name**: *web_rule_list*.
    
    |image270|
3. Click **Finished**.

Your list of *rule lists* should appear similar to below.

|image269|

Next, we'll add rules to the rule list we just created.

1. Select the *web_rule_list* by clicking on it in the Rule Lists table.
2. Click the **Add** button in the Rules section. 

    |image276|
3. Add a rules into the list to allow HTTP and HTTPS traffic as described in the next steps.

+-------------------------+-------------------------------------------------------------------------------------------------+
| **Name**                | *allow_http_and_https*                                                                          |
+=========================+=================================================================================================+
| **Protocol**            | *TCP*                                                                                           |
+-------------------------+-------------------------------------------------------------------------------------------------+
| **Source**              | Leave at Default of *Any*                                                                       |
+-------------------------+-------------------------------------------------------------------------------------------------+
| **Destination Address** | Pulldown **Specify Address Range** *10.1.20.11* to *10.1.20.17*, then click **Add**             |
+-------------------------+-------------------------------------------------------------------------------------------------+
| **Destination Port**    | Pulldown **Specify…** Port *80*, click **Add**, **Specify…** Port *443*, click **Add**          |
+-------------------------+-------------------------------------------------------------------------------------------------+
| **Action**              | *Accept*                                                                                        |
+-------------------------+-------------------------------------------------------------------------------------------------+
| **Logging**             | *Enabled*                                                                                       |
+-------------------------+-------------------------------------------------------------------------------------------------+

Your screen should appear as such:

.. image:: _images/allow_http_and_https_rule.png
  :alt:  screenshot

4. Click **Finished**, then add another rule by clicking **Add** again.

+-------------------------+-----------------------------------------------------------+
| **Name**                | allow_any_10_1_10_30                                      |
+=========================+===========================================================+
| **Order**               | *Last*                                                    |
+-------------------------+-----------------------------------------------------------+
| **Protocol**            | *TCP*                                                     |
+-------------------------+-----------------------------------------------------------+
| **Source**              | Leave at Default of *Any*                                 |
+-------------------------+-----------------------------------------------------------+
| **Destination Address** | Pulldown **Specify...**\ *10.1.10.30* then click **Add**  |
+-------------------------+-----------------------------------------------------------+
| **Destination Port**    | Leave at Default of *Any*                                 |
+-------------------------+-----------------------------------------------------------+
| **Action**              | *Accept*                                                  |
+-------------------------+-----------------------------------------------------------+
| **Logging**             | *Enabled*                                                 |
+-------------------------+-----------------------------------------------------------+

.. image:: _images/allow_any_10_1_10_30_rule.png
  :alt:  screenshot

5. Click **Finished**. Your rules list should appear as shown below:

|image272|

Assign the Rule List to a Policy 
--------------------------------

Now we will assign this rule list to a policy. 

1. Navigate to **Security** > **Network Firewall** > **Policies**.
2. Click **Create**.
3. For the **Name** enter *rd_0_policy*.
|image273|
4.Click **Finished**.
.. note:: We commonly use “RD” in our rules to help reference the “Route Domain”, default is 0.
5. Edit the **rd_0_policy** by clicking on it in the Policy Lists table.
6. Click the **Add Rule List** button. 
7. For the **Name**, start typing *web_rule_list*. You will notice the name will auto complete, making it easy to reference the existing object.
8. Select the rule list */Common/web_rule_list*. Ensure that *enabled* is selected under **State**.
|image274|
9. Click **Done Editing**. You will notice the changes are unsaved and need to be committed to the system. This is a nice feature to have enabled to verify you want to commit the changes you’ve just made without a change automatically being implemented.
10. Click **Commit Changes to System** to commit your changes.

Assign the rd_0_policy to Route Domain 0
----------------------------------------

1. Navigate to **Network** > **Route Domains**.
2. Click on the *0* to select route domain 0. A route domain is similar to selecting a default VRF on an IP router, and 0 is the default.
3. Select the **Security** tab. Set **Enforcement** to *Enable* and select the *rd_0_policy*.
|Image275|
4. Finally, click **Update**.

Configure BIG-IP Firewall in ADC Mode
-------------------------------------

By default, the Network Firewall is configured in **ADC mode**, a default allow configuration, in which 
all traffic is allowed through the firewall, and any traffic you want to block must be explicitly specified. 

The system is configured in this mode by default so all traffic on your system continues to pass after you 
provision the Advanced Firewall Manager. You should create appropriate firewall rules to allow necessary
traffic to pass before you switch the Advanced Firewall Manager to Firewall mode. In **Firewall mode**, a 
default deny configuration, all traffic is blocked through the firewall, and any traffic you want to
allow through the firewall must be explicitly specified.

In exising deployments where there are a large number of VIP's, adding AFM in Firewall mode would require 
significant preperation. Firewall functionality is easier to introduce in ADC mode. 

1. Navigate to **Security** > **Options** > **Network Firewall** > **Firewall Options**.
2. Change the **Virtual Server & Self IP Contexts** context setting to *Accept*.

Your screen should appear similar to below:

|image251|

3. Click **Update** if you changed this setting.

Validate Lab 2 Configuration
----------------------------

In Chrome, refresh the web sites in tabs 2-7. A web page should pull up for each tab.

.. note:: You may need to accept the certificate to proceed to the application sites.

- URL: https://site1.com
- URL: https://site2.com
- URL: https://site3.com
- URL: https://site4.com
- URL: https://site5.com
- URL: https://dvwa.com    Username:  admin    Password: password

Minimize all windows so that the desktop is shown. Open a terminal window by launching Cygwin from the
shortcut. Use the curl utility to test connectivity. 

.. tip:: The -k argument ignores certificate warnings.

.. code-block:: console

    curl -k https://10.1.10.30 -H Host:site1.com

    curl -k https://10.1.10.30 -H Host:site2.com

    curl -k https://10.1.10.30 -H Host:site3.com

    curl -k https://10.1.10.30 -H Host:site4.com

    curl -k https://10.1.10.30 -H Host:site5.com

You should see a response containing the HTML of the web page.

|image264|

This completes Module 1 - Lab 2. Click **Next** to continue.

.. |ltp-diagram| image:: _images/class2/ltp-diagram.png
.. |image9| image:: _images/class2/image11.png
   :width: 7.05556in
   :height: 6.20833in
.. |image10| image:: _images/class2/image12.png
   :width: 7.05556in
   :height: 3.45833in
.. |image11| image:: _images/class2/image13.png
   :width: 7.08611in
   :height: 1.97069in
.. |image12| image:: _images/class2/image14.png
   :width: 7.04167in
   :height: 2.62500in
.. |image13| image:: _images/class2/policy_shot.png
   :width: 7.04167in
   :height: 4.02500in
.. |image14| image:: _images/class2/policy2.png
   :width: 7.05000in
   :height: 4.29861in
.. |image15| image:: _images/class2/image17.png
   :width: 7.05556in
   :height: 1.68056in
.. |image16| image:: _images/class2/image18.png
   :width: 7.05000in
   :height: 2.35764in
.. |image17| image:: _images/class2/image19.png
   :width: 7.04167in
   :height: 2.25000in
.. |image18| image:: _images/class2/image20.png
   :width: 7.05556in
   :height: 0.80556in
.. |image19| image:: _images/class2/image21.png
   :width: 7.05556in
   :height: 3.34722in
.. |image20| image:: _images/class2/image22.png
   :width: 7.04167in
   :height: 2.56944in
.. |image21| image:: _images/class2/image23.png
   :width: 7.04167in
   :height: 2.59722in
.. |image22| image:: _images/class2/image24.png
   :width: 7.04167in
   :height: 4.31944in
.. |image23| image:: _images/class2/image25.png
   :width: 7.05000in
   :height: 1.60208in
.. |image262| image:: _images/class2/image262.png
   :width: 7.05000in
   :height: 5.60208in
.. |image263| image:: _images/class2/image263.png
   :width: 7.05000in
   :height: 4.60208in
.. |image264| image:: _images/class2/image264.png
   :width: 7.05000in
   :height: 3.60208in
.. |image269| image:: _images/class2/image269.png
   :width: 7.05000in
   :height: 3.60208in
.. |image270| image:: _images/class2/image270.png
   :width: 6.05000in
   :height: 2.60208in
.. |image271| image:: _images/class2/image271.png
   :width: 7in
   :height: 7in
.. |image272| image:: _images/class2/image272.PNG
   :width: 7in
   :height: 7in
.. |image273| image:: _images/class2/image273.PNG
   :width: 6.05000in
   :height: 2.60208in
.. |image274| image:: _images/class2/image274.png
   :width: 7.05000in
   :height: 2.90208in
.. |image275| image:: _images/class2/image275.png
   :width: 6.05000in
   :height: 3.60208in
.. |image276| image:: _images/class2/image276.png
   :width: 7.05556in
   :height: 3.45833in
.. |image251| image:: _images/class2/image251.png
   :width: 3.05556in
   :height: 2.45833in
