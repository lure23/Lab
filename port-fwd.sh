#!/bin/bash

set -e

# Forward a port of Multipass 'web-cf' VM to 'localhost'
#
# This is ONLY A MATTER OF CONVENIENCE. You can always point the browser to the full {IP}:{PORT}.
#
# Usage:
#   $ [PORT=...] [MP_NAME=...] ./port-fwd.sh
#
# NOTE:
#   This is very similar to 'login-fwd.sh' in 'mp' project. If you make big changes/improvements, please check both.
#     -> https://github.com/akauppi/mp/blob/main/web%2Bcf/login-fwd.sh
#
# References:
#   - "Specify private key in SSH as string" (SO) [1]
#     -> https://stackoverflow.com/questions/12041688/specify-private-key-in-ssh-as-string
#

MP_NAME=${MP_NAME:-web-cf}
PORT=${PORT:-8788}   # 'wrangler pages dev' default port
  # ... other ports

_ID_RSA=/var/root/Library/Application\ Support/multipassd/ssh-keys/id_rsa
_TMP_KEY=.mp.key

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

echo "${_SSH_KEY}" > ${_TMP_KEY}
chmod 600 ${_TMP_KEY}

ssh -ntt -i ${_TMP_KEY} -o StrictHostKeyChecking=accept-new -L ${PORT}:localhost:${PORT} ubuntu@${_MP_IP} > /dev/null &
_PS_TO_KILL=$!

cleanup() {
  kill ${_PS_TO_KILL}
  rm ${_TMP_KEY}
}
trap cleanup EXIT

echo -e "\nSharing port ${PORT}. KEEP THIS TERMINAL RUNNING.\n"
read -rsp $'Press a key to stop the sharing.\n' -n1 KEY

# done