Lab 5: Action in Signature Definition vs Signature vs Profile
=============================================================

Estimated completion time: 15 minutes

Overview
~~~~~~~~
There are three places where you can define an action for a custom signature. In this lab we'll
explore different settings to see how they interact. If you are pressed for time, skip to the end for
the conclusion. 

Task 1: Set Action in Signature Definition from "Alert" to "Drop"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Snort® signatures have a number of actions that can be set.
{alert,log,pass,activate,dynamic,drop,reject,sdrop} We will consider alert, drop, and reject. In
your custom signature 100001, alert is already in place, and we see that with the following
settings:


Signature Definition = "alert"
Signature Action = "accept" 
Inspection Profile = "reject"
The result is a RST issued.


1. Let's see if we can change that outcome. Change the Signature Definition action to
"drop" BEGIN HINT:[drop tcp any any -> any 80 (content:cat.gif;http_uri; sig_id:100001;)
]END HINT

2. Test by issuing the following command from the Desktop terminal:
curl -A Attack-Bot-2000 http://10.12.100.220/cat.gif
NOTE: wait 10-15 seconds for the configuration to be updated before issuing this
command.


**Expected output:**


curl: (56) Recv failure: Connection reset by peer
This indicates that the Inspection Profile Action setting "reject" for signature 100001 is
overriding the Signature Definition action for the rule. If the BIG-IP were silently dropping the
connection, it would lag before timing out rather than the instant RST.
Procedure 2: Set Action in Signature from "Accept" to "Drop"


1. Change the Signature Action for 100001 to "Drop" and wait 10-15 seconds for the
configuration to update.

2. Test by issuing the following command from the Desktop terminal:


curl -A Attack-Bot-2000 http://10.12.100.220/cat.gif


**Expected output:**


curl: (56) Recv failure: Connection reset by peer
This again indicates that the Inspection Profile setting for Signature 100001 is overriding
the other settings. If the "Drop" were in effect, there would be a long lag before the
connection timed out



Task 2: Set the Inspection Profile action to "Accept"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. In Inspection Profile my-inspection-profile, modify the Action to "Accept" for Signature
100001. Wait 10-15 seconds for the configuration to update.

2. Test by issuing the following command from the Desktop terminal:


curl -A Attack-Bot-2000 http://10.12.100.220/cat.gif


**Expected output:**


<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>404 Not Found</title>
</head><body>
<h1>Not Found</h1>
<p>The requested URL /cat.gif was not found on this server.</p>
<hr>
<address>Apache/2.2.22 (Ubuntu) Server at 10.12.100.200 Port 80</address>
</body></html>
Looks like the only action setting that matters belongs to the Inspection Profile. 


.. NOTE:: This completes Module 4 - Lab 5

.. |image1| image:: /_static/class2/lab4-image1.png
.. |image2| image:: /_static/class2/lab4-image2.png
.. |image3| image:: /_static/class2/lab4-image3.png
.. |image4| image:: /_static/class2/lab4-image4.png
