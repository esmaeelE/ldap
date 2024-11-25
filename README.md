# ldap
LDAP repository

LDAP is a radios server.

[TODO]
* How to harden ldap server?
* Restrict access from internet.

---


  * CN = Common Name
  * OU = Organizational Unit
  * DC = Domain Component


# TODO

* dockerize
* UI
* backup restore crontab

* https://hub.docker.com/r/bitnami/openldap

---

# Commands use for compose.yml
```
nc -nzv 127.0.0.1 1636
nc -nzv 127.0.0.1 1389
```

```
ldapsearch -H ldap://localhost:1389 -b dc=example,dc=org -D "cn=admin,dc=example,dc=org" -w"adminpassword"
```

