AFM with iRules LX
==================

Estimated completion time: 15 minutes

Beginning in TMOS 12.1 BIGIP offers iRules LX which is a node.js extension to iRules IRules LX does not replace iRules, rather allows iRules to offer additional functionality. In this lab you see how iRules LX can be used to look up client ip addresses that should be disallowed by AFM.

**Note:** You do not need skills or knowledge of iRules LX to do this lab. This lab will not go into detail on iRules LX nor will it go into detail on Node.JS, rather, this lab shows an application of this with AFM.
 
**Note:** We are using a different set of IP subnets just for this module, as shown in this network diagram:

|image98|

**Note:** You should be comfortable creating pools and virtual servers by now. Therefore, the following steps to create pools, virtual servers, and AFM policies are kept brief and to the point.

Create the Pool and VS
~~~~~~~~~~~~~~~~~~~~~~
1. Create a pool named afmmysql_pool with one pool member ip address 172.1.1.10 and port 80, and a tcp half-open monitor. Leave all other values default.

2. Create a TCP VS named afmmysql_vs with a destination address of 192.168.1.51, port 80, snat Automap, and set it to use the afmmysql_pool pool. Leave all other values default.


Test the Virtual Server
~~~~~~~~~~~~~~~~~~~~~~~
On the Win7 client, use curl in the cygwin cli ( or from the c:\\curl directory in a windows command line shell ) to test the Virtual Server. 

``curl http://192.168.1.51 --connect-timeout 5``

You will notice that you connect, and web page is shown.

|curl_lx_success|

Copy & Paste LX Code 
~~~~~~~~~~~~~~~~~~~~

**Note:** Dont' worry, you're not doing any coding here today.  Just a little copy and paste excersize. You are going to copy two files from the Windows desktop and paste them into the iRules LX workspace.


1. **Navigate:** In the BIG-IP webgui, navigate to Local Traffic->iRules-> LX Workspaces-> irules\_lx\_mysql\_workspace
2. Open the mysql\_iRulesLx.txt file in Notepad ( located on the Windows Desktop) and copy ( Ctrl-C or use Mouse ) the entire contents
3. In the Big-IP webgui, Click on rules->mysql\_irulelx 
4. Replace the contents of this with the text you just copied from the mysql\_irulesLx.txt file. 
5. Click "Save File"
6. In Windows, open the index.js file located on the Desktop ( it should open in NotePad ), select all, and copy ( Ctrl-C or use Mouse ) its entire contents.
7. In the Big-IP gui, click on mysql\_extension/index.js. Replace the contents of mysql\_extension/index.js with the contents of the index.js that you just copied.
8. Click “Save File”

|lx_workspace.png|

Create LX Plug-In
~~~~~~~~~~~~~~~~~

1. **Navigate:** to Local Traffic->iRules-> LX Plugins and create a new LX Plugin named “afmmysqlplug” using the workspace (From Workspace dropdown) irules\_lx\_mysql\_workspace. 

2. Click “Finished”

|image99|


Create a new AFM Policy to use this LX Rule
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Note:** You are assumed to be pretty familiar with creating AFM policies by now, hence the following steps are kept brief and to the point.

1. Create a new AFM policy named afmmysql_pol
2. Add a rule named afmmysql\_rule and click iRule to assign the “mysql\_Irulelx” iRule. 

|image100|


3. Click “Finished"
4. Assign this rule to the afmmysql_vs virtual server.

Test the VS with the LX Rule in Place
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

On the Win7 client, use curl in the cygwin cli ( or from c:\\curl directory in a windows command line shell ) to test that the client is being blocked, as the Win7 client’s ip is in the mysql database.

``curl http://192.168.1.51 --connect-timeout 5``

If everything went successfull, this should now timeout.

.. ATTENTION:: Ensure that the iRule is working properly, by going back to the AFM rule and setting the iRule back to None. Also examine the log files at ``/var/log/ltm`` on the BIG-Ip ( or look in the GUI Log as shown here )

|lx_log|

.. NOTE:: This completes Module 3 - Lab 1

.. |lx_workspace.png| image:: /_static/class2/lx_workspace.png
.. |curl_lx_success| image:: /_static/class2/curl_lx_success.png
.. |lx_log| image:: /_static/class2/lx_log.png
.. |image98| image:: /_static/class2/lx_diagram.png
   :width: 7.05000in
   :height: 3.28750in
.. |image99| image:: /_static/class2/lx_plug.png
.. |image100| image:: /_static/class2/image148.png
