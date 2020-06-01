About Representational State Transfer
=====================================

Representational State Transfer (REST) describes an architectural style
of web services where clients and servers exchange representations of
resources. The REST model defines a resource as a source of information
and defines a representation as the data that describes the state of a
resource. REST web services use the HTTP protocol to communicate between
a client and a server, specifically by means of the POST, GET, PUT, and
DELETE methods to create, read, update, and delete elements or
collections. In general terms, REST queries resources for the
configuration objects of a BIG-IP® system, and creates, deletes, or
modifies the representations of those configuration objects. The
iControl® REST implementation follows the REST model by:

- Using REST as a resource-based interface, and creating API methods based on nouns.

  - Employing a stateless protocol and MIME data types, as well as taking advantage of the authentication mechanisms and caching built into the HTTP protocol.

- Supporting the JSON format for document encoding.

  - Representing the hierarchy of resources and collections with a Uniform Resource Identifier (URI) structure.
  - Returning HTTP response codes to indicate success or failure of an operation.

- Including links in resource references to accommodate discovery.

