Create a Pool and Virtual Server using REST API
===============================================

**About Representational State Transfer**

Representational State Transfer (REST) describes an architectural style
of web services where clients and servers exchange representations of
resources. The REST model defines a resource as a source of information,
and defines a representation as the data that describes the state of a
resource. REST web services use the HTTP protocol to communicate between
a client and a server, specifically by means of the POST, GET, PUT, and
DELETE methods to create, read, update, and delete elements or
collections. In general terms, REST queries resources for the
configuration objects of a BIG-IP® system, and creates, deletes, or
modifies the representations of those configuration objects. The
iControl® REST implementation follows the REST model by:

- Using REST as a resource-based interface, and creating API methods
  based on nouns.
- Employing a stateless protocol and MIME data types, as well astaking advantage
  of the authentication mechanisms and caching built into the HTTP protocol.
- Supporting the JSON format for document encoding.
- Representing the hierarchy of resources and collections with a Uniform
  Resource Identifier (URI) structure.
- Returning HTTP response codes to indicate success or failure of an
  operation.
- Including links in resource references to accommodate discovery.

**About URI format**

The iControl® REST API enables the management of a BIG-IP® device by
using web service requests. A principle of the REST architecture
describes the identification of a resource by means of a Uniform
Resource Identifier (URI). You can specify a URI with a web service
request to create, read, update, or delete some component or module of a
BIG-IP system configuration. In the context of REST architecture, the
system configuration is the representation of a resource. A URI
identifies the name of a web resource; in this case, the URI also
represents the tree structure of modules and components in TMSH.

In iControl REST, the URI structure for all requests includes the string
/mgmt/tm/ to identify the namespace for traffic management. Any
identifiers that follow the endpoint are resource collections.

Tip: Use the default administrative account, admin, for requests to
iControl REST. Once you are familiar with the API, you can create user
accounts for iControl REST users with various permissions.

`https://management-ip/mgmt/tm/module <https://management-ip/mgmt/tm/module>`__

The URI in the previous example designates all of the TMSH subordinate
modules and components in the specified module. iControl REST refers to
this entity as an organizing collection. An organizing collection
contains links to other resources. The management-ip component of the
URI is the fully qualified domain name (FQDN) or IP address of a BIG-IP
device.

Important: iControl REST only supports secure access through HTTPS, so
you must include credentials with each REST call. Use the same
credentials you use for the BIG-IP device manager interface.

For example, use the following URI to access all the components and
subordinate modules in the LTM module:

`https://192.168.25.42/mgmt/tm/ltm <https://192.168.25.42/mgmt/tm/ltm>`__

The URI in the following example designates all of the subordinate
modules and components in the specified sub-module. iControl REST refers
to this entity as a collection; a collection contains resources.

`https://management-ip/mgmt/tm/module/sub-module <https://management-ip/mgmt/tm/module/sub-module>`__

The URI in the following example designates the details of the specified
component. The Traffic Management Shell (TMSH) Reference documents the
hierarchy of modules and components, and identifies details of each
component. iControl REST refers to this entity as a resource. A resource
may contain links to sub-collections.

`https://management-ip/mgmt/tm/module[/sub-module]/component <https://management-ip/mgmt/tm/module%5b/sub-module%5d/component>`__

**About reserved ASCII characters**

To accommodate the BIG-IP® configuration objects that use characters,
which are not part of the unreserved ASCII character set, use a percent
sign (%) and two hexadecimal digits to represent them in a URI. The
unreserved character set consists of: [A - Z] [a - z] [0 - 9] dash (-),
underscore (\_), period (.), and tilde (~).

You must encode any characters that are not part of the unreserved
character set for inclusion in a URI scheme. For example, an IP address
in a non-default route domain that contains a percent sign to indicate
an address in a specific route domain, such as 192.168.25.90%3, should
be encoded to replace the %character with %25.

**About REST resource identifiers**

A URI is the representation of a resource that consists of a protocol,
an address, and a path structure to identify a resource and optional
query parameters. Because the representation of folder and partition
names in TMSH often includes a forward slash (/), URI encoding of folder
and partition names must use a different character to represent a
forward slash in iControl®

