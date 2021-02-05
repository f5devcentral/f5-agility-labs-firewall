Simulating a TCP SYN DDoS Attack
================================

In the last example, we crafted a packet that is easily identified as malicious, as its invalid. We’ll now simulate an attack with traffic that could be normal, acceptable traffic. The TCP SYN flood attack will attempt to DDoS a host by sending valid TCP traffic to a host from multiple source hosts. 

1.	In the BIG-IP web UI, navigate to Security > DoS Protection > Device Configuration > Network Security.
2.	Expand the Flood category in the vectors list.
3.	Click on TCP Syn Flood vector name.
4.	Configure the vector with the following parameters:
a.	State: Mitigate
b.	Threshold Mode: Fully Manual
c.	Detection Threshold EPS: 400
d.	Detection Threshold Percent: 500
e.	Mitigation Threshold EPS: 500

5.	Click Update to save your changes.
6.	Open the BIG-IP SSH session and scroll the ltm log in real time with the following command: tail -f /var/log/ltm
7.	On the attack host, launch the attack by issuing the following command on the BASH prompt: 
sudo hping3 10.20.0.10 --flood --rand-source --destport 80 --syn -d 120 -w 64
8.	After about 60 seconds, stop the flood attack by pressing CTRL + C.
9.	Return to the BIG-IP web UI and navigate to Security > Event Logs > DoS > Network > Events. Observe the log entries showing the details surrounding the attack detection and mitigation.
10.	Navigate to Security > Reporting > DoS > Dashboard to view an overview of the DoS attacks and timeline. You can select filters in the filter pane to highlight the specific attack.
11.	Finally, navigate to Security > Reporting > DoS > Analysis. View detailed statistics around the attack.
 
Click **Next** to continue.