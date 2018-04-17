# setup ansible env

## installation

```
install ansible
rpm -Uvh http://mirror.centos.org/centos/7/extras/x86_64/Packages/epel-release-7-9.noarch.rpm

yum install ansible -y
ansible --version
```

## configuration

### config
```
[defaults]
hostfile = hosts
remote_user = root
private_key_file = /root/.ssh/id_rsa
host_key_checking = False
deprecation_warnings = False
```

### generate ssh key

```
gen key:
ssh-keygen -t rsa
(enter...)
```

### copy public key to all remote host

```
ansible all -i hosts -m authorized_key -a "user=root key='{{ lookup('file','/root/.ssh/id_rsa.pub') }}'" -k
```

## hosts

```
[local]
local-host-ip
```

## playbook

```
- hosts: local
  vars:
    Sta: true
    User: [ "Aheahe","yunzhonghe" ]
  tasks:
  - name: Standard Loops
    debug: msg="{{ item.name }},{{ item.fun }}"
    with_items:
     - { name: Loops, fun: xx }
     - { name: Conditional, fun: yy }
    when: Sta
  - name: Nested Loops
    debug: msg="name={{ item[0] }},priv={{ item[1] }}"
    with_nested:
     - "{{ User }}"
     - [ "Student","Engineer","Friends" ]
```

## RUN

```
ansible-playbook test.yml
```
