Getting Started
---------------

Please follow the instructions provided by the instructor to start your
lab and access your jump host.


Lab Topology
~~~~~~~~~~~~

The following components have been included in your lab environment:

- 1 x BIG-IP VE (v13.x)
- 1 x Linux Box ( Webserver, Syslog, etc )
- 1 x Windows Box ( to generate traffic and test the configuration. )

|image1|



Lab Components
^^^^^^^^^^^^^^

The following table lists VLANS, IP Addresses and Credentials for all
components:

.. list-table::
    :widths: 20 40 40
    :header-rows: 1
    :stub-columns: 1

    * - **Component**
      - **VLAN/IP Address(es)**
      - **Credentials**
    * - Client Subnet
      - - 10.10.99.0/24
      - N/A
    * - Server Subnet
      - - 10.10.121.0/24
      - N/A
    * - Management Subnet
      - - 192.168.3.0/24
      - N/A
    * - Big-IP
      - - **Management IP:** 192.168.3.198
        - **Server Self-IP:** 10.10.121.10
        - **Client Self-IP:** 10.10.99.10
      - ``admin/root``/``Agility1``
    * - Windows Box
      - - **Management Subnet:** 192.168.3.123
        - **Client IP:** 10.10.99.222
      - ``user``/``Agility1``
    * - Linux Box
      - - **Management IP:** 192.168.3.2
        - **Server IP:** 10.10.121.129-132
      - ``ubuntu``/``Agility1``

.. |image1| image:: /_static/class2/diagram.png

