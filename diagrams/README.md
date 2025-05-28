This Mermaid diagram illustrates the critical depth needed in modern asset management. It shows how a single physical or virtual asset can host multiple applications, each with numerous dependencies and libraries - and how vulnerabilities can exist at any level.
The diagram demonstrates why traditional asset management (just tracking "Server A exists") is insufficient. Modern threats and compliance requirements demand visibility into:

Asset Layer (blue): Physical servers, VMs, containers, cloud instances\
Application Layer (purple): The software running on those assets\
Library/Package Layer (green): The dependencies those applications rely on\
Vulnerability Layer (red): Security issues that can exist at any level

This comprehensive view is essential because:

A vulnerability in a deep dependency (like OpenSSL) can affect multiple applications across multiple assets\
Supply chain attacks often target popular libraries used by many applications\
Compliance frameworks increasingly require software bill of materials (SBOM) tracking\
Incident response needs to quickly identify all affected systems when a vulnerability is disclosed

The diagram shows how a security issue in something as fundamental as urllib3 or OpenSSL can have far-reaching impacts across your entire infrastructure, making this multi-layered asset management approach a business necessity rather than just good practice.

STIG's and other system hardening and application hardening guides would get you through the top half.\
The bottom half requires code scanners and SBOM generation, you can just pull from a vendor that secures open source.
