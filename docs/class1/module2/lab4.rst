=================
Stale Rule Report
=================

AFM also can list out stale rules within the device its self. You must first enable the feature. 

1. Navigate to **Security** > **Reporting** > **Settings** > **Reporting Settings**.

2. Ensure **Collect Stale Rules Statistics** is checked under the Network Firewall Rules Section. 

3. Click **Save** before proceeding.

|image447|

4. Navigate to **Security** > **Reporting** > **Network** > **Stale Rules**.

5. Refresh the web page we’ve been testing (http://10.1.20.11) several times to see data populate into the rules.

   .. note:: It could take 60+ seconds for data to populate after refreshing the page.

   |image448|

   This information is quite useful for keeping a rule base tidy and optimized.

6. Take a few minutes to inspect the other reports. (**Security** > **Reporting** > **Network**)
 
   .. note:: Only the Enforced Rules will contain data. 

This concludes the Advanced Multilayer Firewall Protection Lab. We hope you found this information
valuable.

.. |image447| image:: _images/class2/image447.png
   :width: 3.55556in
   :height: 3.70347in
.. |image448| image:: _images/class1/image448.png
   :width: 6.49722in
   :height: 1in
