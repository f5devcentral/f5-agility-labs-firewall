Creating and Viewing Alerts
===========================

WORKFLOW 2: Creating and Viewing Alerts
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this lab, you’ll be creating a new alert and reviewing the alert

Navigate to ***Settings*** > ***Alert Configuration***

Click “\ ***Add New Rule***\ ”

Select Content text matching or context tag analytics based on the rule
you are trying to create. For example, to create a new rule that will
alert when a new IP is ingested into the system (E.G. for a new DDoS
alerting mechanism) you would enter the following:

Ruleset – Context Tag Analytics

Data Examination Method – First Value Occurrence (FVO is unique to the
PLA)

Tags – SrcIP

Alert Thresholds – Upper 1 Lower 0

Alert Options – Enable (email or trap) or if left to –No Script—Alerts
will appear on the Alerts Page

|image145|

When finished click +\ **Add** and you will see a summary of the current
alerts

|image146|

If no external alerting mechanism is configured you can view current
alerts on the ***Alerts*** tab as shown:

|image147|

Now whenever a new Source or Destination IP is processed by the PLA an
alert will be created.

.. |image145| image:: /_static/class1/image135.png
   :width: 2.02736in
   :height: 4.50618in
.. |image146| image:: /_static/class1/image136.png
   :width: 6.50000in
   :height: 1.38194in
.. |image147| image:: /_static/class1/image137.png
   :width: 6.50000in
   :height: 1.04167in
