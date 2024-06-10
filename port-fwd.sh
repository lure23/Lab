#!/bin/bash

set -e

# Forward the port 5173 of Multipass 'web-cf' VM to 'localhost:5173'
#
# This is ONLY A MATTER OF CONVENIENCE. You can always point the browser to the full {IP}:5173.
#
# Usage:
#   $ [MP_NAME=...] [PORT=...] port-fwd.sh
#
# References:
#   - "Specify private key in SSH as string" (SO) [1]
#     -> https://stackoverflow.com/questions/12041688/specify-private-key-in-ssh-as-string
#

MP_NAME=${MP_NAME:-web-cf}
PORT=5173   # SvelteKit default port

_ID_RSA=/var/root/Library/Application\ Support/multipassd/ssh-keys/id_rsa

# Pick the IP
_MP_IP=$(multipass info $MP_NAME | grep IPv4 | cut -w -f 2 )

cat <<EOL1
*
* Going to forward the port '${_MP_IP}:${PORT}' as 'localhost:${PORT}'.
*
* This will require a 'sudo' pw next, to read a Multipass ssh key.
*
EOL1
read -rsp $'Press a key to continue...\n' -n1 KEY

# Note: asking 'sudo' only for reading the Multipass private key (not for running 'ssh').
#
# Security: Placing a plain-text private key in a variable doesn't seem a big problem to the author, though [1]
#   warns against it. For the first, these are only internal keys between the host and the VM. For the second, they
#   shouldn't stick in history, since not executed from command prompt. Right?  (let me know if there's a concern!)
#
# Note 2: Need to use 'sh -c' (over plain 'sudo cat') because of a space in the path name.
#
_SSH_KEY=$(sudo sh -c "cat \"${_ID_RSA}\"")

# We can now - for the rest of the host user session(!) 'ssh' to the VM without needing to provide the key.
#
ssh -ntt -i /dev/stdin -L ${PORT}:localhost:${PORT} ubuntu@${_MP_IP} <<< "${_SSH_KEY}" > /dev/null &
_PS_TO_KILL=$!

echo -e "\nSharing port ${PORT}. KEEP THIS TERMINAL RUNNING.\n"
read -rsp $'Press a key to stop the sharing.\n' -n1 KEY

kill ${_PS_TO_KILL}
