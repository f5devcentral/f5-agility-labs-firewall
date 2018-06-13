Lab 2: Protocol Inspection - Compliance Checks
==============================================

Estimated completion time: 15 minutes

Overview
~~~~~~~~
Compliance Checks model protocols and applications and flag deviations from the model. End
users can't add compliance checks, but some of them have parameters the user can modify.
We'll look at a couple of these checks and modify one. 
Have fun!

Task 1: The Inspection Profile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
You will create an Inspection Profile containing compliance checks.

1. Navigate to Security > Protocol Security > Inspection Profiles and click 'Add', select
'New'
2. Name the profile 'my-inspection-profile'
3. Disable Signatures
4. Make sure Compliance is enabled.
5. Under Services, Select HTTP.

|ips2|


6. When the HTTP Service appears, click to open the Inspection list for HTTP, and select
Inspection Type 'compliance.' 

|ips3|

7. Click the checkbox to select all the HTTP compliance checks.
8. In the edit window make the following selections:
a. Enable the selected inspections
b. Set the 'Action' to 'Accept'
c. Enable logging

|ips4|

d. Click 'Apply'
9. Click 'Commit Changes to System'

**You should now have an Inspection Policy.**
 
Task 2: Apply the Profile to the Global Policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1. Navigate to Security > Network Firewall > Active Rules. Verify that the Context is 'Global'
2. Click 'Add Rule' and select 'Add rule to Global'

|ips5|

3. Configure the new rule:
a. Name it 'fw-global-http-inspection'
b. Protocol 'TCP'
c. Destination '80'
d. Action 'Accept' (NOTE: scroll right to see these configuration elements.)
e. Protocol Inspection Profile: 'my-inspection-profile'
f. Enable logging
4. Click 'Commit Changes to System' button.

**You should now have an Inspection Policy that will be invoked by the Global Firewall Policy.**

Task 3: Test the Inspection Profile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1. From the Cygwin session, enter this command: **telnet 10.12.100.220 80**


**The expected output is:**

Trying 10.12.100.220...
Connected to 10.12.100.220.
Escape character is '^]'.


**Enter the following:**


GET /index.html HTTP/5
(hit Enter key two times)
The expected HTTP response is:
HTTP/1.1 200 OK
(etc.)


2. Check the results.
a. Navigate to Security > Protocol Security > Inspection Profiles > my-inspectionprofile
b. Filter for Inspection Type 'compliance'
c. Look at the Total Hit Count for HTTP Compliance Check ID 11011 "Bad HTTP
Version." We expect to see a hit count of 1. 

Task 4: Modify a Compliance Check
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1. Select Compliance Check 11017 'Disallowed Methods'
2. Enter the value "Head" and click 'Add'
3. Click 'Commit Changes to System'

Task 5: Test the Modified Compliance Check
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. From the Cygwin session, enter this command: **telnet 10.12.100.220 80**


**The expected output is:**


Trying 10.12.100.200...
Connected to 10.12.100.200.
Escape character is '^]'


**Enter the following:**


HEAD /index.html HTTP/1.1
(hit Enter key two times)


Expected output:
HTTP/1.1 400 Bad Request

2. Check the results.
a. Navigate to Security > Protocol Security > Inspection Profiles > my-inspectionprofile
b. Filter for Inspection Type 'compliance'

3. Look at the Total Hit Count for HTTP Compliance Check ID 11017 "Disallowed
Methods." You may have to refresh the page. We expect to see a hit count of 1.

4. Look at the stats. Enter the following command on the Big-IP command line:

**tmsh show sec proto profile my-inspection-profile**


We expect to see a Hit Count of 1. 



.. NOTE:: This completes Module 4 - Lab 2

.. |ips8| image:: /_static/class2/ips8.png
   :width: 7.05000in
   :height: 5.28750in
.. |ips7| image:: /_static/class2/ips7.png
   :width: 7.05000in
   :height: 5.28750in
.. |ips6| image:: /_static/class2/ips6.png
   :width: 7.05000in
   :height: 5.28750in
.. |ips5| image:: /_static/class2/ips5.png
   :width: 7.05000in
   :height: 5.28750in
.. |ips4| image:: /_static/class2/ips4.png
   :width: 7.05000in
   :height: 5.28750in
.. |ips3| image:: /_static/class2/ips3.png
   :width: 7.05000in
   :height: 5.28750in
.. |ips2| image:: /_static/class2/ips2.png
   :width: 7.05000in
   :height: 5.28750in
