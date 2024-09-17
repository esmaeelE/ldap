# Install LDAP on Ubuntu 

https://ubuntu.com/server/docs/install-and-configure-ldap


# Enable ssl

https://ubuntu.com/server/docs/ldap-and-transport-layer-security-tls

```
/etc/ldap/ldap.conf
#
# LDAP Defaults
#

# See ldap.conf(5) for details
# This file should be world readable but not world writable.


#SIZELIMIT	12
#TIMELIMIT	15
#DEREF		never

# TLS certificates (needed for GnuTLS)
TLS_CACERT	/etc/ssl/certs/ca-certificates.crt
TLS_REQCERT	allow
```


Add below line to `/etc/default/slapd`

```
SLAPD_SERVICES="ldap:/// ldapi:/// ldaps:///"
```

Now ldap server listens on **636, 389** ports


## Check

```
ldapwhoami -x -Z -H ldap://
ldapwhoami -x -H ldap://
ldapwhoami -x -ZZ -H ldap://
```

