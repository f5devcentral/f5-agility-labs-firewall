Lab 3: Configure Local Logging For Firewall Events
==================================================

Security logging needs to be configured separately from LTM logging. 

High Speed Logging for modules such as the firewall module requires three componenets.

  - A Log Publisher
  - A Log Destination (local-db for this lab)
  - A Log Profile

For more detailed information on logging, please consult the BIG-IP documentation.

https://askf5.f5.com/kb/en-us/products/big-ip_ltm/manuals/product/bigip-external-monitoring-implementations-13-0-0/3.html

In this lab, we will configure a local log publisher and log profile. The
log profile will then be applied to the virtual server and tested. 

.. warning:: **Logging locally on a BIG-IP increases resource utilization and overall load. In production, it is a best practice to log to an external syslog server to reduce load on the device.**

Create A Log Publisher
----------------------

A log publisher defines an end point for logging. 

Create the log publisher using the following information:

Return to Chrome and the BIG-IP TMUI in the first tab.

**Navigation:** System > Logs > Configuration > Log Publishers

Click **Create**. Use the values below to create a log publisher.

+-------------------------------+----------------------------+
| **Name**                      | Destinations (Selected)    |
+===============================+============================+
| firewall\_log\_publisher      | local-db                   |
+-------------------------------+----------------------------+

|image24|

.. note:: Leave all other fields to their default values.

Click **Finished**.

Create A Log Profile
--------------------

Logging profiles specify which data/events should be logged and how that data should be formatted.

Create the log profile using the following information:

**Navigation:** Security > Event Logs > Logging Profiles

Click **Create**. Use the values below to create the logging profile.

+-------------------------+--------------------------+
| **Name**                | firewall\_log\_profile   |
+=========================+==========================+
| **Protocol Security**   | Checked                  |
+-------------------------+--------------------------+
| **Network Firewall**    | Checked                  |
+-------------------------+--------------------------+

|image25|

Modify The Log Profile To Collect Protocol Security Events
----------------------------------------------------------

**Navigation** Click on the Protocol Security tab

Set the **HTTP, FTP, SMTP Security** log publisher to *firewall_log_publisher*. Leave all other fields using the default values.

Modify The Log Profile To Collect Firewall Security Events
----------------------------------------------------------

Click on the log profile *Network Firewall* tab and configure using the following information:

+----------------------------------+-------------------------------------------+
| **Network Firewall Publisher**   | firewall\_log\_profile                    |
+==================================+===========================================+
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

.. note:: Leave all other fields using the default values.

Scroll to the bottom of the screen and click **Create**.

Apply The Logging Configuration
-------------------------------

Apply the newly created log profile to the external virtual server created in the previous lab.

**Navigation:** Local Traffic > Virtual Servers > Virtual Server List

Click on *EXT_VIP_10.1.10.30*.

Click on the **Security** down-drop and select **Policies**.

Change the **Log Profiles** field to Enabled and select the *firewall\_log\_profile* profile.

Leave all other fields using the default values. Your screen should appear as below:

|image278|

**Navigation:** Click Update

Now let's view the firewall logs.

**Navigation:** Security > Event Logs > Network > Firewall

|image28|

Validate Lab 3 Configuration
----------------------------

Refresh the app sites' browser tabs to access the virtual server or repeat the
curl statements from the previous sections.

URL: https://site1.com

.. note:: This test generates traffic that creates network firewall log entries.

In the **Security** > **Event Logs** > **Network** > **Firewall** screen, click the **Search** button to
refresh the event list. Newest events will appear at the top, as shown below:

|image29|

This completes Module 1 - Lab 3. Click **Next** to continue.

.. |image24| image:: _images/class2/image26.png
   :width: 7.05278in
   :height: 2.93819in
.. |image25| image:: _images/class2/image27.png
   :width: 7.04444in
   :height: 2.53958in
.. |image26| image:: _images/class2/image28.png
   :width: 4.83169in
   :height: 5.41497in
.. |image278| image:: _images/class2/image278.png
   :width: 7.04167in
   :height: 5.88889in
.. |image28| image:: _images/class2/image30.png
   :width: 7.25278in
   :height: 1.01170in
.. |image29| image:: _images/class2/image31.jpeg
   :width: 6.73811in
   :height: 1.69444in
.. |image251| image:: _images/class2/image251.png
   :width: 3.73811in
   :height: 1.69444in
