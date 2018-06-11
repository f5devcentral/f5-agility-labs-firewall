Service Policies and Timer Policies from BIG-IQ
===============================================

WORKFLOW 2: Service Policies and Timer Policies from BIG-IQ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this lab, you’ll be creating a timer policy in a service policy and
associating the service policy to a firewall rule. This allows you to
control the idle connection time before a connection is removed from the
state table. This control within AFM is a new feature in BIG-IP version
12.0+

**Objective:**

-  Create a Timer Policy

-  Create a Service Policy

-  Associate Service Policy to a firewall rule

-  Deploy to both BIG-IP units

**Lab Requirements:**

-  Web UI access to BIG-IQ

Task 1 – Create a Timer Policy
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

On **BIGIQ1**: (`*https://10.0.0.200)* <about:blank>`__

Navigate to Configuration→ Security → Network Security → Timer Policies.

|image128|

In the left navigation, click on **Timer Policies**.

Click **Create**.

In **Name** field, type *timer\_tcp\_60\_min*.

Click **Rules** tab.

Click **Create Rule** button.

Click the pencil next to the new rule to modify it.

Create the new rule with the below information.

+-------------------------+----------------------------------------------------+-----------------+
| **Name**                | **timer\_rule\_tcp\_60\_min**                      |                 |
+-------------------------+----------------------------------------------------+-----------------+
| **Protocol**            | **tcp**                                            |                 |
+-------------------------+----------------------------------------------------+-----------------+
| **Destination Ports**   | **Port Range**                                     | **1 – 65535**   |
+-------------------------+----------------------------------------------------+-----------------+
| **Idle Timeouts**       | **Specify…**                                       | **3600**        |
+-------------------------+----------------------------------------------------+-----------------+
| **Description**         | **Allow TCP connections to idle for 60 minutes**   |                 |
+-------------------------+----------------------------------------------------+-----------------+

Click the **Save and Close** button at the bottom.

Task 2 – Create a Service Policy
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In the left navigation, click on **Service Policies**.

Click **Create** button.

In the **Name** field, fill in **policy\_timer**.

On the Timer Policy drop down, select **/commom/timer\_tcp\_60\_min**.

On Pin Policy to Device(s), move **bigip1.agility.f5.com**.

Click the **Save and Close** button at the bottom right.

Task 3 – Associate Service Policy to Firewall Rule
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In the left navigation, click on **Rule Lists**.

Select Rule List named **Rule\_List\_Allow\_Trusted**.

Click on rule 1 named **Rule\_Allow\_Trusted** to enter rule
modification mode.

Scroll to the far right.

Under Service Policy field, type in **policy\_timer**.

Click **Save** button at the bottom.

Validate **policy\_timer** is listed under **Service Policy** on the
rule.

|image129|

Click **Save & close** button at the top.

Task 4 – Deploy the Service Policy and related configuration objects
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Now that the desired timer and service policy configuration has been
created on the BIG-IQ, you need to deploy it to the BIG-IP units. In
this task, you create the deployment, verify it, and deploy it.

From the top navigation bar, click on **Deployment**.

Click on the **EVALUATE & DEPLOY** section on the left to expand it.

Click on **Network Security** in the expansion.

Click on the top Create button under Evaluation

Give your evaluation a name (ex: **deploy\_afm2**).

Evaluation **Source** should be **Current Changes** (default).

Source Scope should be **All Changes**

Evaluation **Target** should be **Device**.

Select bigip1.agility.f5.com from the list of Available devices and move
it to Selected.

|image130|

Click the **Create** button at the bottom right of the page.

You should be redirected to the main **Evaluate and Deploy** page.

-  This will start the evaluation process in which BIG-IQ compares its
   working configuration to the configuration active on each BIG-IP.
   This can take a few moments to complete.

-  The **Status** section should be dynamically updating… (What states
   do you see?)

Once the status shows **Evaluation Complete** you can view the
evaluation results.

Before selecting to deploy, feel free to select the differences
indicated to see the proposed deployment changes. This is your check
before actually making changes on a BIG-IP.

Click the number listed under **Differences – Firewall**.

-  Scroll through the list of changes to be deployed.

Click on a few to review in more detail.

|image131|

    What differences do you see from the **Deployed on BIG-IP** section
    and on **BIG-IQ**?

Click **Cancel**.

Deploy your changes by checking the box next to your evaluation
**deploy\_afm2**.

With the box checked, click the **Deploy** button.

-  Your evaluation should move to the **Deployments** section.

-  After deploying, the status should change to **Deployment Complete**.

-  This will take a moment to complete. Once completed, log in to the
   BIG-IP and verify that the changes have been deployed to the AFM
   configuration.

Congratulations, you just deployed your second AFM policy via BIG-IQ!

.. |image128| image:: /_static/class1/image122.png
   :width: 3.53125in
   :height: 6.69792in
.. |image129| image:: /_static/class1/image123.png
   :width: 2.30000in
   :height: 3.20000in
.. |image130| image:: /_static/class1/image124.png
   :width: 5.60000in
   :height: 5.50000in
.. |image131| image:: /_static/class1/image125.png
   :width: 6.48958in
   :height: 3.45833in
