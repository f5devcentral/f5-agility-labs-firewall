BIG-IQ Workflow Overview
========================

**Statistics Dashboards**

This is the real first step managing data statistics using a DCD (data
collection device) evolving toward a true analytics platform. In this
guide, we will explore setting up and establishing connectivity using
master key to each DCD (data collection device).

-  Enabling statistics for each functional area as part of the discovery
   process. This will allow BIG-IQ to proxy statistics gathered and
   organized from each BIG-IP device leveraging F5 Analytics iApp
   service
   (`*https://devcentral.f5.com/codeshare/f5-analytics-iapp* <https://devcentral.f5.com/codeshare/f5-analytics-iapp>`__).

-  Configuration and tuning of statistic collections post discovery
   allowing the user to focus on data specific to their needs.

-  Viewing and interaction with statistics dashboard, such as filtering
   views, differing time spans, selection and drill down into dashboards
   for granular data trends and setting a refresh interval for
   collections.

**SSL Certificate Management**

BIG-IQ 5.2 has introduced the ability to manage SSL certificates. From
creating self-signed certificates to creating a CSR (Certificate Signing
Request) provided to a Certificate Authority when applying for a SSL
Certificate. Some features we will cover in this lab:

-  Importing SSL certificates, key information and PKCS12 “Personal
   Information Exchange Syntax Standard” bundles.

-  When discovering a BIG-IP device, BIG-IQ will import the metadata
   from the certificates discovered. These certificates are unmanaged.
   BIG-IQ provides the ability to move or convert to a fully managed
   certificate by porting SSL certificate source and SSL key properties
   into BIG-IQ.

-  Related to searching to display where SSL certificates are used.

-  Renew an expired self-signed SSL certificate on BIG-IQ.

-  Provide a reference for a SSL certificate / key pair to a Server SSL
   profile.

**Global Search**

BIG-IQ 5.2 has introduced platform wide search that will allow the user
to globally search for any object or object contents and display
related-to objects. Some features we will cover in this lab:

-  Search for specific terms across all of BIG-IQ.

-  Narrow the scope to the search to show “all of an object type”.

-  Selection of an object to drill into an editable page.

-  Search for specific CVE-####-#### in attack signatures documentation
   to find an ASM signature.

**Partial Deployment/Partial Restore**

BIG-IQ 5.2 has introduced the flexibility to deploy or restore selective
changes made:

-  Provides a user the ability to select only changes, out of many, he
   or she wants or is approved to deploy during the evaluation process.

-  As well as the ability to rollback or restore selective changes out
   of multiple staged changes.

**New Server SSL Profiles**

-  Client / Server SSL – Enables BIG-IP to initial secure connections to
   SSL servers using fully SSL-encapsulated protocol.

-  HTTP – This profile will leverage the header contents to define the
   way to manage http traffic through BIG-IP.

-  Universal / Cookie Persistence -

   -  Universal persistence profile. To persist connections based on the
      string. 

   -  Cookie-based session persistence. Cookie persistence directs
      session requests to the same server based on HTTP cookies that the
      BIG-IP system stores in the client’s browser. 

**Public Facing REST API References and HOWTO Guides**

BIG-IQ 5.2 has introduced documentation that will assist the Engineer
when automating central management tasks or providing integration with
orchestration tools using a REST API using HTTPS. In this lab, we will
explore a couple example API Calls and supporting reference and how-to
documents.

-  Device Management – trust, discover, enable statistics and import
   configuration.

-  Add a policy (firewall) to an application – select an existing policy
   and reference to a virtual server.

**Licensing Server**

BIG-IQ 5.1 and 5.2 licensing support for four differing pool models.
Using the base registration key and correct SKU, users can enable and
activate BIG-IP virtual editions of types:

-  Purchased Pools – are purchased once, and you assign them to a number
   of concurrent BIG-IP VE devices, as defined by the license. These
   licenses do not expire. Purchased license pools contain VEP in the
   name of the license.

-  Volume Pools - are prepaid for a fixed number of concurrent devices,
   for a set period of time, but have a number of different license
   offerings available in the pool. Volume license pools contain VLS in
   the name of the license.

-  Utility License Pools – provide the customer the ability to use
   licenses as they need them, and true up with F5 for their actual
   usage. VE licenses can be granted with usage billing at an hourly,
   daily, monthly, or yearly interval. Utility license pools contain
   MSP-LOADV in the name of the license.

-  Registration Key Pools – A pool of single standalone BIG-IP virtual
   edition registration keys, allowing customers to import their
   existing keys and/or import new keys with just the options they
   require.
