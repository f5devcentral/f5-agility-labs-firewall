About reserved ASCII characters
===============================

To accommodate the BIG-IP® configuration objects that use characters,
which are not part of the unreserved ASCII character set, use a percent
sign (%) and two hexadecimal digits to represent them in a URI. The
unreserved character set consists of: [A - Z] [a - z] [0 - 9] dash (-),
underscore (_), period (.), and tilde (~).

You must encode any characters that are not part of the unreserved
character set for inclusion in a URI scheme. For example, an IP address
in a non-default route domain that contains a percent sign to indicate
an address in a specific route domain, such as 192.168.25.90%3, should
be encoded to replace the %character with %25.