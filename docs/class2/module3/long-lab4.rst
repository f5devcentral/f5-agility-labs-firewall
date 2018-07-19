Lab 4: Protocol Inspection - Custom Signatures
==============================================

Estimated completion time: 15 minutes

Overview
~~~~~~~~
You can write custom signatures using a subset of the Snort® rules language. We'll walk
through a couple of examples, but the intent is not to make you an expert. At most we can give
you a head start in developing expertise.
We'll start with a scenario: we want to detect sessions requesting a particular URI,
/images/cat.gif where the User-Agent is "Attack-Bot-2000"
When working with signatures, keep in mind there are just under 1600 signatures shipping with
13.1.0. It will be easier to work with custom signatures if you add a filter for them.


Task 1: Set Filter
~~~~~~~~~~~~~~~~~~
1. Edit the Inspection Profile 'my-inspection-profile' Click 'Add Filter' and select 'User Defined' 
2. When the User Defined filter is added, select 'yes'

|image1|

Task 2: Cargo Cult Signature Authoring - finding an example to copy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
It's often more pragmatic to modify an example that is close to what we want than to start from scratch. Let's start with a very simple example. 

From the BIG-IP command line, issue the following command:


grep 1189 /defaults/ips_snort_signatures.txt


**Expected output:**


alert tcp any any -> any any (content:"/rksh"; fast_pattern:only; http_uri; sig_id:1189;)


Parsing this, there is a Header section and an Options section. The Header is the stuff outside the parenthesis:


alert means "match" or "do something." The BIG-IP/AFM Inspection Policy will actually determine what is done with a packet that matches a signature, so it doesn't matter which action you choose. For the greatest clarity, standardize on "alert" so you don't confuse others or yourself.


tcp is the L4 protocol. The Signature has a Protocol setting outside the signature definition. They should probably agree, don't you think?


any any -> any any means "FROM any source IP+port TO any destination IP+port." We will tighten this up in a later lab procedure. Note that the signature has its own direction outside the signature definition. We probably want to avoid a conflict between these direction settings. 


The Options are the elements inside the parenthesis. Each option is a Type: value pair, separated by a colon. Each Option is separated by a semicolon. The options in this example are:

- content - This is the pattern to match, in this case "/rksh."
- fast_pattern - applies to the previous content definition. It's intended to be used to prequalify a rule for further processing. If you have a bunch of expensive content checks, you can look for one characteristic string to see if you need to bother with the others. In this example the effective meaning is "If you see this, look into the other content to see if we match" but there's no other content! The key takeaway is that the rules provided are not optimized. We'll try to do better when we create our own.
- http_uri - also applies to the previous content definition. It restricts the search to the HTTP Uniform Resource Identifier.
- sig_id - the signature id

Task 3: Adapting our example in creating a custom signature
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
We're going to run into a problem that stems from MCPD parsing the contents of /defaults/ips_snort_signatures.txt differently than the UI parses custom signatures.

1. Create a new custom signature. Navigate to Security > Protocol Security > Inspection List and click "New Signature"

|image2|

2. Enter the following:

a.Name - this is an odd field in that it doesn't show up in the
Signatures page but it is the object name in the config. 

Enter "no cat gif"


b. Description - this *does* show up in the Signatures page, Event Logs, tmsh show output, etc. Make it descriptive, systematic, and concise. Enter "HTTP cat.gif request"

c. Signature Definition - here's the big one. Based on our example, enter:

alert tcp any any -> any 80 (content:cat.gif;http_uri; sig_id:100000;)

This simply swaps the content URI string to match and provides a new signature ID. 


d. Click "Create." We expect configuration validation to succeed.

From the Signatures page, open your new signature up for editing to add the rest of the signature elements.


e. Direction: to Server (agreeing with our signature definition)


f. Protocol: TCP (agreeing with our signature definition)


g. Skip to Attack type - "Cat Gifs"


h. Skip to Service - select HTTP


i. Click "Save"

|image3|


3. Add this signature to the Inspection Profile my-inspection-profile


- Navigate to Security > Protocol Security > Inspection Profiles > my-inspectionprofile

- Select your new signature, 100000, and when the "Edit Inspections" window pops open, set "Action" to "Reject" and click "Apply" ("Enable" and Log: Yes are selected by default.)

|catgif3|
|catgif2|

c. Click "Commit Changes to Profile"


4. Test it out.


a. From the Desktop terminal, use the following command:

curl -A test http://10.10.99.40/cat.gif

b. Check stats. From the BIG-IP command line:

tmsh show sec proto profile my-inspection-profile


We expect to see a Hit Count of 1 for Inspection ID 100000. 

|catgif99|

