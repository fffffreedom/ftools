# install ansible

```
rpm -Uvh http://mirror.centos.org/centos/7/extras/x86_64/Packages/epel-release-7-9.noarch.rpm

yum install ansible -y
ansible --version

gen key:
ssh-keygen -t rsa
(enter...)

copy public key to all remote host
ansible all -i hosts -m authorized_key -a "user=root key='{{ lookup('file','/root/.ssh/id_rsa.pub') }}'" -k
```
