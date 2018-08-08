#!/bin/bash
# -------------------------------------------------------------------------------
# FileName:    check_mysql.sh

MYSQL_CONN="/usr/bin/mysqladmin"

# 参数是否正确
if [ $# -ne "1" ];then
    echo "arg error!"
fi

# 获取数据
case $1 in
    Uptime)
        result=`${MYSQL_CONN} status|cut -f2 -d":"|cut -f1 -d"T"`
        echo $result
        ;;
    Com_update)
        result=`${MYSQL_CONN} extended-status |grep -w "Com_update"|cut -d"|" -f3`
        echo $result
        ;;
    Slow_queries)
        result=`${MYSQL_CONN} status |cut -f5 -d":"|cut -f1 -d"O"`
        echo $result
        ;;
    Com_select)
        result=`${MYSQL_CONN} extended-status |grep -w "Com_select"|cut -d"|" -f3`
        echo $result
                ;;
    Com_rollback)
        result=`${MYSQL_CONN} extended-status |grep -w "Com_rollback"|cut -d"|" -f3`
                echo $result
                ;;
    Questions)
        result=`${MYSQL_CONN} status|cut -f4 -d":"|cut -f1 -d"S"`
                echo $result
                ;;
    Com_insert)
        result=`${MYSQL_CONN} extended-status |grep -w "Com_insert"|cut -d"|" -f3`
                echo $result
                ;;
    Com_delete)
        result=`${MYSQL_CONN} extended-status |grep -w "Com_delete"|cut -d"|" -f3`
                echo $result
                ;;
    Com_commit)
        result=`${MYSQL_CONN} extended-status |grep -w "Com_commit"|cut -d"|" -f3`
                echo $result
                ;;
    Bytes_sent)
        result=`${MYSQL_CONN} extended-status |grep -w "Bytes_sent" |cut -d"|" -f3`
                echo $result
                ;;
    Bytes_received)
        result=`${MYSQL_CONN} extended-status |grep -w "Bytes_received" |cut -d"|" -f3`
                echo $result
                ;;
    Com_begin)
        result=`${MYSQL_CONN} extended-status |grep -w "Com_begin"|cut -d"|" -f3`
                echo $result
                ;;
    Slave)
#        result=`${MYSQL_CONN} extended-status |grep -w "Com_begin"|cut -d"|" -f3`
#                echo $result
        array=(`/usr/bin/mysql -e "show slave status\G"|grep "Running" |awk '{print $2}'`)
        if [ "${array[0]}" == "Yes" ] && [ "${array[1]}" == "Yes" ]
              then
                 echo 0
              else
                 echo 1
        fi

                ;;

        *)
        echo "Usage:$0(Uptime|Com_update|Slow_queries|Com_select|Com_rollback|Questions|Com_insert|Com_delete|Com_commit|Bytes_sent|Bytes_received|Com_begin|Slave)"
        ;;
esac

