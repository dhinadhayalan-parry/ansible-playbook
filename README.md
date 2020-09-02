# Ansible playbook

This ansible framework has been designed to do multiple tasks like creating ssh keys if not exists, creating service account, installing java(Azul Zulu), installing Apache tomcat 9, installing docker and kubernetes (Worker and control plane).

##Requirements

* Ansible 2.7
* Python 3(Needs to be installed in Ansible server and host servers)


## Getting started

Ansible works by connecting to the host nodes and pushing out the desired task to them. Ansible use SSH to interact with the host nodes. Passwords are supported by Ansible. But it is recommended to use the SSH keys. Hence, password less authentication is recommended to avoid disclosing the keys in the Git repositories.

SSH key can be added for the password-less authentication.
```bash
ssh-add ~/aws/test-key.pem
```

## Updating host file
The `hosts` file need to up populated with the all the host and their referring group.

```yaml
[tomcat-server-1]
ec2-18-192-13-212.eu-central-1.compute.amazonaws.com
```  
## Usage

```bash
$ ansible-playbook -i hosts playbook.yml -t <role>
```

Example:
This below command will install the tomcat and copy the required configuration to the installed tomcat directory.

```bash
$ ansible-playbook -i hosts playbook.yml -t install_tomcat
```

## Available roles
* create_service_user
* create_ssh
* install_docker
* install_jdk
* install_kubernetes
* install_tomcat

## Tomcat deployment bash script

Script to download a War file and install it in the tomcat server is available in the below location.

```bash
roles/install_tomcat/files/tomcat_deploy.sh
```
