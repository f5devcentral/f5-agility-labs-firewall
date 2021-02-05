Preventing Global DoS Sweep and Flood Attacks
=============================================

DoS Protection profile
---------------------

In the last section, the focus was on attacks originating from various hosts. In this section, we will 
focus on mitigating flood and sweep attacks from a single host. 

Single Endpoint Sweep
---------------------

The single endpoint sweep is an attempt for an attacker to send traffic across a range of ports on the target server, typically to scan for open ports.

#. In the BIG-IP web UI, navigate to **Security** > **DoS Protection** > **Device Configuration** > **Network Security**.
#. Expand the **Single-Endpoint** category in the vectors list.
#. Click on **Single Endpoint Sweep** vector name.
#. Configure the vector with the following parameters:
    - **State**: *Mitigate*
    - **Threshold Mode**: *Fully Manual*
    - **Detection Threshold EPS**: *150*
    - **Mitigation Threshold EPS**: *200*
    - **Add Source Address to Category**: *Checked*
    - **Category Name**: *denial_of_service*
    - **Sustained Attack Detection Time**: *10 seconds*
    - **Category Duration Time**: *60 seconds*
    - **Packet Type**: *Move All IPv4 to Selected*
#. Click **Update** to save your changes.
#. Navigate to **Security** > **Network Firewall** > **IP Intelligence** > **Policies**.
#. In the **Global Policy** section, change the **IP Intelligence Policy** to *ip-intelligence*.
#. Click **Update**.
#. Click on the *ip-intelligence* policy in the policy list below.
#. Create a new **Blacklist Matching Policy** in the **IP Intelligence Policy Properties** section with the following attributes, leaving unspecified attributes with their default values:
   - **Blacklist Category**: *denial-of-service*
   - **Action**: *drop*
   - **Log Blacklist Category Matches**: *Yes*
#. Click **Add** to add the new **Blacklist Matching Policy**. 
#. Click **Update** to save changes to the *ip-intelligence* policy.
#. Open the BIG-IP SSH session and scroll the ltm log in real time with the following command: 
    - ``tail -f /var/log/ltm``
#. On the victim server, start a packet capture with an SSH filter by issuing 
    - ``sudo tcpdump -nn not port 22``
#. On the attack host, launch the attack by issuing the following command on the BASH prompt: 
    - ``sudo hping3 10.1.10.6 --flood --scan 1-65535 -d 128 -w 64 --syn``
#. You will see the scan find a few open ports on the server, and the server will show the inbound sweep traffic. However, you will notice that the traffic to the server stops after a short time (10 seconds, the configured sustained attack detection time.) Leave the test running.
#. After approximately 60 seconds, sweep traffic will return to the host. This is because the IP Intelligence categorization of the attack host has expired. After 10 seconds of traffic, the bad actor is again blacklisted for another 60 seconds. 
#. Stop the sweep attack on the attack host by pressing **CTRL+C**.
#. Return to the BIG-IP web UI and navigate to **Security** > **Event Logs** > **DoS** > **Network** > **Events**. Observe the log entries showing the details surrounding the attack detection and mitigation.
#. Navigate to **Security** > **Event Logs** > **Network** > **IP Intelligence**. Observe the log entries showing the mitigation of the sweep attack via the ip-intelligence policy.
#. Navigate to **Security** > **Event Logs** > **Network** > **Shun**. Observe the log entries showing the blacklist adds and deletes.
#. Navigate to **Security** > **Reporting** > **Network** > **IP Intelligence**. Observe the statistics showing the sweep attack and mitigation. Change the View By drop-down to view the varying statistics.
#. Navigate to **Security** > **Reporting** > **DoS** > **Dashboard** to view an overview of the DoS attacks and timeline. You can select filters in the filter pane to highlight the specific attack.
#. Finally, navigate to **Security** > **Reporting** > **DoS** > **Analysis**. View detailed statistics around the attack.

Click **Next** to continue.