Getting Started
===============

Lab Components
--------------

+----------------+-----------------+----------------------------+--------------------+
|  Host          |  OS             |  IP Configuration          | Credentials        |
+----------------+-----------------+----------------------------+--------------------+
|  BIG-IP (AFM)  |  TMOS 15.1.0.4  |  Mgmt: 10.1.1.4/24         |  u: admin          |
|                |                 |  External: 10.1.10.245/24  |  p: f5DEMOs4u      |
|                |                 |  Internal: 10.1.20.245/24  |                    |
|                |                 |  VIP: 10.1.10.30/24        |                    |
+----------------+-----------------+----------------------------+--------------------+
|  LAMP Server   |  Ubuntu 14.04   |  Mgmt: 10.1.1.252/24       |  not required      | 
|                |                 |  Internal: 10.1.20.252/24  |                    |
+----------------+-----------------+----------------------------+--------------------+
|  Jump Host     |  Windows 10     |  Mgmt: 10.1.1.6/24         |  u: external_user  |
|                |                 |  External: 10.1.10.6/24    |  p: P@ssw0rd!      |
+----------------+-----------------+----------------------------+--------------------+

Connection
----------

All tasks in this lab will be performed via Remote Desktop Protocol (RDP) connection to the Jump Host. Log in using the external_user credentials listed above. 

Where possible, you will be automatically logged into devices or credentials will be displayed or documented when you require.

Click **Next** to continue.