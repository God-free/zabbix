# ssl证书过期检测
> zabbix版本3.4.4


###### 1.把https_ssl_cert_check.sh放入zabbix安装目录下的/usr/local/zabbix/bin/
    mv https_ssl_cert_check.sh /usr/local/zabbix/bin/

###### 2.将ssl_cert.conf配置文件放在/usr/local/zabbix/etc/zabbix_agentd.conf.d/目录下  
> 注意：agent的Timeout值配置大一些   

    cat zabbix_agentd.conf.d/ssl_cert.conf
    UserParameter=https_ssl_cert_check_valid[*],/usr/local/zabbix/bin/https_ssl_cert_check.sh valid "$1" "$2"
    UserParameter=https_ssl_cert_check_expire[*],/usr/local/zabbix/bin/https_ssl_cert_check.sh expire "$1" "$2"

###### 3.导入模版Template_SSL_Cert_agent.xml

###### 4.在zabbix server web端添加主机
`1）添加监控主机 ，主机名为需要检测证书的域名`
> ![avatar](/zabbix-ssl_cert-check/1.png)

`2）关联上面导入的模版`
> ![avatar](/zabbix-ssl_cert-check/2.png)
###### 5.在zabbix web界面查看“Monitoring“-”Last data”ssl证书最新数据

---
>Zabbix agent调试命令:
 zabbix_get -s 127.0.0.1 -p 10050 -k https_ssl_cert_check_expire[www.baidu.com,443]