# haproxy

## tasks

```
---

- name: Install haproxy
  yum: name=haproxy
  tags: install

- name: update haproxy config
  template: src=haproxy.cfg dest=/etc/haproxy/haproxy.cfg
  notify:
    - reload systemd
    - haproxy restart service
  tags: configure

- name: reload systemd
  command: systemctl daemon-reload

- name: Start haproxy
  service: name=haproxy state=started
  tags: configure

- name: Enable haproxy
  service: name=haproxy enabled=yes
```

## handlers

```
---
- name: reload systemd
  command: systemctl daemon-reload

- name: haproxy restart service
  service: name=haproxy state=restarted
```

## templates

```
#---------------------------------------------------------------------
# Example configuration for a possible web application.  See the
# full configuration options online.
#
#   http://haproxy.1wt.eu/download/1.4/doc/configuration.txt
#
#---------------------------------------------------------------------

#---------------------------------------------------------------------
# Global settings
#---------------------------------------------------------------------
global
    # to have these messages end up in /var/log/haproxy.log you will
    # need to:
    #
    # 1) configure syslog to accept network log events.  This is done
    #    by adding the '-r' option to the SYSLOGD_OPTIONS in
    #    /etc/sysconfig/syslog
    #
    # 2) configure local2 events to go to the /var/log/haproxy.log
    #   file. A line like the following can be added to
    #   /etc/sysconfig/syslog
    #
    #    local2.*                       /var/log/haproxy.log
    #
    log         127.0.0.1 local2

    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon

    # turn on stats unix socket
    stats socket /var/lib/haproxy/stats

#---------------------------------------------------------------------
# common defaults that all the 'listen' and 'backend' sections will
# use if not designated in their block
#---------------------------------------------------------------------
defaults
    mode                    http
    log                     global
    option                  httplog
    option                  dontlognull
    option http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 8000
   # contimeout              50000
   # clitimeout              50000
   # srvtimeout              50000

#-----------------------------------------------------------------------------------


listen kube-apiserver-https
    bind 0.0.0.0:{{ kube_api_secure_port }}  ssl crt /etc/kubernetes/certs/server.pem
    mode tcp
    default_backend apiserver-http

listen kube-apiserver-http
    bind 0.0.0.0:8080
    mode tcp
    default_backend apiserver-http

backend apiserver-http
    mode tcp
    balance source
{% for host in groups['masters'] %}
    server kube-apiservice0{{ loop.index }} {{ host }}:{{ kube_api_secure_port }} check inter 2000 rise 2 fall 5
{% endfor %}
```

