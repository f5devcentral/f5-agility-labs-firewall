Lab 3: Protocol Inspection - Signatures
=======================================

Estimated completion time: Five 5 minutes

Overview
~~~~~~~~
Signature Checks can be written by the user, unlike Compliance Checks which are programmatic inspections provided only by F5. We'll start with a lab procedure that explores the use of the provided signatures.

Task 1: Enabling Signatures
~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Navigate to Security > Protocol Security > Inspection Profiles > my-inspection-profile
2. Enable Signatures

|image1|

3. Click 'Commit Changes to System'
4. Now enable an individual signature
5. Filter on Service 'HTTP', Inspection Type 'signature'
6. Sort the filtered signatures in reverse order of ID. Click the ID column twice.

|image2|


c. Scroll down to 2538 and click to edit.

d. Configure the signature:

i. Enable

ii. Action: Reject

iii. Log: Yes

iv. Click 'Close'

v. Click 'Commit Changes to System'

**You should now have an enabled HTTP signature. We don't know exactly what it's checking for, but we'll get to that in the next Procedure.**

Task 2: Reviewing the actual pattern check
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The UI currently doesn't give you the exact pattern being checked for in a Signature. We will search the file where the default signatures are defined and review the one with signature id 2538.

1. From the BIG-IP command line, enter the following command:

grep 2538 /defaults/ips_snort_signatures.txt


The expected output is:

**alert tcp any any -> any any (content:"User-Agent|3A 20|Vitruvian";
fast_pattern:only; http_header; sig_id:2538;)**


The Signature is looking for TCP traffic with http_header contents "User-Agent: Vitruvian"


Task 3: Test the Signature
~~~~~~~~~~~~~~~~~~~~~~~~~~
1. From the Desktop terminal, issue the following command:

**curl -A Vitruvian http://10.10.99.40/cat.gif**


This uses curl which you area already familiar with, and specifies the USER-AGENT = "Vitruvian"


The expected output is:

**curl: (56) Recv failure: Connection reset by peer**


2. Check the results: refresh the Inspection Profiles page, filter as needed, sort as needed, and review the Total Hit Count for Signature ID 2538.

3. Since that is a pain, use the BIG-IP command line:

**tmsh show sec proto profile my-inspection-profile**

We expect to see a Hit Count of 1 for Inspection ID 2538.

This was a simple test of a simple pattern match. There are some tricks to testing signatures with more elaborate patterns, which we'll explore in the final lab. 



.. NOTE:: This completes Module 4 - Lab 3

.. |image1| image:: /_static/class2/lab3-image1.png
   :width: 7.05000in
   :height: 5.28750in
.. |image2| image:: /_static/class2/lab3-image2.png
   :width: 7.05000in
   :height: 5.28750in
