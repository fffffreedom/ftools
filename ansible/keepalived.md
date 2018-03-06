# keepalived

## main.yml

```
---

- name: Install keepalived
  yum: name=keepalived
  tags: install

- name: update check haproxy script
  copy: src=check_haproxy.sh dest=/etc/keepalived/check_haproxy.sh
  mode: 0755
  notify:
    - reload systemd
    - keepalived restart service
  tags: configure

- name: update keepalived config
  template: src=keepalived.conf dest=/etc/keepalived/keepalived.conf
  notify:
    - reload systemd
    - keepalived restart service
  tags: configure

# notify will trigger handler
#- name: reload systemd
#  command: systemctl daemon-reload
#
#- name: Start keepalived
#  service: name=keepalived state=started
#  tags: configure

- name: Enable keepalived
  service: name=keepalived enabled=yes
```

其中，check_haproxy.sh  
```
#!/bin/bash

for (( count=0; count<3; count++));
do
        systemctl status haproxy > /dev/null 2>&1
        if [ $? -eq 0 ]
        then
                exit 0
        fi
done
systemctl stop keepalived
exit 1
```

## handlers

```
---
- name: reload systemd
  command: systemctl daemon-reload

- name: keepalived restart service
  service: name=keepalived state=restarted
```

## templates

```
global_defs {
   notification_email {
     xxxxxxxxxx
   }
   notification_email_from xxxxxxxxxx
   smtp_server xxxxxxxxxx
   smtp_connect_timeout 30
   router_id LVS_HAPROXY
}

vrrp_script chk_haproxy {
    script "/etc/keepalived/check_haproxy.sh"
    interval 5
}

vrrp_instance VI {
   interface {{ kube_keepalived_interface }}
   state MASTER
   virtual_router_id {{ kube_keepalived_vid }}
   priority {{ inventory_hostname|replace(".", "") }}
   virtual_ipaddress {
       {{ kube_vip }}
   }
   authentication {
       auth_pass {{ kube_auth_pass }}
   }
   track_script {
       chk_haproxy
   }
}
```
