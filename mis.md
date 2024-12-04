# Misc.

https://ubuntu.com/server/docs/ldap-and-transport-layer-security-tls

# Client side with ssl auth

add this config to `/etc/ldap/ldap.conf`
```
TLS_CACERT	/etc/ssl/certs/ca-certificates.crt
TLS_REQCERT	allow
```

Check connectivity with ssl "-ZZ or -Z"
```
ldapsearch -x -H ldap://IP -b dc=example,dc=com -D "cn=admin,dc=example,dc=com" -w"SecurePassword" -ZZ;
```

# Install gitlab and integrate with ldap as user manager


Just enough to go with ubuntu wiki to install and run ldap

https://ubuntu.com/server/docs/ldap-and-transport-layer-security-tls

This method works for ubuntu and debian machines.


Self sign connect to ca cert not work use ubuntu weblog method to use general cert manager



## Introduction

* What is ldap?
* What is gitlab?
* How to integrate?


## Installation phase

1. Install ldap on Ubuntu GNU/Linux 
I use Ubuntu 24.04 for this tutorial.



## Basic Installation

```
$ sudo apt install slapd
```

In this stage enter Administration password for our ldap server.

for example: Super$ecretP@ssw0rd

### Configuration 

```
$ sudo dpkg-reconfigure slapd
```

Setting your domain: example.com
Organization name: example.com

You can change it.

# Test connection
 
```
$ ldapsearch -x -H ldap://localhost -b dc=example,dc=com -D "cn=admin,dc=example,dc=com" -w"Super$ecretP@ssw0rd" ;  
# extended LDIF
#
# LDAPv3
# base <dc=example,dc=com> with scope subtree
# filter: (objectclass=*)
# requesting: ALL
#

# example.com
dn: dc=example,dc=com
objectClass: top
objectClass: dcObject
objectClass: organization
o: example.com
dc: example

# search result
search: 2
result: 0 Success

# numResponses: 2
# numEntries: 1

```

Above output show server works find and you can connect with valid username and password.

For now you can connect to ldap server with below credential

```
ip: your server ip
user/dn: admin
password: Super$ecretP@ssw0rd
```

---

Now we know our ldap server works fine.
It listen on 389 port and accept ldap connection.

But it is not secure. 
Our data availabe in plaintext format on channel.

## Enable ssl/tls for enhace security
Know ssl not work on ldap server
because of CA I think so.




## create a directory to home our configs

```
mkdir -p ~/openldap_server/ssl
cd ~/openldap_server/ssl
```

## Create keys

Install openssl package to works with ssl and keys

```
$ sudo apt install openssl
```

Run these commands step by steps
```
openssl genrsa -aes128 -out ldap.example.local.key 4096
openssl rsa -in ldap.example.local.key -out ldap.example.local.key
openssl req -new -days 3650 -key ldap.example.local.key -out ldap.example.local.csr 
openssl x509 -in ldap.example.local.csr -out ldap.example.local.crt -req -signkey ldap.example.local.key -days 3650

```




after that here is our keys

$$:~/openldap_server/ssl$ ls -ltrh
-rw-rw-r-- 1 user user 1818 Aug 12 09:50 ldap.example.local.crt
-rw-rw-r-- 1 user user 1651 Aug 12 09:50 ldap.example.local.csr
-rw------- 1 user user 3272 Aug 12 09:50 ldap.example.local.key

## Move our keys to ldap server

```
$ sudo cp * /etc/ldap/sasl2/
```

```
$ change owneship
sudo chown -R openldap:openldap /etc/ldap/sasl2/

```

Now we have ssl/tls infrastructure. lets configs ldapserver to use it.

First create a ldif file to change our ldap server configs

```
cat > ssl-ldap.ldif <<EOF
dn: cn=config
changetype: modify
add: olcTLSCACertificateFile
olcTLSCACertificateFile: /etc/ldap/sasl2/ldap.example.local.crt
-
replace: olcTLSCertificateFile
olcTLSCertificateFile: /etc/ldap/sasl2/ldap.example.local.crt
-
replace: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: /etc/ldap/sasl2/ldap.example.local.key
EOF
```

```
cat > ssl-ldap.ldif <<EOF

# create new

dn: cn=config
changetype: modify
add: olcTLSCACertificateFile
olcTLSCACertificateFile: /etc/ldap/sasl2/ca-certificates.crt
-
replace: olcTLSCertificateFile
olcTLSCertificateFile: /etc/ldap/sasl2/server.crt
-
replace: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: /etc/ldap/sasl2/server.key
EOF

```
Run change config on ldap server

```
sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f ssl-ldap.ldif
```

Client side config

```
cat >> ldap.conf <<EOF
BASE     dc=example,dc=com
URI      ldap://5.39.223.140

TLS_CACERT      /etc/ldap/sasl2/ca-certificates.crt
TLS_REQCERT     allow
EOF
```

2. ldap configuration

GUI to manager ldap server
* phpldap admin
* apache directory studio

2. Install gitlab on Ubuntu GNU/Linux


4. gitlab configuration to intergrate with Gitlab

