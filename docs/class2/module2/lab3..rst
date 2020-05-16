Advanced Firewall Manager (AFM) Flow Inspector
==============================================

Create and View Flow Inspector Data
-----------------------------------

A new tool introduced in version 13 is the flow inspector. This tool is
useful to view statistical information about existing flows within the
flow table. To test the flow inspector, navigate to **Security > Debug >
Flow Inspector.** Refresh the web page we’ve been using for testing
(http://10.1.20.11) and click “Get Flows”.

**MK---SSH from jumphost to 10.1.20.11  (no login but session will show up in flows)** 

(mkurath---Opened incident C3173863 -- I could not see any flow data)

|image445|

Select a flow and click on the pop-out arrow for additional data.

|image446|

This will show the TMM this is tied to as well as the last hop and the
idle timeout. This data is extremely valuable when troubleshooting
application flows.

It is also worth noting you can click directly on the IP address of a
flow to pre-populate the data in the packet tester for validating access
and/or where the flow is permitted.

.. |image445| image:: /_static/class2/image445.png
   :width: 6.48542in
   :height: 1.34653in
.. |image446| image:: /_static/class2/image446.png
   :width: 6.49167in
   :height: 0.68819in

