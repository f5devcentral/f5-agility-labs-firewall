Creating Rules and Policy via REST API
======================================

The RESTful API is also capable of AFM modifications. To add the same
rules and policy to bigip02.agility.com (10.0.0.5), simply follow the
calls in the collection “Service Provider Specialist Event - Lab 1b”.
These calls can be run individually in the sequence provided or using
Runner as exampled below:

|image25|

Test the New Firewall Rules
===========================

Once again you will generate traffic through the BIG-IP VE system using
the ***wildcard\_vs*** virtual server and then

view the AFM (firewall) logs.

-  Open a new Web browser and access
   `*https://10.128.10.223* <https://10.128.10.223>`__

-  Edit the URL to `*http://10.128.10.223* <http://10.128.10.223>`__

-  Edit the URL to
   `*http://10.128.10.223:8081* <http://10.128.10.223:8081>`__

-  Open either Chrome or Firefox and access
   `*ftp://10.128.10.223* <ftp://10.128.10.223>`__

-  Open Putty and access 10.128.10.223

In the Configuration Utility, open the ***Security > Event Logs >
Network > Firewall*** page.

Access for port 80 was granted to a host using the web\_rule\_list:
***allow\_http*** rule and access for 443 was granted using the
web\_rule\_list: ***allow\_https rule***.

|image26|

Requests for port 8081, 21, and 22 were all rejected due to the
reject\_all rule.

|image27|

You may verify this, by going to ***Network > Route Domains***, then
selecting the hyperlink for route domain 0, then select ***Security***.
Note the ***Count*** field next to each rule as seen below. Also note
how each rule will also provide a ***Latest Matched*** field so you will
know the last time each rule was hit:

|image28|

If you wanted to reject all traffic from the 10.0.10.0/24 network
including HTTP & HTTPS, then open the ***Security > Network Firewall >
Rules Lists*** page. Select ***web\_rule\_list*** and click the
***Reorder*** button. Use your mouse to move the
***reject\_10\_0\_10\_0*** rule above the ***allow\_http rule***.

|image29|

Click ***Update***.

.. |image25| image:: /_static/class1/image26.png
   :width: 6.50000in
   :height: 5.02569in
.. |image26| image:: /_static/class1/image27.png
   :width: 6.50000in
   :height: 1.46111in
.. |image27| image:: /_static/class1/image28.png
   :width: 6.50000in
   :height: 1.71319in
.. |image28| image:: /_static/class1/image29.png
   :width: 6.50000in
   :height: 1.50000in
.. |image29| image:: /_static/class1/image30.png
   :width: 6.50000in
   :height: 0.88958in

