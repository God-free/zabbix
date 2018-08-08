# Mysql Slave 状态监控
> zabbix版本3.4.4  mysql版本5.5.1

> 用来监控mysql slave状态



#### 1.配置mysql监控账户

```
GRANT REPLICATION SLAVE,REPLICATION CLIENT ON *.* TO xxx@'localhost' IDENTIFIED BY 'xxxxxx';
FLUSH PRIVILEGES;
```

#### 2.在/etc/my.cnf 增加以下内容实现免密码,重起mysql进程后生效
```
[mysql]
user=xxx
password=xxxxxx
[mysqladmin]
user=xxx
password=xxxxxx
```


#### 3.zabbix_agent配置
`将mysql_slave.conf 移动到 /usr/local/zabbix/etc/zabbix_agent.conf.d/目录下`

`将check_mysql.sh移动到/usr/local/zabbix/bin/目录下`

```
 #mysql_slave.conf内容注释
 #获取mysql版本
 UserParameter=mysql.version,mysql -V
 #获取mysql性能指标,这个是上面定义好的脚本
 UserParameter=mysql.status[*],/usr/local/zabbix/bin/check_mysql.sh $1
 #获取mysql运行状态
 UserParameter=mysql.ping,mysqladmin ping | grep -c alive
```

```
#记得执行chown chmod命令修改权限
chown zabbix.zabbix /usr/local/zabbix/bin/check_mysql.sh
chmod +x /usr/local/zabbix/bin/check_mysql.sh
```

#### 4.kill process and start it 
fuser -k /usr/local/zabbix/sbin/zabbix_agentd;sleep 1;/usr/local/zabbix/sbin/zabbix_agentd &
