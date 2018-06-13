Viewing event logs and creating a tuple
=======================================

WORKFLOW 3: Viewing event logs and creating a tuple
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this lab, you’ll become familiar with the Investigate section, this
is where the raw logs can be viewed along with tuples created.

Navigate to the ***Investigate*** tab at the top of the page.

Verify you’re looking at the most recent data by selecting the past 2
hours from the hamburger next to the date near the top of the screen as
shown below

|image148|

Select a field tag to view the data within the tag:

|image149|

The far right will display the values within the selected tag:

|image150|

This is useful if you are looking for data from a specific device for
troubleshooting.

Click on the value and data will load from that selected field in the
viewing pane:

Different representations of the data can be selected by toggling
through the graph, textual and grid-style as shown below

|image151|

|image152|

|image153|

To view the logs from Lab one

Click on “Investigate”

From the Central Menu select the F5-Network-Firewall container as shown
in the following image:

|image154|

From left Menu under ***Event Tag*** click on ***application.***

From the Right Menu click review the logs in the central part of the
screen.

To select different containers or compound key searches select the
desired keys from the drop down to represent the data you are
investigating:

|image155|

As more data is selected more tags become available for further
analysis.

Tuples allow for quick views of multiple tags – for example if you
wanted to always view just the srcIP, destIP, destPort, action and
hostname you could build a quick tuple for this data representation.

To create a new Tuple, navigate to Setting > Tuples Management

Click Add to create a new tuple and select the desired tags along with
the time interval.

|image156|

When finished click save.

Tuples can be viewed from the ***Investigate*** page under tuple tags
(note tuples take 5 minutes to refresh their defined data):

|image157|

.. |image148| image:: /_static/class1/image138.png
   :width: 6.50000in
   :height: 1.14583in
.. |image149| image:: /_static/class1/image139.png
   :width: 2.07153in
   :height: 1.92847in
.. |image150| image:: /_static/class1/image140.png
   :width: 2.24306in
   :height: 1.29167in
.. |image151| image:: /_static/class1/image141.png
   :width: 6.50000in
   :height: 1.55556in
.. |image152| image:: /_static/class1/image142.png
   :width: 6.49306in
   :height: 1.69444in
.. |image153| image:: /_static/class1/image143.png
   :width: 6.49306in
   :height: 2.78472in
.. |image154| image:: /_static/class1/image144.png
   :width: 5.56875in
   :height: 2.25278in
.. |image155| image:: /_static/class1/image145.png
   :width: 4.28472in
   :height: 4.00000in
.. |image156| image:: /_static/class1/image146.png
   :width: 4.72222in
   :height: 4.25000in
.. |image157| image:: /_static/class1/image147.png
   :width: 2.03472in
   :height: 0.77083in
