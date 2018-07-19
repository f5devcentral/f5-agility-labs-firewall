Lab 2: Protocol Inspection - Compliance Checks
==============================================

Estimated completion time: Thirty Five 35 minutes

Overview
~~~~~~~~
Compliance Checks model protocols and applications and flag deviations from the model. End
users can't add compliance checks, but some of them have parameters the user can modify.
We'll look at a couple of these checks and modify one. 
Have fun!

Task 1: The Inspection Profile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
You will create an Inspection Profile containing compliance checks.

1. Navigate to Security > Protocol Security > Inspection Profiles and click 'Add', select 'New'

2. Name the profile 'my-inspection-profile'

3. Disable Signatures

4. Make sure Compliance is enabled.

5. Under Services, Select HTTP.

.. NOTE:: You have to wait a few seconds after selecting HTTP

|ips2|


6. When the HTTP Service appears, click to open the Inspection list for HTTP, and select Inspection Type 'compliance.' 


|ips3|


7. Click the checkbox to select all the HTTP compliance checks.

8. In the edit window in the upper-right of the F5 GUI, make the following selections:

  - Enable the selected inspections

  - Set the 'Action' to 'Accept'

  - Enable logging

.. NOTE:: These should be the default actions, so they most likely are already set for you.

|ips4|


  -  Click 'Apply'

9. Click 'Commit Changes to System'

**You should now have an Inspection Policy.**

 
Task 2: Apply the Profile to the Global Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1. Navigate to Security > Network Firewall > Active Rules

2. Change Context to 'Global'

3. Click 'Add Rule' 

4. Make a new policy named 'global-fw-policy'

5. Make a new rule named fw-global-http-inspection'

6. Configure the new rule:

 - Protocol 'TCP'

 - Set the Destination port to 80

 - Action 'Accept' 

 - Protocol Inspection Profile: 'my-inspection-profile'

 - Enable logging

7. Click Save

|ips5|


Task 2.5: Create testing Virtual server on port 80
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
To get an understanding of how the IPS function works, we need the manual commands we can issue via Telnet. Because Telnet does not work very well with SSL, we need to create a virtual server on port 80 instead of the one on 443 that we have been using so far.  Remember this is only for testing, and the IPS functionality can work perfectly well on encrypted traffic ( as long as we terminate the SSL )

1. Check if the pool "pool_www.mysite.com" exists.  Does it already exist? Only if it does not exist, please create it as follows: 

.. list-table::
   :header-rows: 1

   * - **Name**
     - **Health Monitor**
     - **Members**
     - **Service Port**
   * - pool\_www.mysite.com
     - tcp\_half\_open
     - 10.10.121.129
     - 80


2. Create a virtual server with no HTTP profile.  Use the following settings, leave everything else default.

.. list-table::
   :header-rows: 1

   * - **Parameter**
     - **Value**
   * - name
     - IPS_VS
   * - IP Address
     - 10.10.99.40
   * - Service Port
     - 80
   * - SNAT
     - automap
   * - Pool
     - pool\_www.mysite.com

.. NOTE:: Note that we neither applied an Inspection Policy to this VS, nor did you apply a Firewall Policy to this VS.  And yet, the IPS is now functional on this VS.  Can you think why this is? This is because the global firewall policy is in affect, and the Inspection Policy will be invoked by the Global Firewall Policy.

Task 3: Test the Inspection Profile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1. From the Cygwin session, or from the DOS prompt, enter this command: 

.. code-block:: console

   telnet 10.10.99.40 80


**The expected output is:**

.. code-block:: console

   Trying 10.10.99.40...
   Connected to 10.10.99.40
   Escape character is '^]'.


**Enter the following ( Suggestion: copy and paste ):**

.. code-block:: console

   GET /index.html HTTP/5

(hit Enter key two times)

The expected HTTP response is:

.. code-block:: console

   HTTP/1.1 200 OK
   ( and lots more HTTP headers, etc.)




2. Check the results.

 - Navigate to Security > Protocol Security > Inspection Profiles > my-inspectionprofile

 - Filter for Inspection Type 'compliance'

 - Look at the Total Hit Count for HTTP Compliance Check ID 11011 "Bad HTTP Version." We expect to see a hit count of at least 1, and a missing host header count of at least 1.

 -  Look at the protocol inspection logs.  Go to Security > Protocol Security > Inspection Logs.  You can see the incoming ip address and port, among other things. 

|image5|

|image6|


Task 4: Modify a Compliance Check
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1. Select Compliance Check 11017 'Disallowed Methods'

2. Enter the value "Head" and click 'Add'

|head2|


3. Click 'Commit Changes to System'


Task 5: Test the Modified Compliance Check
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. From the Cygwin session, enter (or copy and paste) this command:

.. code-block:: console

   telnet 10.10.99.40 80

**The expected output is:**

.. code-block:: console

   Trying 10.10.99.40...
   Connected to 10.10.99.40
   Escape character is '^]'.


**Enter the following ( Suggestion: copy and paste ):**

.. code-block:: console

   HEAD /index.html HTTP/1.1

**Expected output:**

.. code-block:: console

   HTTP/1.1 400 Bad Request

2. Check the results. 

.. NOTE:: Just an interesting point to make again, this is the IPS code checking HTTP, not the HTTP Profile ( This VS does not have an HTTP Profile )

- Navigate to Security > Protocol Security > Inspection Profiles > my-inspection-profile

- Filter for Inspection Type 'compliance'

- Look at the Total Hit Count for HTTP Compliance Check ID 11017 "Disallowed Methods." You may have to refresh the page. 

- We expect to see a hit count of 1.

4. Look at the stats. Enter the following command on the Big-IP command line:

.. code-block:: console

   tmsh show sec proto profile my-inspection-profile


We expect to see a Hit Count of at least 1 (more if you've done it multiple times). 

|tmsh1|


.. NOTE:: This completes Module 4 - Lab 2

.. |xxx1|  image:: /_static/class2/xxx1.png
.. |tmsh1|  image:: /_static/class2/ips-tmsh1.png
.. |head2|  image:: /_static/class2/head2.png
.. |head|   image:: /_static/class2/head.png
.. |image5| image:: /_static/class2/module4-lab2-image5.png
.. |image6| image:: /_static/class2/module4-lab2-image6.png
.. |ips8| image:: /_static/class2/ips8.png
   :width: 7.05000in
   :height: 5.28750in
.. |ips7| image:: /_static/class2/ips7.png
   :width: 7.05000in
   :height: 5.28750in
.. |ips5| image:: /_static/class2/global-policy.png
.. |ips4| image:: /_static/class2/ips4.png
.. |ips3| image:: /_static/class2/ips3.png
   :width: 7.05000in
   :height: 5.28750in
.. |ips2| image:: /_static/class2/ips2.png
   :width: 7.05000in
   :height: 5.28750in