To accommodate the forward slash in a resource name, iControl REST maps
the forward slash to a tilde (~) character. When a resource name
includes a forward slash (/) in its name, substitute a tilde (~) for the
forward slash in the path. For example, a resource name, such as
/Common/plist1, should be modified to the format shown here:

https://management-ip/mgmt/tm/security/firewall/port-list/~Common~plist1

**About Postman – REST Client**

Postman helps you be more efficient while working with APIs. Postman is
a scratch-your-own-itch project. The need for it arose while one of the
developers was creating an API for his project. After looking around for
a number of tools, nothing felt just right. The primary features added
initially were a history of sent requests and collections. You can find
Postman here: `www.getpostman.com <http://www.getpostman.com>`__

A PostMAN collection has been created to simplify building the pools and
virtuals necessary for the remainder of this course. The collection is
called “Service Provider Specialist Event – Lab 1a”. You can
sequentially execute all twelve steps by pressing the send button after
clicking on each call.

|image4|

Alternatively, you can run all commands at once using the “Runner”
feature. To use the Runner feature locate the Runner Icon at the top of
POSTMan. Select the appropriate collection and click “Start Test” as
exampled below:

|image5|

Once completed, all the necessary nodes, pools, and virtuals for the lab
will have been created. As a general POSTMan rule, you should close the
tabs you’ve opened when you are finished working with them (after each
section). POSTMan has a known bug and will crash when there are too many
tabs opened at once.

Now let’s test the virtual server to ensure it works. On your
workstation open a browser and enter the address of your virtual servers
that you just created (`*http://10.128.10.223* <http://10.128.10.223>`__
and `*http://10.128.10.224* <http://10.128.10.224>`__). Refresh the
browser screen several times (use “<ctrl>” F5 to ensure you are not
displaying cached objects). Note the ***Server IP address*** should be
alternating between the three destination servers in your pool
(10.128.20.150, 10.128.20.160, 10.128.20.170). The BIG-IP is load
balancing requests in a round-robin fashion.

Go to bigip1.agility.com (10.0.0.4) and view the statistics for the
**wildcard\_vs** virtual server and the **wildcard\_vs\_pool** pool
and its associated members. Go to **Statistics** > **Module
Statistics** > **Local Traffic**. In the **Statistics Type** drop
down item select **Pools**.

|image6|

-  You may also go to **Local Traffic > Pools > Statistics**

   -  Did each pool member receive the same number of connections?

   -  Did each pool member receive approximately the same number of
      bytes?

Try connecting directly to the IP addresses of the servers in the pool
from your browser, and through the virtual server on the BIG-IP and take
note of the Client IP Address on the web page as highlighted below:

|image7|

-  Why does the Source IP address change when going through BIG-IP?

   -  What address is it changing to?

-  Verify that you can connect through the wildcard virtual server using
   various ports:

   -  Edit the URL in your browser to
      `*http://10.128.10.223:8081* <http://10.128.10.223:8081>`__

   -  Edit the URL in your browser to
      `*https://10.128.10.223* <https://10.128.10.223>`__

   -  Edit the URL in your browser to
      `*ftp://10.128.10.223* <ftp://10.128.10.223>`__

      .. NOTE:: There is no need to login, a prompt will eventually be
         displayed.

   -  Open Putty (SSH) and access 10.128.10.223

      .. NOTE:: you do not need to login, getting a prompt is sufficient
         for this test

   -  All of these connections should be successful through the BIG-IP,
      and should be load balanced to the servers in the pool. Since the
      BIG-IP is configured for a wildcard port on the virtual server and
      pool, these connections are allowed through.

   -  Close the Web Browsers and Putty.

.. |image4| image:: /_static/class1/image5.png
   :width: 6.50000in
   :height: 0.55208in
.. |image5| image:: /_static/class1/image6.png
   :width: 6.50000in
   :height: 5.02569in
.. |image6| image:: /_static/class1/image7.png
   :width: 6.49514in
   :height: 1.64583in
.. |image7| image:: /_static/class1/image8.png
   :width: 3.91181in
   :height: 1.96389in

