#!/usr/bin/env bash

echo "Running Certbot for domains: ${domains}"

letsencrypt certonly --verbose --noninteractive -d "${domains}"
