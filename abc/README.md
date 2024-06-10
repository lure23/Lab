# SvelteKit / CloudFlare

## Requirements

### Wrangler CLI

We have `wrangler` as a project dependency, but it's good if you do the login before working with the project.

```
$ npm install -g wrangler
   
$ wrangler login
[...]
   
$ wrangler whoami
[...]
```
   
>**Multipass note**:
>
>For the login, you will need to somehow bind the `:8976` of the VM to the host. Here's one such way:
>   
>```
>$ sudo ssh -i /var/root/Library/Application\ Support/multipassd/ssh-keys/id_rsa -L 8976:localhost:8976 ubuntu@192.168.64.92
>```
	

## Steps

```
$ npm install
```

tbd.

```
$ npm run dev
```

tbd.

```
$ npm run preview
```

tbd.

<!--
## References
-->
