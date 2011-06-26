#!/bin/bash -ex

if [ ! -f /etc/chef/client.pem ]; then
    for x in rabbitmq-server couchdb chef-solr chef-expander chef-server; do
        update-rc.d $x defaults &
        invoke-rc.d $x start &
        wait
        if [ $x == rabbitmq-server ]; then
            rabbitmqctl add_vhost /chef
            rabbitmqctl add_user chef ub3rs3kr4t
            rabbitmqctl set_permissions -p /chef chef ".*" ".*" ".*"
        fi
    done
fi

exit 0
