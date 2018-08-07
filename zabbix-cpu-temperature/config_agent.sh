#!/bin/bash
#install zabbix_agentd
if [ $(id --user) -ne 0 ]; then
  echo "This script should be run using sudo or as the root user"
  exit 1
fi

install --group=zabbix --mode=750 -D -t /usr/local/bin/ zabbix-temperature.sh &&
install --group=zabbix --mode=640 -t /usr/local/zabbix/etc/zabbix_agentd.conf.d etc/zabbix/zabbix_agentd.conf.d/temperature.conf &&
echo  "please restart zabbix-agent"

#
#systemctl restart zabbix-agent


