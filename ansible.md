---
title: Ansible
category: Ansible
---

## Getting started

### Hosts

    $ sudo mkdir /etc/ansible
    $ sudo vim /etc/ansible/hosts.yml

```yaml
---
# Host File for Home Role
#
#   - Comments begin with the '#' character
#   - Blank lines are ignored
#   - Groups of hosts are delimited by [header] elements
#   - You can enter hostnames or ip addresses
#   - A hostname/ip can be a member of multiple groups


servers:  # This is a Group
  hosts:
    pfsense:  # This is a Host
      ansible_host: 10.1.1.254
      ansible_ssh_user: "{{ generic_variable }}"
      ansible_become_pass: '{{ super_secret_become_pass }}'
      ansible_python_interpreter: /usr/bin/local/python3.7
    mgmt:  # This is a Host
      ansible_host: localhost
      ansible_ssh_user: "{{ generic_variable }}"
      ansible_become_pass: '{{ super_secret_become_pass }}'
      ansible_connection: local
      ansible_python_interpreter: /usr/bin/python3

laptops:  # This is a Group
  hosts:
    razer:  # This is a Host
      ansible_host: 10.1.1.11
      ansible_ssh_user: "{{ generic_variable }}"
      ansible_become_pass: '{{ super_secret_become_pass }}'

```

### Running a playbook

    $ ansible-playbook playbook.yml

## Tasks

    - hosts: all
      user: root
      become: no
      vars:
        aaa: bbb
      tasks:
        - ...
      handlers:
        - ...

### Includes

    tasks:
      - include: db.yml
    handlers:
      - include: db.yml user=timmy

## Handlers

    handlers:
      - name: start apache2
        action: service name=apache2 state=started

    tasks:
      - name: install apache
        action: apt pkg=apache2 state=latest
        notify:
          - start apache2

## Vars

    - host: lol
      vars_files:
        - vars.yml
      vars:
        project_root: /etc/xyz
      tasks:
        - name: Create the SSH directory.
          file: state=directory path=${project_root}/home/.ssh/
          only_if: "$vm == 0"

## Roles

    - host: xxx
      roles:
        - db
        - { role:ruby, sudo_user:$user }
        - web

    # Uses:
    # roles/db/tasks/*.yml
    # roles/db/handlers/*.yml

### Task: Failures

    - name: my task
      command: ...
      register: result
      failed_when: "'FAILED' in result.stderr"

      ignore_errors: yes

      changed_when: "result.rc != 2"

### Env vars

    vars:
      local_home: "{{ lookup('env','HOME') }}"

## References

  * [Intro](http://www.ansibleworks.com/docs/intro_configuration.html)
  * [Modules](http://www.ansibleworks.com/docs/modules.html)

