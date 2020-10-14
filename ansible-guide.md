---
title: "Ansible quickstart"
category: Ansible
layout: 2017/sheet
description: |
  A quick guide to getting started with your first Ansible playbook.
---

### Install Ansible

```bash
#apt install ansible      # ubuntu
#dnf install ansible      # CentOS, Fedora, RedHat
```

Ansible is available as a package in most OS's.

See: [Installation](http://docs.ansible.com/ansible/latest/intro_installation.html)

### Start your project

```bash
~$ ansible-galaxy role init "ansible_home"
```

Make a folder for your Ansible files.

See: [Getting started](http://docs.ansible.com/ansible/latest/intro_getting_started.html)

## Creating your files

### Inventory file

#### ~/hosts.yml

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

This is a list of hosts you want to manage, grouped into groups. (Hint: try
using `ansible_host: localhost` `ansible_connection: local` to deploy to your local machine.)

See: [Intro to Inventory](http://docs.ansible.com/ansible/latest/intro_inventory.html)

### Playbook

#### ~/plays/playbook.yml 

```yaml
- hosts: mgmt
  # user: root (My user is assigned by my hosts.yml but I could assign it here)
  vars_files:
    - vars/credentials.yml
    - vars/vault_credentials.yml
  tasks:

    - include: task.yml
```

See: [Intro to Playbooks](http://docs.ansible.com/ansible/latest/playbooks_intro.html)

### Tasks

#### ~/tasks/task.yml

```yaml
- name: Add GNUPG Keys For Repo's
  become: true
  apt_key:
    url: https://download.sublimetext.com/sublimehq-pub.gpg
    state: present

- name: Add Repo's to Sources
  become: true
  apt_repository:
    repo: deb https://download.sublimetext.com/ apt/stable/
    state: present

- name: Apt Update
  become: true
  apt:
    update_cache: yes
    upgrade: yes
    autoclean: yes
    autoremove: yes

- name: Install Needed Packages
  become: true
  apt:
    name: "{{ item }}"
    state: present
    autoclean: yes
  loop:
    - firefox
    - sublime-text
    - onedrive
```

### Variables

#### vars/credentials.yml

```yaml
generic_variable: "I'm_generic"
super_secret_become_pass: "{{ vault_super_secret_become_pass }}"
```

#### vars/vault_credentials.yml

```yaml
vault_super_secret_become_pass: "I'm_super_secret"
```

`ansible-vault encrypt vars/vault_credentials.yml --ask-vault-pass` and then answer the prompt with a password for vault decryption.

To edit vault_credentials.yml after encryption `ansible-vault edit vars/vault_credentials.yml --ask-vault-pass` and then answer the prompt.

## Running

### Running ansible-playbook

```
~$ ansible-playbook -i hosts plays/task.yml
PLAY [mgmt] ********************************************************************

GATHERING FACTS ***************************************************************
ok: [mgmt]

TASK: [Add GNUPG Keys For Repo's] *********************************************************
ok: [mgmt]

TASK: [Add Repo's to Sources] ***********************************************
ok: [mgmt]
...
```

## Read more

* [Getting started with Ansible](http://lowendbox.com/blog/getting-started-with-ansible/) _(lowendbox.com)_
* [Getting started](http://docs.ansible.com/ansible/latest/intro_getting_started.html) _(docs.ansible.com)_
* [Intro to Inventory](http://docs.ansible.com/ansible/latest/intro_inventory.html) _(docs.ansible.com)_
* [Intro to Playbooks](http://docs.ansible.com/ansible/latest/playbooks_intro.html) _(docs.ansible.com)_
