Run an Attack Script against your Virtual Server
================================================

Open an SSH session to the Ubuntu server **10.128.10.250** using Putty
or the command line. Login using the username **root** with the password
**default**.

Once logged in, list the contents of the current directory using the
***ls*** command. You should see a filename similar to
***dos-attack-2xx-commands.txt*** file. This file contains various DoS
attack commands that you will run from the Ubuntu machine you are
currently logged into. It may be easiest to copy the file or its
contents to your local desktop or open another SSH session so you will
have easy access to the commands while you open a program on the Ubuntu
server called ***Scapy*** to run the DDoS commands.

Scapy is a powerful interactive packet manipulation program. It is able
to forge or decode packets of a wide number of protocols, send them on
the wire, capture them, match requests and replies, and much more. It
can easily handle most classical tasks like scanning, tracerouting,
probing, unit tests, attacks or network discovery (it can replace hping,
85% of nmap, arpspoof, arp-sk, arping, tcpdump, tethereal, p0f, etc.).
If you want to learn more about Scapy the link below is provided for
reference:

`*http://www.secdev.org/projects/scapy/* <http://www.secdev.org/projects/scapy/>`__

We will be using Scapy to create specific attacks to launch at your
Virtual Server. We’ll then verify the logging and reporting as well as
attack mitigation of the BIG-IP.

While logged into the Ubuntu server type the following command:
***scapy***

Copy the first attack command for ***Bad IP TTL value***, and then paste
the command in the scapy terminal window and hit enter. You should see
dots move across the screen indicating that the attack is being sent.

|image51|

-  This attack will launch 4000 packets that are configured to send IP
   requests with a TTL value of 0

.. |image51| image:: /_static/class1/image49.png
   :width: 3.62599in
   :height: 2.28716in
