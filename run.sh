#!/usr/bin/env bash

if [ -z ${email+x} ]; then echo "Fatal: administrator email address must be specified with the environment variable named 'email'"; exit 1; fi
if [ -z ${domains+x} ]; then echo "Fatal: domains must be specified with the environment variable named 'domains'"; exit 1; fi
#if [ -z ${agree_tos+x} ]; then echo "Fatal: agree to the TOS setting the environment variable named 'agree_tos'"; exit 1; fi

IFS=',' read -ra ADDR <<< "$domains"
for domain in "${ADDR[@]}"; do
    letsencrypt certonly --verbose --quiet --standalone --agree-tos --email="${email}" -d "${domain}"
done