Task 4: A more challenging content check
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In this procedure, we'll create a more complicated signature and run into some obstacles in checking for a particular User-Agent string in the http_header.

Look in the file of provided signatures for User-Agent matches:


grep "User-Agent" /defaults/ips_snort_signatures.txt


We get a lot of matching lines. Let's pick a simple one to create our User-Agent match.
Signature ID 2360 is only a User-Agent match, so let's go with that one.


grep 2360 /defaults/ips_snort_signatures.txt


This returns:


alert tcp any any -> any any (content:"User-Agent: pb|0D 0A|"; fast_pattern:only; http_header; sig_id:2360;)


1. Create a new signature based on signature 2360 as follows: 


a. Name it "User Agent Attack Bot 2000"

b. Description: "User Agent check"

c. Definition: "alert tcp any any -> any 80 (content:"User-Agent: Attack-Bot-2000|0D 0A|";http_header;sig_id:100001;) "
Hint: cut and paste the above. There's a specific lesson in the signature as written.
We are specifying destination TCP port 80. This is more efficient than checking all traffic.
We're just checking the User-Agent, we'll add a URI content check once we get this working.

d. Direction: to-server

e. Protocol: tcp

c. We need to pick a unique sig_id, in the range of 100000+. Choose 100001.

d. Click "Create"

We expect that this won't work.

An error occurred:
"Attack-Bot-2000" unknown property

Looking at the string, there's a space between "User-Agent:" and "Attack-Bot-2000"
Now we know that we can't have that. Good to know.

e. Remove the space, and click "Create." We got a little further, but this will also fail.

An error occurred:
unexpected argument "|"

This is a little trickier. We need to escape the quotation marks. This isn't necessary in
the signatures read in by mcpd from /defaults/ips_snort_signatures.txt, but it is for
custom signatures entered via the UI or tmsh.

f. Escape the content check's quotation marks like this:

content:\"User-Agent:Attack-Bot-2000|0D 0A|\";

and click "Create"

We expect this to work, or at least to pass configuration validation. From the Signatures page, open your new signature up for editing to add the rest of the signature elements.

