#!/bin/bash
set -eu

echo "##################################################################################"
echo "## SuiteCRM is ready to get installed ##"
echo "##################################################################################"

chown -R www-data:www-data . && chmod -R 755 . && chmod -R 775 custom modules themes data upload

exec busybox crond -f -l 0 -L /dev/stdout &

exec "$@"
