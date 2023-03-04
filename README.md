# switch-blocker-pihole
Blocks all traffic to Big N's servers via pi-hole and regex
Like [This Repo](https://github.com/buggerman/SwitchBlockerForPiHole), but updated and with additional regex

The goal of this repo is to block every domain mentioned in [list.txt](./list.txt) (taken from [SwitchBrew](https://switchbrew.org/wiki/Network) and [NintendoClients](https://github.com/Kinnay/NintendoClients)) and resolve `ctest` domains to a different ip
you can use [list.txt](./list.txt) as an adlist.


if you want to add regex blocking, note that due to restrictions with pi-hole's regex you can't match every domain except for ones starting with a given prefix (like `ctest`), so you will need to manually whitelist the connection test domains.

The current regex to block all traffic to nintendo servers is: 
```
^([a-z0-9\-]+)[\-lp1|dd1|sp1]?\.hac(\.lp1|dd1|sp1)?\.(dragons|d4c|eshop|shop)\.(nintendo\.net|n\.nintendoswitch\.cn)$|^([a-z0-9\-]+)[\.\-]?(lp1|dd1|sp1)\.([a-z0-9\-\.]+)\.srv\.nintendo\.net$|[a-z0-9\-\.]*\.nintendo\.(com|net)$|^ngs-[a-f0-9]+-live\.s3\.amazonaws\.com$
```

To block all CDN/eShop access:
```
^([a-zA-Z0-9-]+)[-lp1|dd1|sp1]?\.hac(\.lp1|dd1|sp1)?\.(dragons|d4c|eshop|shop)\.(nintendo\.net|n\.nintendoswitch\.cn)$|cdn\.(a-z\.)+?nintendo
```

To block all Service access:
```
^([a-zA-Z0-9-]+)[.-]?(lp1|dd1|sp1)\.([a-zA-Z0-9-.]+)\.srv\.nintendo\.net$|baas\.nintendo\.(com|net)$
```

To block access to Big N completely:
```
nintendo\.(com|net)|n\.nintendoswitch\.cn$
```

To block 3rd party servers:
```
epicgames\.(com|dev)$|sumo-services.co.uk$
```

If you don't have a Pi-Hole and aren't currently using [DNS-MITM](https://github.com/Atmosphere-NX/Atmosphere/blob/master/docs/features/dns_mitm.md), then you can also use that instead. This repo is purely for the paranoid ones (like me).

To test if this regex matches all of the domains in the file, run `test.sh list.txt`, it will check every domain.
Current testing regex:
```
^([a-z0-9\-]+)?[\-lp1|dd1|sp1]?(\.hac)?(\.lp1|dd1|sp1)?\.(dragons|d4c|eshop|shop)\.(nintendo\.net|n\.nintendoswitch\.cn)$|^([a-z0-9\.\-]+\.)?cdn(\.accounts|\.)+nintendo\.(net|com)$|^([a-z0-9\-]+)[\.\-]?(lp1|dd1|sp1)?\.([a-z0-9\-\.]+)\.srv\.nintendo\.(net|com)$|^ngs-[a-f0-9]+-live\.s3\.amazonaws\.com$|baas\.nintendo\.(com|net)$|(accounts|moon|nso|five|mng|op2)\.nintendo\.(com|net)$|epicgames\.(com|dev)|sumo-services.co.uk$
```