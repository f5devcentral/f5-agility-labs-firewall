About REST resource identifiers
===============================

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

