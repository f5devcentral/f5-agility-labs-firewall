Locate orphaned and stale firewall rules
========================================

WORKFLOW 3: Locate orphaned and stale firewall rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In this lab, you will be creating a report that will show you firewall
rules that do not have any network traffic matching them. You could then
consider this firewall rule stale and potentially orphaned if it is no
longer needed in your environment.

**Objective:**

-  Locate firewall rules that are orphaned (unused)

**Lab Requirements:**

-  Web UI access to BIG-IQ

Task 1 – Review Network Firewall Security Reports
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

On **BIGIQ1**: (`*https://10.0.0.200)* <about:blank>`__

Navigate to **Monitoring** from the top tabs of **BIG-IQ**.

In the left navigation, click on Reports→Security→Network
Security→Firewall Rule Reports.

|image132|

Click **Create**.

For **Name**, type in **test\_report**.

On the **Report Type** dropdown, select **Stale Rule Report**.

On **Stale Rule Criteria**, select Rules with count less than **1** and
use today’s date

On Available Devices, move bigip1.agility.f5.com to the right Selected
box.

Click Save & Close.

Click on the report name **test\_report**.

|image133|

Down below to the right of **Report Results**, click on **HTML Report**.

-  There might be a browser pop up block warning in the upper right
   corner of your browser.

-  Allow the pop up. You may have to click on **HTML Report** again.

You should now see a report of rules that do not have **Hit Counts**.

You can also export CSV for further processing of data by selecting
**CSV Report.**

.. |image132| image:: /_static/class1/image126.png
   :width: 4.25000in
   :height: 4.43750in
.. |image133| image:: /_static/class1/image127.png
   :width: 6.48958in
   :height: 3.71875in
