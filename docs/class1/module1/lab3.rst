Lab 3: Configure Local Logging For Firewall Events
==================================================

Security logging needs to be configured separately from LTM logging. 

High Speed Logging for modules such as the firewall module requires three componenets.

- A Log Publisher
- A Log Destination (local-db for this lab)
- A Log Profile

For more detailed information on logging, please consult the BIG-IP documentation: https://techdocs.f5.com/en-us/bigip-15-0-0/external-monitoring-of-big-ip-systems-implementations.html

In this lab, we will configure a local log publisher and log profile. The
log profile will then be applied to the virtual server and tested. 

.. warning:: Logging locally on a BIG-IP increases resource utilization and overall load. In production, it is a best practice to log to an external syslog server to reduce load on the device.

Create A Log Publisher
----------------------

A log publisher defines an end point for logging. 

1. Return to Chrome and the BIG-IP TMUI in the first tab.
2. Navigate to **System** > **Logs** > **Configuration** > **Log Publishers**.
3. Click **Create**. Use the values below to create a log publisher.

   **Name**: *firewall_log_publisher*

   **Destinations (Selected)**: *local-db*

   |image24|

   .. note:: Leave all other fields to their default values.

4. Click **Finished**.

Create A Log Profile
--------------------

Logging profiles specify which data/events should be logged and how that data should be formatted.

1. Navigate to **Security** > **Event Logs** > **Logging Profiles**.
2. Click **Create**. Use the values below to create the logging profile.

   **Name**: *firewall_log_profile*

   **Protocol Security**: *Checked*

   **Network Firewall**: *Checked*

3. Click on the **Protocol Security** tab.
4. Set the **HTTP, FTP, SMTP Security** log publisher to *firewall_log_publisher*. Leave all other fields using the default values.

|image25|

5. Click on the log profile **Network Firewall** tab and configure using the following information:

   **Network Firewall Publisher**: *firewall_log_profile*

   **Log Rule Matches**: Check *Accept*, *Drop* and *Reject*

   **Log IP Errors**: *Checked*

   **Log TCP Errors**: *Checked*

   **Log TCP Events**: *Checked*

   **Log Translation Fields**: *Checked*

   **Storage Format**: *Field-List* (Move all to Selected Items)

   |image26|

   .. note:: Leave all other fields using the default values.

6. Scroll to the bottom of the screen and click **Create**.

Apply The Logging Configuration
-------------------------------

Apply the newly created log profile to the external virtual server created in the previous lab.

1. Navigate to **Local Traffic** > **Virtual Servers** > **Virtual Server List**.

2. Click on *EXT_VIP_10.1.10.30* virtual server.

3. Click on the **Security** down-drop from the top menu bar and select **Policies**.

4. Change the **Log Profiles** field to *Enabled* and select the *firewall_log_profile* profile.

5. Leave all other fields using the default values. Your screen should appear as below:

|image278|

6. Click **Update**.

Validate Lab 3 Configuration
----------------------------

Refresh the app sites' browser tabs to access the virtual server or repeat the curl statements from the previous sections.

.. code-block:: console

    curl -k https://10.1.10.30 -H Host:site1.com

    curl -k https://10.1.10.30 -H Host:site2.com

    curl -k https://10.1.10.30 -H Host:site3.com

    curl -k https://10.1.10.30 -H Host:site4.com

    curl -k https://10.1.10.30 -H Host:site5.com


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
