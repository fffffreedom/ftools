# Tip

## command

> http://docs.ansible.com/ansible/latest/command_module.html  

creates		
A filename or (since 2.0) glob pattern, when it already exists, this step will not be run.  

## tags

给某一些操作打上tag，以便可以指定只运行同一个tag的所有操作。如更新配置文件，只要运行名为config的tag。  

> http://blog.51cto.com/unixman/1674198  

```
tasks:
 
    - yum: name={{ item }} state=installed
      with_items:
         - httpd
         - memcached
      tags:
         - packages
 
    - template: src=templates/src.j2 dest=/etc/foo.conf
      tags:
         - configuration
```

此时若你希望只run其中的某个task，这run 的时候指定tags即可：  

```
ansible-playbook example.yml --tags "configuration,packages"   #run 多个tags
ansible-playbook example.yml --tags packages                   # 只run 一个tag
```

## slurp

> http://docs.ansible.com/ansible/latest/slurp_module.html

用来从远端读取文件。  

## delegate_to

把任务委派给指定的主机上执行：  
```
- name: add host record 
 shell: 'echo "192.168.1.100 test.xyz.com" >> /etc/hosts'
 
- name: add host record to center server 
 shell: 'echo "192.168.1.100 test.xyz.com " >> /etc/hosts'
 delegate_to: 192.168.1.1
```


