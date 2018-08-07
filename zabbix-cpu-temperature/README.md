# Zabbix CPU温度监测
> zabbix版本3.4.4  系统版本 ubuntu14.04 centos6 

* 自动探测温度传感器
* 如果报告的温度接近传感器最大值，则触发警报。
（两值之间的差异小于10度）
* 温度监控基于sensors工具开发，故需要在agent上面安装lm_sensors

### 1.安装(agentd) 

```
apt-get install lm_sensors  -y
bash config_agent.sh
```

>这里对安装不做过多的解释，看下脚本应该都明白了，若有问题可以用任何方式联系我；

### 2.导入并关联模板(server) 
    Import zabbix-temperature.xml to Zabbix server

### 3.注意事项:
    安装完成后需要重起agent服务


> 特别说明：
文档借鉴于github上面的开源代码
https://github.com/andrey-ivanov/zabbix-temperature
