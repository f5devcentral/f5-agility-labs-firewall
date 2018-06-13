Creating a Rule List for Multiple Services
==========================================

Rules and Rule Lists can also be created and attached to a context from
the Active Rules section of the GUI. Go to the ***Security > Network
Firewall > Rule Lists*** and create a ***Rule List*** called
***common\_services\_rule\_list*** then click ***Finished***. Enter the
rule list by clicking on its hyperlink, then in the ***Rules*** section
click ***Add***, and add the following information:

|image30|

Add another rule using the following information:

|image31|

|image32|

Add Another Rule List to the Policy
===================================

Use the ***Policies*** page to add the new firewall rule list to the
***rd\_0\_policy***. Open the ***Security > Network Firewall >
Policies*** page. Click on the policy name to modify the policy.

The only current active rule list is for the web\_policy. Click on
***Add*** to add the new rule list you just created.

Configure as seen below, for ***Name*** use
***allow\_common\_services***, for ***Order*** select ***Before***
***web\_policy***, and for ***Type*** select ***Rule List*** and select
the rule ***common\_services\_rule\_list***, then click ***Finished***.

|image33|

You should see the policy similar to the one below:

|image34|

At this point all FTP and SSH traffic will be allowed, before BIG-IP AFM
reaches the second rule list.

Test Access to the Wildcard Virtual Server
==========================================

-  Open a new Web browser and access
   `*http://10.128.10.223:8081* <http://10.128.10.223:8081>`__

-  Edit the URL to `*https://10.128.10.223* <https://10.128.10.223>`__

-  Edit the URL to `*http://10.128.10.223* <http://10.128.10.223>`__

-  Open either Chrome or Firefox and access
   `*ftp://10.128.10.223* <ftp://10.128.10.223>`__

-  Open Putty and access 10.128.10.223

-  Close all Web browsers and Putty sessions.

You should notice HTTP, HTTPS, FTP, and SSH traffic is now allowed
through the firewall, while traffic destined to port 8081 is still
rejected. If you do not see the 8081 request failing, you may need to
refresh to avoid using the browser cache.

Next, you’ll see how easy it is to search through the logs. In the
Configuration Utility, open the ***Security > Event Logs > Network >
Firewall*** page. Click ***Custom Search***. Select a ***Reject*** entry
in the list (just the actual word “reject”) and drag it to the custom
search area.

|image35|

Click ***Search***. This will filter the logs so that it just displays
all rejected entries.

.. |image30| image:: /_static/class1/image31.png
   :width: 3.40998in
   :height: 1.25178in
.. |image31| image:: /_static/class1/image32.png
   :width: 3.40031in
   :height: 1.18502in
.. |image32| image:: /_static/class1/image33.png
   :width: 6.50000in
   :height: 0.66806in
.. |image33| image:: /_static/class1/image34.png
   :width: 3.43330in
   :height: 1.36973in
.. |image34| image:: /_static/class1/image35.png
   :width: 6.50000in
   :height: 1.08264in
.. |image35| image:: /_static/class1/image36.png
   :width: 3.29252in
   :height: 1.23036in

