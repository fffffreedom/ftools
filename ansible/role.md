# ansible

## role
http://docs.ansible.com/ansible/latest/playbooks_reuse_roles.html  

- tasks - contains the main list of tasks to be executed by the role.
- handlers - contains handlers, which may be used by this role or even anywhere outside this role.
- defaults - default variables for the role (see Variables for more information).
- vars - other variables for the role (see Variables for more information).
- files - contains files which can be deployed via this role.
- templates - contains templates which can be deployed via this role.
- meta - defines some meta data for this role. See below for more details.  

role的值可以是一个简单的名字，也可以是一个完全合格的路径（会到路径下去查找）：  
```
---

- hosts: webservers
  roles:
    - { role: '/path/to/my/roles/common' }
```

基础的roles列表：  
```
---
- hosts: webservers
  roles:
     - common
     - webservers
```

带变量的roles列表：  
```
---
- hosts: webservers
  roles:
    - common
    - { role: foo_app_instance, dir: '/opt/a', app_port: 5000 }
    - { role: foo_app_instance, dir: '/opt/b', app_port: 5001 }
```
新的格式：  
```
---

- hosts: webservers
  tasks:
  - include_role:
       name: foo_app_instance
    vars:
      dir: '/opt/a'
      app_port: 5000
  ...
```
You can conditionally execute a role. This is not generally recommended with the classic syntax, 
but is common when using import_role or include_role:  
```
---

- hosts: webservers
  tasks:
  - include_role:
      name: some_role
    when: "ansible_os_family == 'RedHat'"
```

tags:  
```
---

- hosts: webservers
  roles:
    - { role: foo, tags: ["bar", "baz"] }
```
另一种写法：  
```
---

- hosts: webservers
  tasks:
  - import_role:
      name: foo
    tags:
    - bar
    - baz
```

http://docs.ansible.com/ansible/latest/playbooks_variables.html  

http://docs.ansible.com/ansible/latest/playbooks_templating.html  

http://docs.ansible.com/ansible/latest/playbooks_filters.html  
```
{% ... %} for Statements
{{ ... }} for Expressions to print to the template output
{# ... #} for Comments not included in the template output
#  ... ## for Line Statements
```

http://jinja.pocoo.org/docs/2.10/templates  

http://www.ansible.com.cn/index.html  

http://docs.ansible.com/ansible/latest/YAMLSyntax.html  

