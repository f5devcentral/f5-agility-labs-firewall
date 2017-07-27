APM SSL VPN Multi-tenancy using Route Domains and AFM Policies
==============================================================

Please refer to the following network diagram for this module:

|image101|

Estimated completion time: 45 minutes

Create The Access Policy Manager (APM) Profiles
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create APM connectivity profile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These steps guide you through configuring the APM VPN and policy

A connectivity profile is needed in order to establish a layer3 tunnel. The name of the connectivity profile will be the name of the tunnel interface where packets bound for the internal network(s) the vpn is protecting will exit. Tcpdump can be used to see if packets making to and from the tunnel

For example, in this exercise ``afm_cp`` is the name of the connectivity profile therefore the tcpdump syntax would look like

``tcpdump –ni afm_cp``

Create a APM connectivity profile

Open the Access > Connectivity/VPN > Profiles, click Add. Use the
following values, leave all others at their defaults

- Name: ``afm_cp``
- Parent Profile: ``/Common/connectivity``
- Click **Ok**

|image65|

Create APM access profile
~~~~~~~~~~~~~~~~~~~~~~~~~

Create a APM webtop

Open the Access > Webtops -> page, click Create. Use the following values, leave all others at their defaults

- Name: ``afm_webtop``
- Type: ``Full``
- Click ``Finished``

|image66|

Create a APM lease pool for route domain 0

Open the Access > Connectivity/VPN > Network Access (VPN) > IPV4 Lease
Pools page, click Create. Use the following values, leave all others at
their defaults

- Name: ``rd0_leasepool``
- Type: ``IP Address``
- IP Address: ``172.1.1.50``
- Click **Add**
- Click **Finished**

|image67|

Create a APM connectivity profile for route domain 1

Open the Access > Connectivity/VPN > Network Access (VPN) > IPV4 Lease
Pools page, click Create. Use the following values, leave all others at
their defaults

- Name: ``rd1_leasepool``
- Type: ``IP Address``
- IP Address: ``172.1.2.50``
- Click **Add**
- Click **Finished**

|image68|

Create a APM network access configuration for route domain 0

Open the Access > Connectivity/VPN > Network Access Lists page, click
Create. Use the following values, leave all others at their defaults

- Name: ``rd0_networkaccess``
- Click **Finished**

|image69|

Open the ``rd0_networkaccess`` you just created and go to Network Settings.
Use the following values, leave all others at their defaults

- IPV4 Lease Pool: ``rd0_leasepool``
- Traffic Options: ``Use split tunneling for traffic``
- IPV4 LAN Address Space:
  - IP Address: ``172.1.1.0``
  - Mask: ``255.255.255.0``
- Click **Add**
- Allow Local Subnet: ``Enable``
- Click **Update**

|image70|

|image71|

Create a APM network access configuration for route domain 1

Open the Access > Connectivity/VPN > Network Access Lists page, click
Create. Use the following values, leave all others at their defaults

- Name: ``rd1_networkaccess``
- Click **Finished**

|image72|

Open the ``rd1_networkaccess`` you just created and go to Network Settings.
Use the following values, leave all others at their defaults

- IPV4 Lease Pool: ``rd1_leasepool``
- Traffic Options: ``Use split tunneling for traffic``
- IPV4 LAN Address Space:
  - IP Address: ``172.1.2.0%1``
  - Mask: ``255.255.255.0``
- Click **Add**
- Allow Local Subnet: ``Enable``
- Click **Update**

|image73|

|image74|

Create a APM access profile

Open the Access >Profiles / Policies (Per-Session Policies) page, click
Create. Use the following values, leave all others at their defaults

- Name: ``afm_accessprofile``
- Profile Type: ``All``
- Accepted Languages: ``English``
- Click **Finished**

|image75|

|image76|

Now the click Edit for the ``afm_accessprofile``

|image77|

The ``afm_accessprofile`` is displayed

|image78|

Modify the Visual Policy Editor (VPE) – The VPE is what the client
interacts with and is assigned before the approval or denial of access
to a resource.

Click on the plus sign after the start block and navigate to Endpoint
Security (Client-Side) and select Firewall and click **Add Item**

|image79|

Leave the defaults

|image80|

and click **Save**

Change both endings from Deny

|image81|

to Allow

