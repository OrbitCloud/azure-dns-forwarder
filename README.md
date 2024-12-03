# Azure DNS Forwarder Container

![Build](https://img.shields.io/github/actions/workflow/status/orbitcloud/azure-dns-forwarder/build.yml)
![Dependabot](https://badgen.net/github/dependabot/orbitcloud/azure-dns-forwarder)

A lightweight, containerized DNS forwarder designed for use in Azure environments.
Enables DNS resolution for Private Link DNS zones and internal Azure resources
from external networks connected via VPN, ExpressRoute, or VNet Peering.

## Overview

- Lightweight/minimal Alpine & dnsmasq based container
- Forwards DNS queries to Azure's Internal DNS server
- Ideal for P2S & S2S VPN, ExpressRoute, or other network peering scenarios when
Azure's DNS server is not reachable from external clients
- Deploy as Azure Container App, Container Instance or Kubernetes Service

## Usage

### Published image

```text
ghcr.io/orbitcloud/azure-dns-forwarder:latest
```

### Test locally

You can test the container locally providing a public DNS server as an argument
which will be used as the upstream DNS server for the forwarder instead of
Azure's internal DNS server.

```bash
# Run the DNS forwarder on port 8053
docker run -d -p 8053:53/udp ghcr.io/orbitcloud/azure-dns-forwarder:latest 1.1.1.1

# Test the forwarder
dig @localhost -p 8053 microsoft.com
```

## Good to know

- The container exposes `dnsmasq` on port `53/udp`
- Your application runtime of choice should have a private subnet integration
to an Azure VNet which can reach Azure's internal DNS server (`168.63.129.16`)
- Make sure the private DNS zones you want to resolve are linked to the VNet
- Requires configuring DNS server settings for downstream clients

## Configuring Azure VPN Client to use the DNS Forwarder

For configuring the Azure VPN client to use the DNS forwarder, edit the `AzureVpnProfile.xml` file and add the `<dnsservers>` configuration under
the `<clientconfig>`section. Replace `[YOUR-INSTANCE-IP]` with the IP address of your deployed DNS forwarder instance.

```xml
<AzVpnProfile>
    ...
    <clientconfig>
        <dnsservers>
            <dnsserver>[YOUR-INSTANCE-IP]</dnsserver>
        </dnsservers>
    </clientconfig>
    ...
</AzVpnProfile>
```

## Disclaimer

This project is not affiliated with Microsoft or Azure. Use at your own risk.
