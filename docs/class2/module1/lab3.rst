Configure Local Logging For Firewall Events
===========================================

Security logging needs to be configured separately from LTM logging. 

High Speed Logging for modules such as the firewall module requires three componenets.

  - A Log Publisher
  - A Log Destination (local-db for this lab)
  - A Log Profile

For more detailed information on logging please consult the BIG-IP documentation.

https://askf5.f5.com/kb/en-us/products/big-ip_ltm/manuals/product/bigip-external-monitoring-implementations-13-0-0/3.html

In this lab, we will configure a local log publisher and log profile. The
log profile will then be applied to the virtual server and tested.


Create A Log Publisher
----------------------

This will send the firewall logs to a local database.

Create the log publisher using the following information:

**Navigation:** System > Logs > Configuration > Log Publishers, then click
Create

+-------------------------------+----------------------------+
| **Name**                      | firewall\_log\_publisher   |
+===============================+============================+
| Destinations (Selected)       | local-db                   |
+-------------------------------+----------------------------+

|image24|

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

Create A Log Profile
--------------------

Create the log profile using the following information:

**Navigation:** Security > Event Logs > Logging Profiles, then click Create

+-------------------------+--------------------------+
| **Name**                | firewall\_log\_profile   |
+=========================+==========================+
| **Protocol Security**   | Checked                  |
+-------------------------+--------------------------+
| **Network Firewall**    | Checked                  |
+-------------------------+--------------------------+

Modify The Log Profile To Collect Protocol Security Events
----------------------------------------------------------

Edit log profile protocol security tab using the following information:

**Navigation:** Click on the Protocol Security tab and select the firewall_log_publisher

+----------------------------+
| firewall\_log\_publisher   |
+----------------------------+

|image25|

.. NOTE:: Leave all other fields using the default values.

Modify The Log Profile To Collect Firewall Security Events
----------------------------------------------------------

Edit log profile network firewall tab using the following information:

**Navigation:** Click on the Network Firewall tab

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

.. NOTE:: Leave all other fields using the default values.

**Navigation:** Click Finished

Apply The Logging Configuration
-------------------------------

Apply the newly created log profile to the external virtual server created in the previous lab.

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

Validate Lab 3 Configuration
----------------------------

Open a new web browser tab and access the virtual server or repeat the
curl statements from the previous sections.

URL: https://www.mysite.com

.. NOTE:: This test generates traffic that creates network firewall log entries.

**Navigation:** Security > Event Logs > Network > Firewall

|image29|

.. ATTENTION:: View new network firewall log entries. Examine the data collected there.

.. NOTE:: This completes Module 1 - Lab 3

.. |image24| image:: /_static/class2/image26.png
   :width: 7.05278in
   :height: 2.93819in
.. |image25| image:: /_static/class2/image27.png
   :width: 7.04444in
   :height: 2.53958in
.. |image26| image:: /_static/class2/image28.png
   :width: 4.83169in
   :height: 5.41497in
.. |image27| image:: /_static/class2/image29.png
   :width: 7.04167in
   :height: 5.88889in
.. |image28| image:: /_static/class2/image30.png
   :width: 7.25278in
   :height: 1.01170in
.. |image29| image:: /_static/class2/image31.jpeg
   :width: 6.73811in
   :height: 1.69444in