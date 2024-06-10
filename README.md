# Cloudflare Labs

A testing ground for any CloudFlare technologies.

Note! None of the setup may persist. These are only experiments to see things work, and to learn using them!

## Requirements

Intended to be used with the `mp > `[`web+cf`](https://github.com/akauppi/mp/tree/main/web%2Bcf) VM. Map the `Lab` folder to `/home/ubuntu/Lab`.

*Naturally, you can use native `node`, `wrangler` CLI and what-not if you wish.*

<!--developed on:

- macOS 15.1
- Multipass 1.13.1
-->

## Steps

Within VM:

```
$ cd Lab
$ npm install
```

```
$ npm run dev
...
  VITE v5.2.12  ready in 9708 ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: http://192.168.64.102:5173/
  ➜  press h + enter to show help
```

The IP URL works always (Hint: Command-double click it).

>To make also `localhost:5173` work, you need to manually ssh it (Multipass [has no built-in port forwarding](https://github.com/canonical/multipass/issues/309), yet):
>
>```bash
>sudo ssh \
>	-i /var/root/Library/Application\ Support/multipassd/ssh-keys/id_rsa \
>	-L 5173:localhost:5173 \
>	ubuntu@192.168.64.102
>```


## References

- [tbd.](...)

