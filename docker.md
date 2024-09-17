## Run                                                                                                                                                                                         
                                                                                                                                                                                               
start                                                                                                                                                                                          
```                                                                                                                                                                                            
docker-compose up -d                                                                                                                                                                           
```                                                                                                                                                                                            
                                                                                                                                                                                               
stop                                                                                                                                                                                           
```                                                                                                                                                                                            
docker-compose down -v --remove-orphans                                                                                                                                                        
```


## Login to phpldap admin
```
$ docker exec openldap ldapsearch -x -H ldap://localhost -b dc=example,dc=com -D "cn=admin,dc=example,dc=com" -w"administratorpasswordASDASDASD";
```


### From other systems
```
apt install ldap-utils
ldapsearch -x -H ldap://public_ip -b dc=example,dc=com -D "cn=admin,dc=example,dc=com" -w"administratorpasswordASDASDASD";
```

## webui
Open in webbrowser: public_ip
```
user: 
cn=admin,dc=example,dc=com
password:
administratorpasswordASDASDASD
```

## Links

https://github.com/osixia/docker-openldap

## [TODO]
cant change admin, admin password, why?



