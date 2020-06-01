About URI format
================

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

https://management-ip/mgmt/tm/module

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

https://management-ip/mgmt/tm/ltm

The URI in the following example designates all of the subordinate
modules and components in the specified sub-module. iControl REST refers
to this entity as a collection; a collection contains resources.

https://management-ip/mgmt/tm/module/sub-module

The URI in the following example designates the details of the specified
component. The Traffic Management Shell (TMSH) Reference documents the
hierarchy of modules and components, and identifies details of each
component. iControl REST refers to this entity as a resource. A resource
may contain links to sub-collections.

https://management-ip/mgmt/tm/module/[sub-module]/component

