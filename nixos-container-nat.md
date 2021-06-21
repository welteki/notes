---
date: 2021-06-20T22:31
---

# Internet access

NAT setup is needed to allow a #[[nixos-containers|NixOS container]] to access the internet.

Add to NixOS configuration:
```
  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "ve-containername" ];
  networking.nat.externalInterface = "interface-name";
```
To allow internet access for all containers set `networking.nat.internalInterfaces = [ "ve-*" ];`
