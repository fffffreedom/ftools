# Tip

## tags

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

