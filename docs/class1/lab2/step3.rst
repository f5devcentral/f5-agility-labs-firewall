Advanced Firewall Manager (AFM) Flow Inspector
==============================================

Create and View Flow Inspector Data
-----------------------------------

A new tool introduced in version 13 is the flow inspector. This tool is
useful to view statistical information about existing flows within the
flow table. To test the flow inspector, navigate to **Security > Debug >
Flow Inspector.** Refresh the web page we’ve been using for testing
(http://10.1.20.11) and click “Get Flows”.

(mkurath---Opened incident C3173863 -- I could not see any flow data)

|image46|

Select a flow and click on the pop-out arrow for additional data.

|image47|

This will show the TMM this is tied to as well as the last hop and the
idle timeout. This data is extremely valuable when troubleshooting
application flows.

It is also worth noting you can click directly on the IP address of a
flow to pre-populate the data in the packet tester for validating access
and/or where the flow is permitted.

.. |image46| image:: /_static/class1/image45.png
   :width: 6.48542in
   :height: 1.34653in
.. |image47| image:: /_static/class1/image46.png
   :width: 6.49167in
   :height: 0.68819in

