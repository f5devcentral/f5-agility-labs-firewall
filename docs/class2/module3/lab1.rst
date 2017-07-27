AFM with iRules LX
==================

Estimated completion time: 15 minutes

Overview
~~~~~~~~

Beginning in TMOS 12.1 BIGIP offers iRules LX which is a node.js extension to iRules IRules LX does not replace iRules, rather allows iRules to offer additional functionality. In this lab you see how iRules LX can be used to look up client ip addresses that should be disallowed by AFM.

Use the following network diagram for this module

|image98|

Copy LX Code and Test
~~~~~~~~~~~~~~~~~~~~~

On the Windows 7 client, open the index.js file located in the Desktop
folder, copy its entire contents.

On the BIG-IP webgui, navigate to Local Traffic->iRules-> LX
Workspaces-> irules\_lx\_mysql\_workspace

And replace the contents of mysql\_extension/index.js with the contents
of the index.js on the Win7 client.

Click “Save File”

**Navigate:** click on rules->mysql\_irulelx

On the Windows 7 client:

**Navigate:** Open the mysql\_iRulesLx.txt file located in the
Desktop folder, copy its entire contents and paste the contents into the
“mysql\_irulelx”. Click “Save File”

On the BIG-IP webgui 

**Navigate:** to Local Traffic->iRules-> LX Plugins and
create a new LX Plugin named “afmmysqlplug” using the workspace (From
Workspace dropdown) irules\_lx\_mysql\_workspace. Click “Finished”

|image99|

**Navigate:** to Security->Network
Firewall->Policies->afmmysql\_pol->afmmysql\_rule (this rule already
exists) and click iRule to assign the “mysql\_Irulelx” iRule. Click
“Update”

|image100|

This policy is already enforced on the ``afmmysql_vs (192.168.1.51)``

On the Win7 client, use curl in the cygwin cli to test that the client
is being blocked, as the Win7 client’s ip is in the mysql database.

``curl http://192.168.1.51 --connect-timeout 5``

this should timeout.

.. ATTENTION:: Ensure that the iRule is working properly, by going back to the AFM rule and setting the iRule back to None. Also examine the log files at ``/var/log/ltm`` on the BIG-IP.

.. NOTE:: This completes Module 3 - Lab 1

.. |image98| image:: /_static/class2/image146.png
   :width: 7.05000in
   :height: 5.28750in
.. |image99| image:: /_static/class2/image147.png
   :width: 4.00000in
   :height: 1.93056in
.. |image100| image:: /_static/class2/image148.png
   :width: 6.00000in
   :height: 6.83333in