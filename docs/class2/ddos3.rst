Simulating a TCP SYN DDoS Attack
================================

In the last example, we crafted a packet that is easily identified as malicious, as its invalid. We’ll now simulate an attack with traffic that could be normal, acceptable traffic. The TCP SYN flood attack will attempt to DDoS a host by sending valid TCP traffic to a host from multiple source hosts. 

#. In the BIG-IP web UI, navigate to **Security** > **DoS Protection** > **Device Configuration** > **Network Security **.
#. Expand the **Flood** category in the vectors list.
#. Click on **TCP Syn Flood** vector name.
#. Configure the vector with the following parameters:
    - State: Mitigate
    - Threshold Mode: Fully Manual
    - Detection Threshold EPS: 400
    - Detection Threshold Percent: 500
    - Mitigation Threshold EPS: 500
#. Click **Update** to save your changes.
#. Open the BIG-IP SSH session and scroll the ltm log in real time with the following command: ``tail -f /var/log/ltm``
#. On the attack host, launch the attack by issuing the following command on the BASH prompt: ``sudo hping3 10.1.10.6 --flood --rand-source --destport 80 --syn -d 120 -w 64``
#. After about 60 seconds, stop the flood attack by pressing **CTRL+C**.
#. Return to the BIG-IP web UI and navigate to **Security** > **Event Logs** > **DoS** > **Network** > **Events**. Observe the log entries showing the details surrounding the attack detection and mitigation.
10. Navigate to **Security** > **Reporting** > **DoS** > **Dashboard** to view an overview of the DoS attacks and timeline. You can select filters in the filter pane to highlight the specific attack.
11. Finally, navigate to **Security** > **Reporting** > **DoS** > **Analysis**. View detailed statistics around the attack.
 
Click **Next** to continue.