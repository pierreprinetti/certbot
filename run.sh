#!/usr/bin/env bash

echo "Running Certbot for domains: ${domains}"

if [ -z ${email+x} ]; then echo "Fatal: administrator email address must be specified with the environment variable named 'email'"; exit 1; fi
if [ -z ${domains+x} ]; then echo "Fatal: domains must be specified with the environment variable named 'domains'"; exit 1; fi
#if [ -z ${agree_tos+x} ]; then echo "Fatal: agree to the TOS setting the environment variable named 'agree_tos'"; exit 1; fi

letsencrypt certonly --verbose --noninteractive --standalone --agree-tos --email=<${email}> -d "${domains}"
