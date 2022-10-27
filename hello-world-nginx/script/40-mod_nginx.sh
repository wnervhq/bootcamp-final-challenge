#!/bin/sh
# vim:sw=2:ts=2:sts=2:et

set -eu

LC_ALL=C
ME=$( basename "$0" )
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
NGINX_CONF=/etc/nginx/nginx.conf

currentNumWorkers=$(grep -oP '(?<=^'worker_processes')[^;]*' ${NGINX_CONF})
if [ ${currentNumWorkers} -eq ${NGINX_SET_WORKERS} ]; then 
    echo "no hay cambios de workers definidos por usuario"
    exit 0
fi

if [ ${NGINX_SET_WORKERS} -eq 0 ]; then 
        echo "se deja la configuracion automatica de workers"
        echo "realizada por el sistema"
    else
        echo "archivo nginx a modificar" 
        echo ${NGINX_CONF}

        sed -i.bak -r 's/^(worker_processes)(.*)$/# Commented out by '"${ME}"' on '"$(date)"'\n#\1\2\n\1 '"${NGINX_SET_WORKERS}"';/' ${NGINX_CONF}

        if [ $? -eq 0 ]; then
                echo "se ha definido de manera estática el siguiente valor de workers en ${NGINX_SET_WORKERS}"
            else
                echo FAIL
        fi
fi