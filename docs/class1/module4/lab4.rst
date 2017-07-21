BIG-IQ Statistics Dashboards
============================

WORKFLOW 1: Setting up of BIG-IQ Data Collection Devices (DCD) and establishing connectivity to BIG-IQ console. (REQUIRED)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Objective
^^^^^^^^^

To introduce the user to a DCD, establish connectivity with BIG-IQ
console node to begin data collection task. For the purposes of this lab
the Data Collection Device has already been deployed and licensed with
the appropriate license key (F5-BIQ-LOGNOD101010E-LIC).

Click Add to add a DCD to the BIG-IQ console node.

-  Log in to the BIG-IQ Console Node (10.0.0.200 admin/401elliottW!)

-  Under System→BIG-IQ DATA COLLECTION

-  Select BIG-IQ Data Collection Devices

-  Click the Add button

   |image68|

-  Add the DCD Management IP Address (10.0.0.201), Username: admin,
   Password: 401elliottW! and the Data Collection IP Address (self-IP:
   10.128.10.201). Data collection port default is 9300. Click the Add
   button in the lower right of the screen.

   |image69|

-  Adding the DCD will take a minute or two:

   |image70|

-  DCD item in UI displayed.

   -  Status – State indicator. Green (UP) \| Yellow (Unhealthy) \| Red
      (Down)

   -  Device name – Hostname of DCD (data collection device)

   -  IP Address – IP Address of interface used for data collection.

   -  Version – Software version of BIG-IQ DCD (data collection device)

Add device to inventory after DCD has been added to see the user experience around statistics.

We will discover devices 10.0.0.4 using the UI and 10.0.0.5 using REST
and enable statistic collection for these BIG-IP’s.

Click Add to add a device to the BIG-IQ console.

-  Log in to the BIG-IQ Console Node (10.0.0.200 admin/401elliottW!)

-  Under Device→Add Device

    |image71|

    -Complete the form for the device add using IP 10.0.0.4, username:
    admin, password: 401elliottW!

    |image72|

|image73|

To discover 10.0.0.5, use the POSTMan collection labeled “Service Provider Specialist Event - Lab 4”. Please note you may have to manually import the ADC service due to a conflict. Conflict resolution is capable via the API however; outside of the scope of this lab. For additional details please reference the API documentation located here:

http://bigiq-cm-restapi-reference.readthedocs.io/en/latest/HowToGuides/Trust/Trust.html

-  Complete the Import (current-configuration copy to
   working-configuration on BIG-IQ) for LTM and AFM for both BIG-IP’s.
   For any conflict resolution use BIG-IP as the source of truth

   |image74|

Navigate to the monitoring dashboards to validate that statistics are being collected and displayed for the BIG-IP devices.

-  Navigate to Monitoring→Dashboards→ Device→ Health to verify that the
   graphs are populated.

   |image75|

-  If you don’t see data, raise your hand to get some help.

-  We are going to move on to other parts of the lab while we collect
   some stats and then we will circle back when we have more data to
   work with.

WORKFLOW 2: Creating a Backup Schedule
======================================

BIG-IQ is capable of centrally backing up and restoring all of the
BIG-IP devices it manages. To create a simple backup schedule, follow
the following steps.

1. Click on the **Back Up & Restore** submenu in the Devices header.

    |image76|

2. Expand the **Back Up and Restore** menu item found on the left and
   click on **Backup Schedules**\ |image77|

3. Click the **Create** button

    |image78|

4. Fill out the Backup Schedule using the following settings:

   - **Name:** Nightly
   - **Local Retention Policy:** Delete local backup copy 1 day after creation
   - **Backup Frequency:** Daily
   - **Start Time:** 00:00 Eastern Daylight Time
   - **Devices: Groups:** All BIG-IP Devices
   - Your screen should look similar to the one below.

     |image79|

5. Click **Save** to save the scheduled backup job.

6. Optionally feel free to select the newly created schedule and select
   “Back Up Now” to immediately backup the devices.

   a. When completed the backups will be listed under the Backup Files
      section

WORKFLOW 3: Uploading QKViews to iHealth for a support case
===========================================================

