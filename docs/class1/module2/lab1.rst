Create and View Packet Tracer Entries
=====================================

In this section, you will generate various types of traffic as you did
previously, but now you will view the flow using the network packet
tracer. Login to bigip01.agility.com (10.0.0.4), open the ***Network >
Network Security > Packet Tester*** page.

|image43|

Create a packet test with the following parameters.

+---------------------+--------------------------+
| **Protocol**        | TCP                      |
+---------------------+--------------------------+
| **TCP Flags**       | SYN                      |
+---------------------+--------------------------+
| **Source**          | IP - 1.2.3.4             |
|                     | Port – 9999              |
|                     | Vlan – External          |
+---------------------+--------------------------+
| **TTL**             | 255                      |
+---------------------+--------------------------+
| **Destination**     | IP – 10.128.10.223       |
|                     | Port – 80                |
+---------------------+--------------------------+
| **Trace Options**   | Use Staged Policy – no   |
|                     | Trigger Log - no         |
+---------------------+--------------------------+

Click Run Trace to view the response. Your output should resemble the
allowed flow as shown below:

|image44|

Click **New Packet Trace** (optionally do not clear the existing data).

Create a packet test with the following parameters.

+---------------------+--------------------------+
| **Protocol**        | TCP                      |
+---------------------+--------------------------+
| **TCP Flags**       | SYN                      |
+---------------------+--------------------------+
| **Source**          | IP - 1.2.3.4             |
|                     | Port – 9999              |
|                     | Vlan – External          |
+---------------------+--------------------------+
| **TTL**             | 255                      |
+---------------------+--------------------------+
| **Destination**     | IP – 10.128.10.223       |
|                     | Port - **8081**          |
+---------------------+--------------------------+
| **Trace Options**   | Use Staged Policy – no   |
|                     | Trigger Log - yes        |
+---------------------+--------------------------+

Click Run Trace to view the response. Your output should resemble the
allowed flow as shown below:

|image45|

You can click on the /common/rd\_0\_policy hyperlink to examine the
policy which is rejecting the request.

You can also perform the same tests using the API. To do, so launch
POSTMan and use the collections for Lab 2. The first call will mirror
what was sent in the accept. The second call will mirror what was sent
in the rejected response. Example shown below:

|image46|

If you examine the JSON output for the second request, the rejected
request, you’ll notice the following lines within the JSON output:

.. code-block:: json

   {

   "acl_rtdom_policy_type": {
		"description": "Enforced"
   },
   "acl_rtdom_rule_name": {
  		"description": "/Common/web_rule_list:reject_all"
   }

This is the same rule which was show in the UI packet tester for the
rule that is not permitting this request. If you search for the keys
above in the permitted flow you’ll notice the output is quite different.

These are possible values:

``var aclActionType = {"0":"Drop","1":"Reject","2":"Allow","3":"Decisive
Allow","4":"Default","5":"Prior Decisive","6":"Default Rule
Allow","7":"Default Rule Drop","8":"Default Rule Reject","9":"Allow (No
Policy)", "10":"Allow (No Match)","11":"Prior Drop","12":"Not
Applicable","13":"Drop (Flow Miss)","14":"Prior Reject"}``

``var dosActionType = {"0":"Default","1":"Allow (No Anomaly)","2":"White
List","3":"Allow (Anomaly)","4":"Drop (Rate Limited)","5":"Drop
(Attack)", "6":"Prior White List","7":"Allow (No Policy)","8":"Prior
Drop","9":"Drop (Flow Miss)","10":"Not Applicable","11":"Prior Reject"}``

``var ipiActionType = {"0":"Default","1":"Allow","2":"Drop","3":"Allow
(White List)","4":"Allow (No Policy)", "5":"Allow (No Match)","6":"Prior
Drop","7":"Drop (Flow Miss)","8":"Not Applicable","9":"Prior Reject"};``

acl\_device\_is\_default\_rule = could be true or false.

.. |image43| image:: /_static/class1/image43.png
   :width: 6.48958in
   :height: 3.44792in
.. |image44| image:: /_static/class1/image44.png
   :width: 6.48958in
   :height: 2.60417in
.. |image45| image:: /_static/class1/image45.png
   :width: 6.49514in
   :height: 3.71389in
.. |image46| image:: /_static/class1/image46.png
   :width: 6.48958in
   :height: 1.61458in

