AFM DNS DoS and DDoS Protections Lab
====================================

Lab Requirements:
-----------------

- Internet Connectivity
- Remote Desktop Protocol (RDP) client utility 

.. note:: You may use your web browser for console access if necessary but screen resolution may not be optimal.

Lab Hosts
---------

+----------------+------------------------------+------------------------------------------+
| **Host**       |  **IP Address(es)**          | **Description**                          |
+----------------+------------------------------+------------------------------------------+
| Jump Host      |  - mgmt: 10.1.1.4            | Windows jump host for GUI/CLI access     |
+----------------+------------------------------+------------------------------------------+
| Attack VM      |  - mgmt: 10.1.1.7            | virtual server running Ubuntu with tools |
|                |  - external: 10.1.10.7       | installed to generate requests           |
+----------------+------------------------------+------------------------------------------+
| DNS Server     |  - mgmt: 10.1.1.6            | virtual server running Ubuntu 17.10 with |
|                |  - internal: 10.1.20.6       | BIND9 installed and pre-configured       |
+----------------+------------------------------+------------------------------------------+
| BIG-IP         |  - mgmt: 10.1.1.5            | - BIG-IP v 15.1                          |
|                |  - external: 10.1.10.5       | - Provisioned with LTM, AFM and AVR      |
|                |  - internal: 10.1.20.5       |                                          |
+----------------+------------------------------+------------------------------------------+

Lab Pre-configuration
---------------------

For the lab today, the following items have been completed:

- Victim host BIND9 installation and configuration
- DNS tool installations on the attack host
- basic management/VLAN/self-IP configuration on the BIG-IP
- AFM, LTM and AVR provisioning on the VE
- user credentials on VMs and VE configured

Lab Connectivity
----------------

- While working in the lab, you’ll likely find it easiest to have the BIG-IP web UI open 
  in a browser and an SSH session open to the BIG-IP, the attack host and the victim server. 
- You will be switching between sessions frequently. Within the BIG-IP SSH session, having 
  tail -f /var/log/ltm running helps immensely as you can see attack detection log 
  messages in real-time.

.. tip:: There is a text file on the desktop of the jump host with all of the CLI commands used in the lab for cut/paste use.

Lab Considerations
------------------

- The lab environment has very limited resources, thus you will see very low values for attack detection and mitigation thresholds.
- When viewing logs, there maybe a delay between an action/trigger and the display of logs shown in the UI. Monitoring the BIG-IP LTM logs in the SSH session real-time is helpful for immediate validation. If the UI is not showing logs, re-run the last attack/test and wait for a minute before refreshing the logging/reporting screen.

Click **Next** to continue.