BIG-IQ can now push QKViews from managed devices to ihealth.f5.com and
provide a link to the report of heuristic hits based on the QKView.
These QKView uploads can be performed ad-hoc or as part of a F5 support
case. If a support case is specified in the upload job, the QKView(s)
will automatically be associated/linked to the support case. In addition
to the link to the report, the QKView data is accessible at
ihealth.f5.com to take advantage of other iHealth features like the
upgrade advisor.

#. Navigate to **Monitoring** **→ Reports** → **Device** → **iHealth →
   Configuration**

    |image80|

#. Add Credentials to be used for the QKView upload and report
   retrieval. Click the Add button under Credentials.

   |image81|

#. Fill in the credentials that you used to access https://ihealth.f5.com:

   - Name: Give the credentials a name to be referenced in BIG-IQ
   - Username: <Username you use to access iHealth.f5.com>
   - Password: <Password you use to access iHealth.f5.com>

   |image82|

#. Click the Test button to validate that your credentials work.

#. Click the Save & Close button in the lower right.

#. Click the Uploads button in the BIG-IP iHealth menu.

#. Click the Upload button to select which devices we need to upload
   QKViews from Case123456

#. Fill in the fields to upload the QKViews to iHealth.

   - Name: CaseC123456
   - F5 Support Case Number: C123456
   - Credentials: <Select the credentials you just stored in step 5>
   - Devices: Move all devices from Available to Selected

   |image83|

#. Click the Upload button in the lower right.

#. Click on the name of your upload job to get more details

   |image84|

#. Observe the progress of the QKView creation, retrieval, upload,
   processing, and reporting. This operation can take some time, so you
   may want to move on to the next exercise and come back.

#. Once a job reaches the Finished status, click on the Reports menu to
   review the report.

#. Click on the Download PDF link to view each of the reports.

   |image85|

#. Open a browser window/tab to https://ihealth.f5.com

#. Log in with the same credentials that you saved in step 5.

#. Observe the full QKViews that are available in iHealth for further
   use with items like the Upgrade Advisor.

   |image86|

.. |image68| image:: /_static/class1/image64.png
   :width: 6.48958in
   :height: 5.20833in
.. |image69| image:: /_static/class1/image65.png
   :width: 5.44792in
   :height: 3.73958in
.. |image70| image:: /_static/class1/image66.png
   :width: 6.50000in
   :height: 2.03125in
.. |image71| image:: /_static/class1/image67.png
   :width: 5.85291in
   :height: 2.35171in
.. |image72| image:: /_static/class1/image68.png
   :width: 5.90178in
   :height: 2.97140in
.. |image73| image:: /_static/class1/image69.png
   :width: 5.51646in
   :height: 4.65893in
.. |image74| image:: /_static/class1/image70.png
   :width: 2.57055in
   :height: 1.69135in
.. |image75| image:: /_static/class1/image71.png
   :width: 5.84302in
   :height: 4.64525in
.. |image76| image:: /_static/class1/image72.png
   :width: 6.50000in
   :height: 2.80208in
.. |image77| image:: /_static/class1/image73.png
   :width: 2.28056in
   :height: 1.23889in
.. |image78| image:: /_static/class1/image74.png
   :width: 2.00000in
   :height: 1.47917in
.. |image79| image:: /_static/class1/image75.png
   :width: 6.50000in
   :height: 4.85417in
.. |image80| image:: /_static/class1/image76.png
   :width: 6.50000in
   :height: 2.70000in
.. |image81| image:: /_static/class1/image77.png
   :width: 1.88472in
   :height: 0.92639in
.. |image82| image:: /_static/class1/image78.png
   :width: 4.50000in
   :height: 2.85417in
.. |image83| image:: /_static/class1/image79.png
   :width: 6.50000in
   :height: 3.10000in
.. |image84| image:: /_static/class1/image80.png
   :width: 2.82222in
   :height: 0.74931in
.. |image85| image:: /_static/class1/image81.png
   :width: 6.50000in
   :height: 2.89583in
.. |image86| image:: /_static/class1/image82.png
   :width: 6.47361in
   :height: 0.84236in
