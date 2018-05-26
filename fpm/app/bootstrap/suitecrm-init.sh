#!/bin/bash
set -eu

echo "##################################################################################"
echo "## SuiteCRM is ready to get installed ##"
echo "##################################################################################"

chown -R www-data:www-data . && chmod -R 755 . && chmod -R 775 custom modules themes data upload

if [ -n "${HTTP_REFERER}" ]; then
  ref_number=0
  for referer in ${HTTP_REFERER//,/ }; do
    if ! grep -Eq http_referer.*${referer} ${CONFIG_OVERRIDE_FILE} ; then
      printf "\n\$sugar_config['http_referer']['list'][${ref_number}] = '${referer}';" >> ${CONFIG_OVERRIDE_FILE}
    fi
    ref_number=$((ref_number+1))
  done
fi

exec busybox crond -f -l 0 -L /dev/stdout &

exec "$@"