|image82|

In the Successful branch of the Firewall block click the “+” sign and
navigate to Assignment->Route Domain and SNAT Selection and click Add
Item. Use the following values, leave all others at their defaults

- Name: ``rd1``
- Route Domain: ``/Common/rd1``
- SNAT: ``none``
- Click **Save**

|image83|

After the rd1 block click the “+” sign and navigate to
Assignment->Advanced Resource Assign and 

- Click **Add Item**
- Click **Add new entry**
- Click **Add/Delete**

Use the following values, leave all others at their defaults

- Network Access: ``/Common/rd1_networkaccess``
- Webtop: ``/Common/afm_webtop``
- Click **Update**

Change the name to ``rd1`` Resource Assign and click Save

|image84|

In the fallback branch of the Firewall block click the “+” sign and
navigate to Assignment->Route Domain and SNAT Selection and click Add
Item. Use the following values, leave all others at their defaults

- Name: ``rd0``
- Route Domain: ``/Common/0``
- SNAT: ``none``
- Click **Save**

|image85|

After the rd0 block click the “+” sign and navigate to
Assignment->Advanced Resource Assign and 

- Click **Add Item**
- Click **Add new entry**
- Click **Add/Delete**

Use the following values, leave all others at their defaults

- Network Access: ``/Common/rd0_networkaccess``
- Webtop: ``/Common/afm_webtop``
- Click **Update**

Change the name to ``rd0`` Resource Assign and click Save

|image86|

The final access policy should look like

|image87|

Click Apply Access Policy

Create new virtual server for the APM L3 SSL VPN
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create a new virtual server for the APM L3 SSL VPN. This is the virtual
where the APM policy will be assigned and where sslvpn traffic will be
terminated.

Open the Local Traffic -> Virtual Servers page, click Create. Use the
following values, leave all others at their defaults

- Name: ``apm_vs``
- Type: ``standard``
- Destination Address: ``192.168.1.50``
- Service Port: ``443``
- HTTP Profile: ``HTTP``
- SSL Profile (Client): ``clientssl``
- Access Profile: ``afm_accessprofile``
- Connectivity Profile: ``afm_cp``
- Click **Finished**

|image88|

|image89|

|image90|

Create APM Policies
~~~~~~~~~~~~~~~~~~~

Create a new virtual server. Two new virtual servers need to be created
that control traffic coming out of the vpn tunnel to resources protected
by the tunnel. In addition the virtual servers provide a place to apply
afm policies to control traffic.

Create a new virtual server for route domain 0 traffic

Open the Local Traffic -> Virtual Servers page, click Create. Use the
following values, leave all others at their defaults

- Name: ``rd0_vs``
- Type: ``Forwarding (IP)``
- Destination Address: ``172.1.1.0/24``
- Service Port: ``* All Ports``
- Protocols: ``* All Protocols``
- VLANS and Tunnels: ``afm_cp``
- Click **Finished**

|image91|

Create a new virtual server for route domain 1 traffic

Open the Local Traffic -> Virtual Servers page, click Create. Use the
following values, leave all others at their defaults

- Name: ``rd1_vs``
- Type: ``Forwarding (IP)``
- Source Address: ``0.0.0.0%1/0``
- Destination Address: ``172.1.2.0%1/24``
- Service Port: ``* All Ports``
- Protocols: ``* All Protocols``
- VLANS and Tunnels: ``afm_cp``
- Click **Finished**

|image92|

Create the AFM policy for route domain 0 traffic. This limits traffic
through sslvpn to the internal subnet in route domain 0.

Open the Security -> Network Firewall->Active Rules page, click Add. Use
the following values, leave all others at their defaults

- Context: ``Virtual Server, rd0``
- Policy New, Name: ``rd0_afmpolicy``
- Name: ``rd0_denyall_rule``
- Action: ``Reject``
- Logging: ``Enabled``
- Click **Finished**

|image93|

Create the AFM policy for route domain 1 traffic. This limits traffic
through sslvpn to the internal subnet in route domain 1.

Open the Security -> Network Firewall->Active Rules page, click Add. Use
the following values, leave all others at their defaults

- Context: ``Virtual Server, rd1``
- Policy New, Name: ``rd1_afmpolicy``
- Name: ``rd1_denyall_rule``
- Action: ``Reject``
- Logging: ``Enabled``
- Click **Finished**

