Detecting and Preventing System DoS and DDoS Attacks
====================================================

With the DoS Protection profile, you can configure settings for DoS protection that you can apply 
to a virtual server, to protect a specific application or server. You can configure the DoS profile 
to provide specific attack prevention at a more granular level than the Device DoS profile. In a 
DoS Profile, you can:

- Configure automatic thresholds for each profile, and for specific DoS vectors, to allow the system to adjust the configuration for DoS attack detection automatically over time.
- Define a source IP address whitelist, to allow legitimate addresses to pass through the DoS protection checks.
- Define settings for DNS protocol error detection, which allows you to configure a percentage rate increase over time and a packets-per-second threshold to trigger logging, as well as a hard rate limit on DNS protocol error packets.
- Define packet-per-second detection-limit, percentage rate increases, and packet-per-second rate limiting for DNS record types.
- Define settings for SIP protocol error detection, which allows you to configure a percentage rate increase over time and a packets-per-second threshold to trigger logging, as well as a hard rate limit on SIP protocol error packets.
- Define specific packet-per-second rate increases, percentage rate increases, and packet-per-second rate limiting for SIP request methods.
- Configure identification, rate limiting, and automatic blacklisting of Bad Actors for supported attack vectors, according to various detection criteria.
- Offload blacklisting of Bad Actor IP addresses to edge routers using BGP.
- Configure identification, rate limiting, and classification of attacked destinations.