g. Direction: to Server (agreeing with our signature definitio

k. Click "Save"


2. Add this signature to the Inspection Profile my-inspection-profile

a. Navigate to Security > Protocol Security > Inspection Profiles > my-inspectionprofile

b. Select your new signature, 100001, and when the "Edit Inspections" window pops open, set Action: Reject,and click "Apply" ("Enable", and Log: Yes are selected by default.)

c. Click "Commit Changes to Profile"


3. Test it out.

a. From the Desktop terminal, use the following command:


curl -A Attack-Bot-2000 http://10.12.100.220/index.html


we expect to see the default html page returned.

b. Review results:


tmsh show sec proto profile my-inspection-profile

We don't expect to see any record for signature id 100001. It turns out we have a content string that passes validation but it won't match the request.


4. Fix it. Turns out we need special handling for the ":" I'll cut you some slack and give the results of far too much experimentation. Change the signature definition to:

alert tcp any any -> any 80 (content:\"User-Agent|3A 20|Attack-Bot2000\";http_header;sig_id:100001;)


NOTE: PTG recommends enclosing all content checks in quotation marks, which will all need escaping.


5. Test it out.

a. From the Desktop terminal, use the following command:

curl -A Attack-Bot-2000 http://10.12.100.220/index.html

b. Review:

tmsh show sec proto profile my-inspection-profile

We expect to see an entry for signature id 100001, with Hit Count 1.


Task 5: Order of precedence
~~~~~~~~~~~~~~~~~~~~~~~~~~~
It's worth exploring what happens when two Inspections could potentially match.

1. Compliance Check vs. Signature

a. Enable Compliance Check 11011 Bad HTTP Version, setting the Action to "Reject."

b. Note the current stats for my-inspection-profile from step 8 b in Procedure 2.

c. From the Desktop terminal, use the following command:

telnet 10.12.100.220 80

**Expected response:**

Trying 10.12.100.200...
Connected to 10.12.100.200.
Escape character is '^]'.

**Enter this:**

GET /cat.gif HTTP/4.0


**Expected response:**

Connection closed by foreign host.

d. Check stats. Did the Hit Count increment for 11011 http_bad_version? for 100000 no cat gif ? BEGIN HINT[We expect the Hit Count for 11011 to increment, showing that Compliance Checks are processed first. ]END HINT


2. Signature vs. Signature

What happens when two (or more) Signatures match? Right now you have two custom signatures enabled, one checking for "cat.gif" in the URI, and another checking for UserAgent: "Attack-Bot-2000".


a. From the Desktop terminal, issue the following command:


curl -A Attack-Bot-2000 http://10.12.100.220/cat.gif


b. Check the results.

We expect to see:


curl: (56) Recv failure: Connection reset by peer

Which signature's Hit Counter incremented? We expect 100000's Hit Counter incremented. We also expect to see 100001's Hit Counter incremented.


c. Let's test further. Create three rules:

i. 100005 with a content check for "A" in the URI.
ii. 100006 with a content check for "B" in the URI.
iii. 100007 with a content check for "C" in the URI.


BEGIN HINT[ alert tcp any any -> any 80 (content:\"A\";http_uri;sig_id:100005;)
alert tcp any any -> any 80 (content:\"B\";http_uri;sig_id:100006;)
alert tcp any any -> any 80 (content:\"C\";http_uri;sig_id:100007;)
]END HINT


d. Enable all three rules in the Inspection profile.

e. Test the new signatures. From the Desktop terminal, use the following command:


curl http://10.12.100.220/ABC.html


We expect a 404 response indicating that the request was accepted.


f. Review:


tmsh show sec proto profile my-inspection-profile


We expect to see entries for signature id 100005, id 100006, and id 100007 with Hit Count 1.
Explanation: The Signature Matching engine processes the packet from front to back, and any enabled matching signatures will match.

g. Modify the Inspection profile, and set the action for id 100006 to REJECT.

h. Test the modified Inspection profile. From the Desktop terminal, use the following command:


curl http://10.12.100.220/ABC.html


We expect the connection to be reset.

i. Review:

tmsh show sec proto profile my-inspection-profile

We expect to see Hit Count for signature id 100005 and id 100006 to go up by 1, but id 100007 will stay at Hit Count 1.

Explanation: The Signature Matching engine processes the packet from front to back, and any enabled matching signatures will match UNTIL a Reject action is taken.  

j. Test the new signatures in combination with 100001. From the Desktop terminal, use the following command:


curl -A Attack-Bot-2000 http://10.12.100.220/ABC.html


We expect the connection to be reset.

k. Review:


tmsh show sec proto profile my-inspection-profile


We expect to see Hit Counts increment for 100005 and 100006, but not 100001 or 100007.

Explanation: As before, the Signature Engine processes the packet from front to back. The URI comes before the User-Agent header. Here's a packet capture showing the request: 

|image4|

100006 matches "B" in the URI, it's profile action is "Reject," so we stop processing and do not continue on to look at the User-Agent header.

l. One last check for this section:


curl http://10.12.100.220/AAAAAAAAAA.html

We expect the request to be accepted and a 404 error in response.

m. Review:


tmsh show sec proto profile my-inspection-profile


We expect to see the Hit Count for 100005 to go up by 10.

Explanation: 1000005 matched the URI 10 times. This shows the danger of using
overly simple patterns to match. 

Task 6: Multiple Content Checks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In this procedure, you will add a URI check to 100001 and check the results, just to have a
somewhat more complex custom signature.

1. Edit Signature ID 100001. Add this content check after "http_header": content:cat.gif;http_uri;

BEGIN HINT:[The whole signature definition should read like this: 
alert tcp any any -> any 80 (content:\"User-Agent|3A 20|Attack-Bot-2000\";
http_header;content:cat.gif;http_uri;sig_id:100001;) ]END HINT


2. Disable signature 100000.


3. Send some traffic with the matching User-Agent string, but a different URI. From the Desktop terminal, use this command:


curl -A Attack-Bot-2000 http://10.12.100.220/dog.gif


**Expected output:**

<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>404 Not Found</title>
</head><body>
<h1>Not Found</h1>
<p>The requested URL /dog.gif was not found on this server.</p>
<hr>
<address>Apache/2.2.22 (Ubuntu) Server at 10.12.100.200 Port 80</address>
</body></html>



4. Check the results. We do not expect to see the Hit Count for 100001 increment. The User Agent matches, but the URI does not.

5. Send some traffic with the matching User-Agent string and the matching URI. From the Desktop terminal, use this command:


curl -A Attack-Bot-2000 http://10.12.100.220/cat.gif


**Expected output:**

curl: (56) Recv failure: Connection reset by peer


6. Check the results. We DO expect to see the Hit Count for 100001 increment. 


.. NOTE:: This completes Module 4 - Lab 4

.. |catgif99| image:: /_static/class2/catgif99.png
.. |catgif3| image:: /_static/class2/catgif3.png
.. |catgif2| image:: /_static/class2/catgif2.png
.. |image1| image:: /_static/class2/lab4-image1.png
.. |image2| image:: /_static/class2/lab4-image2.png
.. |image3| image:: /_static/class2/catgif.png
.. |image4| image:: /_static/class2/lab4-image4.png
