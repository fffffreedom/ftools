#!/bin/sh

domain=ceph.vv.com

openssl req \
    -newkey rsa:4096 -nodes -sha256 -keyout ca.key -x509 -days 3650 -out ca.crt \
    -subj "/C=CN/ST=GD/L=SZ/O=vv/CN=${domain}"

openssl req \
    -newkey rsa:4096 -nodes -sha256 -keyout ${domain}.key -out ${domain}.csr \
    -subj "/C=CN/ST=GD/L=SZ/O=vv/CN=${domain}"

echo subjectAltName=IP:10.101.19.128,DNS:ceph-lb.sz.vv.com > extfile.cnf
openssl x509 -req -days 365 -in ${domain}.csr -CA ca.crt -CAkey ca.key -CAcreateserial -extfile extfile.cnf -out ${domain}.crt

# use domain to login
# openssl x509 -req -days 3650 -in ${domain}.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out ${domain}.crt

cat ${domain}.crt ${domain}.key | tee ${domain}.pem
