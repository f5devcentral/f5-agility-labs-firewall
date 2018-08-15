Getting Started
---------------

Please follow the instructions provided by the instructor to start your
lab and access your jump host.

.. NOTE::
	 All work for this lab will be performed exclusively from the Windows
	 jumphost. No installation or interaction with your local system is
	 required.

Lab Topology
~~~~~~~~~~~~

The following components have been included in your lab environment:

- 1 x F5 BIG-IP AFM VE (v13.1.0.6)
- 2 x vyOS routers (v1.1.8)
- 1 x Flowmon Collector (v9.01.04)/DDoS Defender (v4.01.00)
- 1 x Webserver (Ubuntu 16.04)
- 1 x Jumphost (Windows 7)
- 1 x Attacker (Ubuntu 16.04)

Lab Components
^^^^^^^^^^^^^^

The following table lists VLANS, IP Addresses and Credentials for all
components:

.. list-table::
    :widths: 20 40 40
    :header-rows: 1

    * - **Component**
      - **VLAN/IP Address(es)**
      - **Connection Type, Credentials**
    * - Jumphost
      - - **Management:** 10.1.1.199
        - **Users:** 10.1.10.30
        - **Internal:** 10.1.20.30 
        - **Servers:** 10.1.30.30
      - RDP ``external_user``/``P@ssw0rd!``
    * - BIG-IP AFM
      - - **Management:** 10.1.1.7
        - **Internal:** 10.1.20.245
      - TMUI ``admin``/``admin``
    * - Flowmon Collector/DDoS Defender
      - - **Management:** 10.1.1.9
        - **Internal:** 10.1.20.10
      - TMUI ``admin``/``admin``
    * - Router 1
      - - **Management:** 10.1.1.10
        - **Users:** 10.1.10.243
        - **Internal:** 10.1.20.243
      - ssh ``vyos``/``vyos``
    * - Router 2
      - - **Management:** 10.1.1.11
        - **Users:** 10.1.10.244
        - **Internal:** 10.1.20.244
      - ssh ``vyos``/``vyos``
    * - Attacker
      - - **Management:** 10.1.1.4
        - **Users:** 10.1.10.100
      - ssh ``f5admin``/``f5admin``
    * - Webserver
      - - **Management:** 10.1.1.6
        - **Servers:** 10.1.30.252
      - ssh ``f5admin``/``f5admin``
