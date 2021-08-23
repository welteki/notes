---
date: 2020-10-12T00:02
---

# Manage single wildcart domain for multiple sub domains

In certain situation it can be usefull to manage a single wildcart domain certificate for multiple subdomains.

Systems that need to aquire certificates for many domains and would otherwise hit ACME certificate limits could be configured this way.
> If rate limits are not a concern it is better to use a configuration entry per sub domain.

Caddyfile example:
```
*.example.com, example.com {

    @sub1 host sub1.example.com
    handle @sub1 {
	# directives for sub1.example.com...
    }

    @sub2 host sub2.example.com
    handle @sub2 {
	# directives for sub2.example.com...
    }

	# directives for any other host...
}
```

Caddy will fetch a wildcart certificate for `*.example.com` and a regular cert for `example.com` and handle both in the same server block. You can use the `host` matcher to implement per-host handling if you need to, without it fetching a cert for that specific host.

> This topic was heavily discussed in this [issue](https://github.com/caddyserver/caddy/issues/3200)[^solution]

[^solution]: Solution described by [Francis Lavoie](https://github.com/francislavoie) in this [comment](https://github.com/caddyserver/caddy/issues/3200#issuecomment-632987904)
