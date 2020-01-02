Advanced Firewall Manager
=========================

Welcome to Initech! Today is your first day as the principal firewall
engineer, congratulations! The employee you are replacing, Milton, is
rumored to be sitting on a beach in Key West sipping Mai Tai’s and took
his red stapler but left no documentation…

The marketing team, now led by Bill Lumbergh, launched a new campaign
for Initech’s TPS reports overnight and no one can access the web
server. The only information the web server administrators know is that
the IP address of the Web server is 10.30.0.50 and that Mr. Lumbergh is
furious the world does not know about the glory of TPS reports!!

Let’s start by testing the web server to verify. On your workstation
open a browser (we prefer you use the Chrome shortcut labeled BIG-IP UI,
all the tabs are pre-populated) and enter the address of the web server
(http://10.1.20.11). No Bueno! Let’s see if we can even ping the host.
Launch a command prompt (startrun cmd) and type ‘ping 10.1.20.11’.
Bueno! Looks like the server is up and responding to pings, as such,
this is likely not a network connectivity issue.

You ask one of your colleagues, who just got out of his meeting with the
Bob’s, if he knows the IP address of the firewall. He recalls the
firewall they would traverse for this communication is
bigip01.f5demo.com and its management IP address is 10.1.1.4. In
your browser, open a new tab  and navigate to https://10.1.1.4. The
credentials to log into the device are username: admin and password:
f5DEMOs4u (these can also be found on the login banner of the device
for convenience). Note if you receive a security warning it is ok to
proceed to the site and add as a trusted site.

F5? F5 makes a data center firewall? Maybe I should do a little reading
about what the F5 firewall is before I proceed deeper into the lab…

