Managing AFM from BIG-IQ
========================

WORKFLOW 1: Managing AFM from BIG-IQ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this lab, you will create all the components of a firewall policy.
Port lists and address lists are the building blocks of firewall
policies. They can be nested inside of each other to make address and
port management easier, or policies can be created without using the
lists at all. In this example, you’ll use the lists to see how they
work. Once created, you will deploy the configuration to two BIG-IP
units.

**Objective**

-  Create a simple firewall policy and dependent objects (address and
   port list)
-  Deploy new firewall configuration to BIG-IP

**Lab Requirements**

-  Web UI access to BIG-IQ

Task 1 – Create Port List
^^^^^^^^^^^^^^^^^^^^^^^^^

On **BIGIQ1**: (`*https://10.0.0.200)* <about:blank>`__

Navigate to the **Configuration** tab from the top menu of **BIG-IQ**
then to **Security → Network Security**.

|image108|

Click **Port Lists** from the left side navigation menu.

Click the **Create** button.

On the **Propertie**\ s tab, type in **HTTP\_HTTPS** for **Name.**

Click the **Ports** tab.

Create the port list with the below information.

+--------+---------+---------------+
| Type   | Ports   | Description   |
+--------+---------+---------------+
| Port   | 80      | HTTP          |
+--------+---------+---------------+
| Port   | 443     | HTTPS         |
+--------+---------+---------------+

Click on the **+** to add additional ports

|image109|

Click **Save & Close** when finished.

To create a port list via the API, follow the POSTMan Collection
“Service Provider Specialist Event - Lab 5”, using Step 1 – Create New
Port List. It is important to note the value returned within the
self-link as shown below:

|image110|

This value will be assigned to the environment variable AFM\_Port\_ID.

To modify the environment variables, click on the “eye” icon located
in the top right section of POSTMan and select edit. The screen shot
following shows an example of this screen:

|image111|

Task 2 – Create Address List
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Click on the **Address Lists** from the left navigation menu

Click the **Create** button

In Properties, type in **Trusted\_Clients** for Name

The ability to Pin address to a device is also new in 5.2. This feature
allows objects to remain on a device even if they are orphaned and/or
not currently in use in a policy on the “pinned” device.

Click the **Addresses** tab

Create a new address list with the below information

+---------------+------------------+---------------------+
| **Type**      | **Addresses**    | **Description**     |
+---------------+------------------+---------------------+
| **Address**   | 10.128.10.0/24   | Internal Network    |
+---------------+------------------+---------------------+
| **Address**   | 172.16.16.99     | Internal Client 2   |
+---------------+------------------+---------------------+

Click on the **+** to add additional addresses

|image112|

Click **Save and Close** when finished.

To create an address list via the API, follow the POSTMan Collection
“Service Provider Specialist Event - Lab 5”, using Step 2 – Create New
Address List. It is important to note the value returned within the
self-link as shown below:

|image113|

This value will be assigned to the environment variable
AFM\_Address\_ID.

Task 3 – Create Rule List
^^^^^^^^^^^^^^^^^^^^^^^^^

Click on the **Rule Lists** from the left navigation menu.

Click the **Create** button.

On the Properties tab, type in **Rule\_List\_Allow\_Trusted** for Name.

Click the **Rules** tab.

Click **Create Rule** button.

Click on the pencil (edit rule) of the newly created rule listed with
**Id** of **1.**

Create a new rule with the below information.

+---------------------------+--------------------+------------------------+
| **Name**                  |                    | Rule\_Allow\_Trusted   |
+---------------------------+--------------------+------------------------+
| **Source Address**        | **Address List**   | Trusted\_Clients       |
+---------------------------+--------------------+------------------------+
| **Source Port**           | **Port**           | Any                    |
+---------------------------+--------------------+------------------------+
| **Source VLAN**           |                    | Any                    |
+---------------------------+--------------------+------------------------+
| **Destination Address**   | **Address**        | Any                    |
+---------------------------+--------------------+------------------------+
| **Destination Port**      | **Port List**      | HTTP\_HTTPS            |
+---------------------------+--------------------+------------------------+
| **Action**                | **Accept**         | Accept                 |
+---------------------------+--------------------+------------------------+
| **Protocol**              | **TCP**            | TCP                    |
+---------------------------+--------------------+------------------------+
| **State**                 |                    | enabled                |
+---------------------------+--------------------+------------------------+
| **Log**                   |                    | checked                |
+---------------------------+--------------------+------------------------+

|image114|

Click **Save & Close** when finished.

To create a rule list via the API, follow the POSTMan Collection
“Service Provider Specialist Event - Lab 5”, using Step 3 – Create New
Rule. It is important to note the value returned within the self-link as
shown below:

|image115|

This value will be assigned to the environment variable AFM\_Rule\_ID.

To create a rule within the rule list via the API, follow the
POSTMan Collection “Service Provider Specialist Event - Lab 5”,
using Step 4 – Create New Rule List.

Task 4 – Create Firewall Policy
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Click on **Firewall Policies** from the left navigation menu.

Click the **Create** button.

On the Properties tab, type in **Policy\_Forward** for Name.

On Pin Policy to Device(s), move bigip1.agility.f5.com to Selected.

Click the Rules tab.

Click the **Add Rule List** button.

Select the checkbox for **Rule\_Allowed\_Trusted.**

Click **Add** button.

You will see the new policy listed as shown below.

|image116|

Click on drop down arrow to verify our rule within the rule list is
there.

|image117|

Click **Create Rule** button

Click on the pencil (edit rule) of the newly created rule listed with
**Id** of **2.**

Create a new rule with the below information.

+---------------------------+--------------------+--------------------------------+
| **Name**                  |                    | Rule\_Drop\_Everything\_Else   |
+---------------------------+--------------------+--------------------------------+
| **Source Address**        | **Address**        | Any                            |
+---------------------------+--------------------+--------------------------------+
| **Source Port**           | **Port**           | Any                            |
+---------------------------+--------------------+--------------------------------+
| **Source VLAN**           |                    | Any                            |
+---------------------------+--------------------+--------------------------------+
| **Destination Address**   | **Address List**   | Any                            |
+---------------------------+--------------------+--------------------------------+
| **Destination Port**      | **Port List**      | Any                            |
+---------------------------+--------------------+--------------------------------+
| **Action**                |                    | *drop*                         |
+---------------------------+--------------------+--------------------------------+
| **Protocol**              |                    | *any*                          |
+---------------------------+--------------------+--------------------------------+
| **State**                 |                    | *enabled*                      |
+---------------------------+--------------------+--------------------------------+
| **Log**                   |                    | *checked*                      |
+---------------------------+--------------------+--------------------------------+

Click the **Save and Close** button at the top.

You should see the policy with the new rule as shown below.

|image118|

To create a policy via the API, follow the POSTMan Collection “Service
Provider Specialist Event - Lab 5”, using Step 5 – Create New Policy. It
is important to note the value returned within the self-link as shown
below:

|image119|

This value will be assigned to the environment variable AFM\_Policy\_ID.

To reference a rule within the policy via the API, follow the
POSTMan Collection “Service Provider Specialist Event - Lab 5”,
using Step 6 – Create New Rule Reference.

To create a drop rule within the policy via the API, follow the
POSTMan Collection “Service Provider Specialist Event - Lab 5”,
using Step 7 – Create Drop Rule in Policy.
*Task 5 – Assign the Firewall Policy to a Context.*

In this task, you will take the policy you created above and apply
it to a route domain on a BIG-IP. Typically, the route domain you
apply firewall policies to has a wildcard virtual server that you
forward all traffic through (as opposed to a standard single port
virtual server that only allows specific traffic). This type of
configuration is like the more classic firewall deployment.

In the left navigation menu, click **contexts**, then chose 0 for device
bigip1.agility.f5.com

|image120|

From the **Shared Objects** panel at the bottom of the screen, *grab*
the **Policy\_Forward** and *drag* it to the **Enforced Firewall
Policy** shaded area. The policy should then appear in the **Enforced
Firewall Policy** section. Alternatively, delete the existing policy
(Common/rd\_0\_policy) by clicking the x, then select **Add Enforce
Firewall Policy** and select **Policy\_Forward** and click **Add.**

|image121|

Click the **Save & Close** button.

At this point, the policy is assigned to the route domain in the BIG-IQ
configuration, but the configuration has **not** been deployed/pushed to
the BIG-IP units yet.

To assign a policy via the API, follow the POSTMan Collection “Service
Provider Specialist Event - Lab 5”, using Step 8: Get bigip02 Contexts.
This call will list all the firewall contexts using a filter for just
route-domains. You will need to copy the “id” assigned to bigip02
route-domain as exampled by the following:

|image122|

This value will be assigned to the environment variable bigip02-rd0id.

To assign the policy to RD0 via the API, follow the POSTMan
Collection “Service Provider Specialist Event - Lab 5”, using Step
9: Apply Policy to RD0.

Task 6 – Deploy the Firewall Policy and related configuration objects
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Now that the desired firewall configuration has been created on the
BIG-IQ, you need to deploy it to the BIG-IP. In this task, you create
the deployment, verify it, and deploy it.

From the top navigation bar, click on **Deployments**.

Click on the **EVALUATE & DEPLOY** section on the left to expand it.

Click on **Network Security** in the expansion.

|image123|

Click on the top Create button under Evaluations

Give your evaluation a name (ex: **deploy\_afm1**).

Evaluation **Source** should be **Current Changes** (default).

Source Scope should be **All Changes** (default)

Target Device(s) should be **Device**.

Select bigip1.agility.f5.com from the list of Available devices and move
it to Selected.

|image124|

Click the **Create** button at the bottom right of the page.

You should be redirected to the main **Evaluate and Deploy** page.

-  This will start the evaluation process in which BIG-IQ compares its
   working configuration to the configuration active on each BIG-IP.
   This can take a few moments to complete.

The **Status** section should be dynamically updating… (What states do
you see?)

Once the status shows **Evaluation Complete** you can view the
evaluation results.

-  Before selecting to deploy, feel free to select the differences
   indicated to see the proposed deployment changes. This is your check
   before making changes on a BIG-IP.

Click the number listed under **Differences – Firewall**.

Scroll through the list of changes to be deployed.

Click on a few to review in more detail.

|image125|

What differences do you see from the **Deployed on BIG-IP** section
and on **BIG-IQ**?

Click **Cancel**.

Deploy your changes by checking the box next to your evaluation
**deploy\_afm1**.

With the box checked, click the **Deploy** button.

Your evaluation should move to the **Deployments** section.

After deploying, the status should change to **Deployment Complete**.

-  This will take a moment to complete. Once completed, log in to the
   BIG-IP and verify that the changes have been deployed to the AFM
   configuration.

To deploy the changes via the API, follow the POSTMan Collection
“Service Provider Specialist Event - Lab 5”, using Step 10: Deploy
Policy to bigip02. This call will deploy only the changes made to
bigip02

Congratulations, you just deployed your first AFM policy via BIG-IQ!

Review the configuration deployed to the BIG-IP units.

On **BIGIP1**: (`*https://10.0.04)* <about:blank>`__

Navigate to Security > Network Firewall > Policies.

Click on Policy\_Forward.

Are the two rules you created in BIG-IQ listed for this newly deployed
firewall policy?

|image126|

Navigate to Network > Route Domains

Click on route domain 0.

Click on the **Security** tab, click on **Policies** in the drop down.

What policy is deployed to this route domain?

Are the correct firewall rules applied to this route domain from the
policy you associated to it?

|image127|

Test Access to the Wildcard Virtual Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Open a new Web browser and access
   `*http://10.128.10.223:8081* <http://10.128.10.223:8081>`__ (this is
   expected to fail as are some others)

-  Edit the URL to `*https://10.128.10.223* <https://10.128.10.223>`__

-  Edit the URL to `*http://10.128.10.223* <http://10.128.10.223>`__

-  Open either Chrome or Firefox and access
   `*ftp://10.128.10.223* <ftp://10.128.10.223>`__

-  Open Putty and access 10.128.10.223

-  Close all Web browsers and Putty sessions.

.. |image106| image:: /_static/class1/image1.jpg
   :width: 3.27778in
   :height: 1.14444in
.. |image107| image:: /_static/class1/image41.jpg
   :width: 1.95031in
   :height: 1.01251in
.. |image108| image:: /_static/class1/image102.png
   :width: 3.38542in
   :height: 4.42708in
.. |image109| image:: /_static/class1/image103.png
   :width: 6.50000in
   :height: 1.10000in
.. |image110| image:: /_static/class1/image104.png
   :width: 6.50000in
   :height: 2.76042in
.. |image111| image:: /_static/class1/image105.png
   :width: 4.56250in
   :height: 5.16667in
.. |image112| image:: /_static/class1/image106.png
   :width: 6.50000in
   :height: 1.10000in
.. |image113| image:: /_static/class1/image107.png
   :width: 6.50000in
   :height: 2.66667in
.. |image114| image:: /_static/class1/image108.png
   :width: 6.48958in
   :height: 0.67708in
.. |image115| image:: /_static/class1/image109.png
   :width: 6.50000in
   :height: 2.00000in
.. |image116| image:: /_static/class1/image110.png
   :width: 6.48958in
   :height: 3.98958in
.. |image117| image:: /_static/class1/image111.png
   :width: 6.50000in
   :height: 0.87500in
.. |image118| image:: /_static/class1/image112.png
   :width: 6.47917in
   :height: 0.84375in
.. |image119| image:: /_static/class1/image113.png
   :width: 6.50000in
   :height: 2.09375in
.. |image120| image:: /_static/class1/image114.png
   :width: 6.48958in
   :height: 3.20833in
.. |image121| image:: /_static/class1/image115.png
   :width: 6.48958in
   :height: 3.67708in
.. |image122| image:: /_static/class1/image116.png
   :width: 6.81719in
   :height: 1.78363in
.. |image123| image:: /_static/class1/image117.png
   :width: 6.50000in
   :height: 4.09375in
.. |image124| image:: /_static/class1/image118.png
   :width: 6.50000in
   :height: 4.87500in
.. |image125| image:: /_static/class1/image119.png
   :width: 6.70833in
   :height: 3.37500in
.. |image126| image:: /_static/class1/image120.png
   :width: 5.31250in
   :height: 1.65625in
.. |image127| image:: /_static/class1/image121.png
   :width: 4.34028in
   :height: 2.38194in
