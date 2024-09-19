# Add non existing or change email address for all users

## Python script to add email attribute to ldap server

```
import ldap3                                                                                                                                                      
                                                                                                                                                                             
ldap_conn = ldap3.Connection('1.2.3.4', raise_exceptions=True,                                                                                                           
    auto_bind=True, user='cn=admin,dc=example,dc=com', password='S3cr3tP@ssword')                                                                                                 
                                                                                                                                                                             
my_dn = "cn=users,ou=jam,dc=example,dc=com"                                                                                                                            
                                                                                                                                                                             
ldap_conn.search(                                                                                                                                                            
    search_base=my_dn,                                                                                                                                                       
    #search_filter= '(objectClass=*)', # required                                                                                                                             
    # search_filter= '&(objectclass=person)', # required                                                                                                                             
    search_filter= '(&(objectclass=person)(uid=*))', # required                                                                                                                             
    # search_scope=ldap3.BASE,                                                                                                                                                 
    attributes='*'                                                                                                                                                           
)                                                                                                                                                                            

# ldap_conn.search(my_dn, '(&(objectclass=person)(uid=*))', attributes=['sn', 'cn', 'objectclass'])
# ldap_conn.search(my_dn, '(&(objectclass=person)(uid=*))')


# print(ldap_conn.response)
for item in ldap_conn.response:
    # print(item)
    cn = item['attributes']['cn'][0]
    # generate new email address and insert
    ldap_conn.modify(item['raw_dn'].decode("utf-8"),
         {'mail': [(ldap3.MODIFY_REPLACE, [f"{cn}@example.com"])]})
    print(cn)         

```