|image94|

Validate Module 2 Lab 1 Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now its time to test the vpn.

On your jumpstation start the BIG-IP Edge Client which is the grey
ethernet port at the bottom of the desktop.

|image95|

.. NOTE:: Ensure the Edge Client is using server 192.168.1.50, the APM vip. If not use Change Server to select it and Click Connect

|image96|

The Edge Client will inspect your jumpstation to determine the firewall
status, select “Allow this site to inspect for this session only”

|image97|

.. ATTENTION:: Once the Edge Client is connected, go to View Details, which route domain are you in? Why?

.. NOTE:: This completes Module 2 - Lab 1

.. |image65| image:: /_static/class2/image62.png
   :width: 4.64158in
   :height: 3.37569in
.. |image66| image:: /_static/class2/image136.png
   :width: 6.00000in
   :height: 5.85646in
.. |image67| image:: /_static/class2/image64.png
   :width: 5.60895in
   :height: 3.61152in
.. |image68| image:: /_static/class2/image65.png
   :width: 6.00000in
   :height: 3.73611in
.. |image69| image:: /_static/class2/image66.png
   :width: 4.87536in
   :height: 3.64653in
.. |image70| image:: /_static/class2/image67.png
   :width: 5.00858in
   :height: 6.75069in
.. |image71| image:: /_static/class2/image68.png
   :width: 5.38758in
   :height: 0.75763in
.. |image72| image:: /_static/class2/image69.png
   :width: 5.35372in
   :height: 3.95520in
.. |image73| image:: /_static/class2/image70.png
   :width: 5.50419in
   :height: 7.58104in
.. |image74| image:: /_static/class2/image68.png
   :width: 5.38758in
   :height: 0.75763in
.. |image75| image:: /_static/class2/image71.png
   :width: 5.50419in
.. |image76| image:: /_static/class2/image72.png
   :width: 5.50419in
.. |image77| image:: /_static/class2/image73.png
   :width: 7.05000in
   :height: 0.92316in
.. |image78| image:: /_static/class2/image74.png
   :width: 2.91088in
   :height: 0.79236in
.. |image79| image:: /_static/class2/image75.png
   :width: 4.38610in
   :height: 1.06597in
.. |image80| image:: /_static/class2/image76.png
   :width: 5.49755in
   :height: 1.43333in
.. |image81| image:: /_static/class2/image77.png
   :width: 3.40534in
   :height: 1.01389in
.. |image82| image:: /_static/class2/image78.png
   :width: 4.24056in
   :height: 1.51448in
.. |image83| image:: /_static/class2/image79.png
   :width: 4.16906in
   :height: 2.13333in
.. |image84| image:: /_static/class2/image80.png
   :width: 4.34192in
   :height: 3.10903in
.. |image85| image:: /_static/class2/image81.png
   :width: 3.90610in
   :height: 1.86597in
.. |image86| image:: /_static/class2/image82.png
   :width: 4.67794in
   :height: 3.70069in
.. |image87| image:: /_static/class2/image83.png
   :width: 7.05000in
   :height: 1.90385in
.. |image88| image:: /_static/class2/image84.png
   :width: 4.66754in
   :height: 3.26528in
.. |image89| image:: /_static/class2/image85.png
   :width: 6.09340in
   :height: 5.59287in
.. |image90| image:: /_static/class2/image86.png
   :width: 4.72323in
   :height: 2.81241in
.. |image91| image:: /_static/class2/image139.png
   :width: 4.79853in
   :height: 5.60620in
.. |image92| image:: /_static/class2/image140.png
   :width: 5.06591in
   :height: 6.81758in
.. |image93| image:: /_static/class2/image141.png
   :width: 5.14788in
   :height: 7.25486in
.. |image94| image:: /_static/class2/image142.png
   :width: 5.11930in
   :height: 6.63730in
.. |image95| image:: /_static/class2/image143.png
   :width: 4.25278in
   :height: 0.77495in
.. |image96| image:: /_static/class2/image144.png
   :width: 5.50467in
   :height: 2.58403in
.. |image97| image:: /_static/class2/image145.png
   :width: 6.13439in
   :height: 4.05248in
.. |image101| image:: /_static/class2/image94.png