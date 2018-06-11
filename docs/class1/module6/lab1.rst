Add External Logging Device
===========================

WORKFLOW 1 : Add an External Logging Device and Configure Single Sign On
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this lab, you’ll be creating a connection to an external logging
device (PLA) and configuring single sign on for monitoring

**Objective**

-  Create an external logging device

-  Create a login token for SSO

**Lab Requirements**

-  Web UI access to BIG-IQ

Task 1 – Create an external logging device
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Log into BIG-IQ at `*https://10.0.0.200* <https://10.0.0.200>`__

Navigate to **System** from the top tabs of **BIG-IQ**.

In the left navigation, click on **BIG-IQ Data Collection** →
**3\ :sup:`rd` Party Data Collection Devices**

|image136|

Click Add to add a new 3\ :sup:`rd` Party Data Collection Device

|image137|

Complete the page with the following table:

+----------------------+---------------------------------------------------+-----------------------------+
| **Name**             | **Lab\_PLA**                                      |                             |
+----------------------+---------------------------------------------------+-----------------------------+
| **Description**      | **LAB PLA**                                       |                             |
+----------------------+---------------------------------------------------+-----------------------------+
| **Device Type**      | **SevOne PLA**                                    |                             |
+----------------------+---------------------------------------------------+-----------------------------+
| **IP Address**       | **10.128.10.202**                                 | Check Use as Query Server   |
+----------------------+---------------------------------------------------+-----------------------------+
| **User Name**        | **root**                                          |                             |
+----------------------+---------------------------------------------------+-----------------------------+
| **Password**         | **dRum&5853**                                     |                             |
+----------------------+---------------------------------------------------+-----------------------------+
| **Push Schedule**    |                                                   |                             |
+----------------------+---------------------------------------------------+-----------------------------+
| **Status**           | **Enabled Checked**                               |                             |
+----------------------+---------------------------------------------------+-----------------------------+
| **Push Frequency**   | **Daily**                                         |                             |
+----------------------+---------------------------------------------------+-----------------------------+
| **Start/End Date**   | **Set to beginning of tomorrow's date (00:00)**   |                             |
+----------------------+---------------------------------------------------+-----------------------------+

When completed click the “Test” button on the “Test Connection”

Test will come back successful if settings are all correct as shown
below

|image138|

Click Add to complete the addition of an external logging device.

Task 2 – Configure Single Sign On
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Navigate to **Monitoring** from the top tabs of **BIG-IQ**.

On the left navigation, click on **Events**\ →\ **Network
Security**\ →\ **3\ :sup:`rd` Party Data Collection Devices**.

|image139|

Click on “Request Auth Token”. This will bring up the SevOne PLA
Authentication Token screen

|image140|

Fill in ***admin*** for username and ***SevOne*** for the password
and click “Request Token”

If the values are correct, a token will be returned

|image141|

Click “Save” to save the configuration changes.

You can now click on the “Launch” link to log into the PLA without
having to supply a username and password.

Additional Resources:

https://support.f5.com/kb/en-us/products/big-iq-centralized-mgmt/manuals/product/bigiq-central-mgmt-security-5-2-0/10.html#guid-8dbb4024-a82e-4173-83b0-72e0365207e4

Login to Your PLA
=================

To login to your PLA open up a browser on your laptop and use the
Management IP address (**10.128.10.202**) or use the Single Sign on in
BIG-IQ.

i.e. https://10.128.10.202

The login information for your PLA is ***admin/SevOne***

.. |image136| image:: /_static/class1/image128.png
   :width: 5.80000in
   :height: 5.40000in
.. |image137| image:: /_static/class1/image129.png
   :width: 6.50000in
   :height: 6.73958in
.. |image138| image:: /_static/class1/image130.png
   :width: 5.69444in
   :height: 4.95139in
.. |image139| image:: /_static/class1/image131.png
   :width: 6.50000in
   :height: 3.33333in
.. |image140| image:: /_static/class1/image132.png
   :width: 5.13889in
   :height: 2.33333in
.. |image141| image:: /_static/class1/image133.png
   :width: 5.13889in
   :height: 2.36806in

