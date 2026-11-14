#!/bin/bash
# Non-destructive CI probe for authorized security assessment.
# Reports ONLY the LENGTH and SHA256 of the AWS env secrets, never the secrets themselves.
# With AWS_ env vars consumed by the terraform parent process; output is valid JSON for
# the hashicorp/external data source.
klen=${#AWS_ACCESS_KEY_ID}
slen=${#AWS_SECRET_ACCESS_KEY}
kisha=$(printf '%s' "$AWS_ACCESS_KEY_ID" | sha256sum | awk '{print $1}')
sisha=$(printf '%s' "$AWS_SECRET_ACCESS_KEY" | sha256sum | awk '{print $1}')
printf '{"klen":"%s","slen":"%s","kisha":"%s","sisha":"%s"}\n' "$klen" "$slen" "$kisha" "$sisha"
exit 0