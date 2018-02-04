# expect

> https://segmentfault.com/a/1190000012194543  

## expect
expect的核心是spawn、expect、send、set。

## spawn 调用要执行的命令
expect 等待命令提示信息的出现，也就是捕捉用户输入的提示：  
send 发送需要交互的值，替代了用户手动输入内容  
set 设置变量值  
interact 执行完成后保持交互状态，把控制权交给控制台，这个时候就可以手工操作了。如果没有这一句登录完成后会退出，而不是留在远程终端上。  
expect eof 这个一定要加，与spawn对应表示捕获终端输出信息终止，类似于if....endif  

**expect脚本必须以interact或expect eof结束，执行自动化任务通常expect eof就够了。**  

## 其他设置
设置expect永不超时 set timeout -1
设置expect 300秒超时，如果超过300没有expect内容出现，则退出 set timeout 300

## expect编写语法

> expect使用的是tcl语法  

- 一条Tcl命令由空格分割的单词组成. 其中, 第一个单词是命令名称, 其余的是命令参数：  
cmd arg arg arg  
- $符号代表变量的值. 在本例中, 变量名称是foo. 
$foo
- 方括号执行了一个嵌套命令. 例如, 如果你想传递一个命令的结果作为另外一个命令的参数, 那么你使用这个符号
[cmd arg]
- 双引号把词组标记为命令的一个参数. "$"符号和方括号在双引号内仍被解释
"some stuff"
- 大括号也把词组标记为命令的一个参数. 但是, 其他符号在大括号内不被解释
{some stuff}
- 反斜线符号是用来引用特殊符号. 例如：n 代表换行. 反斜线符号也被用来关闭"$"符号, 引号,方括号和大括号的特殊含义

## 拷贝ssh的公钥到指定host

```
#!/usr/bin/expect

set hostip [lindex $argv 0]
set username [lindex $argv 1]
set passwd [lindex $argv 2]

#print to screen
#send_user "$hostip $username $passwd"

spawn ssh-copy-id -i /root/.ssh/id_rsa.pub $username@$hostip

expect {
        "continue" { send "yes\n"; exp_continue }
        "assword:" { send "$passwd\n"; }
}

expect eof
```
```
#!/bin/bash

file="../hosts"

# http://blog.csdn.net/kongshuai19900505/article/details/78144019
check_ipaddr()  
{
    echo $1|grep "^[0-9]\{1,3\}\.\([0-9]\{1,3\}\.\)\{2\}[0-9]\{1,3\}$" > /dev/null;
    if [ $? -ne 0 ]
    then
        #echo "IP地址必须全部为数字"   
        return 1
    fi
    ipaddr=$1
    a=`echo $ipaddr|awk -F . '{print $1}'`
    b=`echo $ipaddr|awk -F . '{print $2}'`
    c=`echo $ipaddr|awk -F . '{print $3}'`
    d=`echo $ipaddr|awk -F . '{print $4}'`
    for num in $a $b $c $d
    do
        if [ $num -gt 255 ] || [ $num -lt 0 ]
        then
            return 1
        fi
    done

    return 0
}

while read -r line
do
    printf '%s\n' "$line"
    check_ipaddr $line
    if [ $? == 0 ]
    then
        ./auto-copy.sh $line root PASSWORD
    else
        echo "==> login $line fail"
    fi
done <"$file"

exit 0
```
## 登录登出
```
#!/usr/bin/expect -f    
#
# Install RSA SSH KEY with no passphrase
#

set hostip [lindex $argv 0]
set username [lindex $argv 1]
set passwd [lindex $argv 2]

#print to screen
#send_user "$hostip $username $passwd"

spawn ssh $username@$hostip

expect {
        "continue" { send "yes\n"; exp_continue }
        "assword:" { send "$passwd\n"; }
        "#" { send "exit\n"; }
}

expect eof
```
```
#!/bin/bash

file="../hosts"

hname=""

check_ipaddr()  
{
    echo $1|grep "^[0-9]\{1,3\}\.\([0-9]\{1,3\}\.\)\{2\}[0-9]\{1,3\}$" > /dev/null;
    if [ $? -ne 0 ]
    then
        #echo "IP地址必须全部为数字"   
        return 1
    fi
    ipaddr=$1
    a=`echo $ipaddr|awk -F . '{print $1}'`
    b=`echo $ipaddr|awk -F . '{print $2}'`
    c=`echo $ipaddr|awk -F . '{print $3}'`
    d=`echo $ipaddr|awk -F . '{print $4}'`
    for num in $a $b $c $d
    do
        if [ $num -gt 255 ] || [ $num -lt 0 ]
        then
            return 1
        fi
    done

    hname=ceph-node-$a-$b-$c-$d

    return 0
}

while read -r line
do
    printf '%s\n' "$line"
    check_ipaddr $line
    if [ $? == 0 ]
    then
        ./auto-login.sh $hname root PASSWORD
    fi
done <"$file"

exit 0

```
