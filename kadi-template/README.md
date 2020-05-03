Introduction
============

This is a template to use Kitchen-CI with Ansible, Docker and Inspec. For using to the template, we have created a test role which install nginx playbook.

Prerequisites
=============

* RVM 1.29.4
* Python > 2.7
* Pipenv 2018.10.13

Setup the environment
=====================

* Download the repository:

```
git clone git@gitlab.com:JuananOc/kadi-template.git
```

* Install Ansible with Python

```
pipenv install
```

* Install rvm

```
https://rvm.io/rvm/install
```


* Use Bundler for installing kitchen, kitchen Docker driver, kitchen Ansible driver and kitchen inspec driver.

```
cd kadi-template
bundle
```

And that's all that you need to start working :D

Project Structure
=================

```
.
├── Gemfile
├── Gemfile.lock
├── Pipfile
├── Pipfile.lock
├── README.md
├── ansible
│   ├── inventory
│   │   └── localhost
│   │       ├── group_vars
│   │       │   └── all.yml
│   │       └── inventory.hosts
│   └── playbooks
│       └── roles
│           ├── ansible_initial_setup
│           │   ├── files
│           │   │   ├── id_rsa
│           │   │   └── id_rsa.pub
│           │   ├── tasks
│           │   │   └── main.yml
│           │   └── tests
│           │       ├── controls
│           │       │   └── ansible_initial_setup_spec.rb
│           │       ├── inspec.yml
│           │       └── test-playbook.yml
│           └── nginx
│               ├── tasks
│               │   └── main.yml
│               └── tests
│                   ├── controls
│                   │   └── nginx_spec.rb
│                   ├── inspec.yml
│                   ├── test-playbook-ssh.yml
│                   └── test-playbook.yml
└── ansible.cfg
```

Configuration explanation
=========================

There are two basic configuration:

* Local connections of Ansible.
* SSH connections of Ansible. 

I find easier to write this configuration explanation inside of the .kitchen.yml file in ansible/playbooks/roles/nginx/tests/ directory because it's easier to maintain if something changes in the code than here, so watch there all the information related with the configuration of the tests.


Execute tests
=============

Just execute this command and can execute all the tests that this project have.

```shell
cd ansible/playbooks/roles/nginx/tests/ 
kitchen test
```

