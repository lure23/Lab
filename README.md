# Cloudflare Labs

A testing ground for any CloudFlare technologies.

Note! None of the features may persist. These are only experiments to see things work, and to learn using them!

## Requirements

Intended to be used with the [`web-cf`](https://github.com/akauppi/mp/tree/main/web%2Bcf) Multipass VM. Map the `Lab` folder to `/home/ubuntu/Lab`.

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

Here, the actual IP always works (hint: Command-double click it). 

>Hint: If you want also `localhost:5173` to work like the development happened indeed on the host (which it doesn't), run `./port-fwd.sh` (asks for `sudo` pw). <!--Multipass [has no built-in port forwarding](https://github.com/canonical/multipass/issues/309).-->

## Deployment

Deploying with Cloudflare Pages is simple. Just tie your GitHub account with the service, create a new Pages deployment.

- Build command: `npm run build`
- Root directory: `abc`

In addition, ESLint 9 [requires Node.js >= 18.18.0](https://eslint.org/blog/2024/04/eslint-v9.0.0-released/#node.js-%3C-v18.18.0%2C-v19-no-longer-supported) so:

- `Settings` > `Environment variables`

      >![](.images/cf-node-version.png)
      
   - and same for `Preview`.

Now, your pages get deployed to an URL like `https://lab-4hl.pages.dev` at each new push to `main` (where the build succeeds).



<!--

## References

- [tbd.](...)
-->
