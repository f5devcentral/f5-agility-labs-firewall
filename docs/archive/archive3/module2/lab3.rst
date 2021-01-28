Attack stop
===========

Stop SYN flood
--------------

Press (``Ctrl-C``) to finish the attack. Traffic will drop on Router1

|image19|

.. NOTE:: STOP HERE. It will take 5-10 minutes for Flowmon to mark the attack as `NOT ACTIVE`. This is done in order to avoid 'flip-flop' effect in repeated attack situation

Mitigation stop
---------------

Flowmon DDoS Defender Attack List screen shows the current attack with
status *NOT ACTIVE*. Attack will transition to *ENDED* state when
Flowmon performs *Mitigation Stop* routine

|image20|

|image21|

|image22|

`\*It typically takes ~ 5min for Flowmon DDoS Defender to update attack
status`

AFM configuration, BGP route removal
------------------------------------

As part of *Mitigation Stop* routine Flowmon removes BGP route from
Router1 and Virtual Server and DDoS Profile from AFM

``show ip bgp``

|image23|

**In AFM TMUI navigate to Security --> DoS Protection --> DoS Profiles**

Verify that only default “dos” profile present

|image24|

**In AFM TMUI navigate to Local Traffic --> Virtual Servers --> Virtual Server
List**

Verify that Virtual Server matching Attack ID has been removed

|image25|

Congratulations! You have successfully completed the lab!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. |image19| image:: images/image19.png
   :scale: 50%
.. |image20| image:: images/image20.png
   :scale: 60%
.. |image21| image:: images/image21.png
   :scale: 60%
.. |image22| image:: images/image22.png
.. |image23| image:: images/image23.png
.. |image24| image:: images/image24.png
   :scale: 60%
.. |image25| image:: images/image25.png
   :scale: 60%
