Configuring a DoS Logging Profile
---------------------------------

We’ll create a DoS logging profile so that we can see event logs in the BIG-IP UI during attack mitigation.

1. On the BIG-IP web UI, navigate to **Security** > **Event Logs** > **Logging Profiles** and create a new profile with the following values, leaving unspecified attributes at their default value:
    - **Profile Name**: *dns-dos-profile-logging*
    - **DoS Protection**: *Enabled*
    - **DNS DoS Protection Publisher**: *local-db-publisher*

.. image:: _images/image028.png
  :alt: screenshot

About profiles for DoS and protocol service attacks
---------------------------------------------------

On the BIG-IP® system, you can use different types of profiles to detect and 
protect against system DoS attacks, to rate limit possible attacks, and to 
automatically blacklist IP addresses when identified as Bad Actors. You can 
configure settings for specific protocol attacks for DNS, and other network 
attacks.

With AFM, you can also configure manual responses to DoS vectors. For non-error 
packets, you can specify absolute packet-per-second limits for attack detection 
(reporting and logging), percentage increase thresholds for detection, and 
absolute rate limits on a wide variety of packets that attackers can leverage 
as attack vectors.

Configuring a DoS Profile
-------------------------

We’ll now create a DoS profile with manually configured thresholds to limit the attack’s effect on our server.

1. Navigate to **Security** > **DoS Protection** > **Protection Profiles**. 
2. Create a new DoS profile with the name *dns-dos-profile*.
3. The UI will return to the **DoS Profiles** list. Click the *dns-dos-profile* name.
4. Click the **Protocol Security** tab and select **DNS Security** from the drop-down.
5. Click the *DNS A Query* vector from the **Attack Type** list.
6. Modify the *DNS A Query* vector configuration to match the following values, leaving unspecified attributes with their default value:
     - **State**: *Mitigate*
     - **Threshold Mode**: *Fully Manual*
     - **Detection Threshold EPS**: (Set this at 80% of your safe QPS value)
     - **Mitigation Threshold EPS**: (Set this to your safe QPS value)
7. Make sure that you click **Update** to save your changes.

Attaching a DoS Profile
-----------------------

We’ll attach the DoS profile to the virtual server that we configured to manage DNS traffic.

1. Navigate to **Local Traffic** > **Virtual Servers** > **Virtual Server List**.
2. Click on the *udp_dns_VS* name.
3. Click on the **Security** tab and select **Policies**.
4. In the **DoS Protection Profile** field, select *Enabled* and choose the *dns-dos-profile*.
5. In the **Log Profile**, select *Enabled* and move the *dns-dos-profile-logging* profile from **Available** to **Selected**.
6. Click **Update**.

Click **Next** to continue. 
