# win_install_ansible

# Context

We have two server : 

 - toto : Ubuntu server 20.04.3
 - winserv : Windows server 2019 release version

The two server are in the same network. The ip address are : 

 - toto : 192.168.0.39/24
 - winserv : 192.168.0.150/24

We gonna use ansible to install and configure the windows roles automatically. 

# Windows server configuration

Ansible need to connect to this different node with a ssh connexion. As you know, Windows don't really use ssh. So, the solution is to use winrm.
On the windows server, we gonna configure winrm with this ligne of powershell : 

`iex (iwr https://raw.githubcontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1).Content`

# Linux server configuration

We gonna create a file `inventory.ini`, and write in some parameters. It's for use winrm intead of ssh.

![image](https://user-images.githubusercontent.com/35137250/148465054-d9d405eb-821e-48d9-9af1-988b32e9ec78.png)

The `[winserv]` is the form to configure an host. You can enter below the ip address or the hostname you write in the `/etc/hosts` file.
The `[winserv:vars]` is the different supplement parameters we gonna use to work with winrm.
  - `ansible_connexion` is the way to connect to the target server.
  - `ansible_user` is the name of the account of the target server.
  - `ansible_password` is the password of the account of the target server.
  - `ansible_winrm_server_cert_validation=ignore` is for don't use the certificate, who can be invalide.

You can test the connexion between the ansible server and the windows server with this command : 

`ansible -i inventory.ini winserv -m win_ping`

The parameters of this command : 
  - `-i inventory.ini` is to use the inventory.ini file (use winrm and the host who are configure in this file).
  - `winserv` is the hostname of the target of the ping.
  - `-m win_ping` is the way to ping with ansible.

To install the roles, we gonna use a additionnal package who is ansible.windows, with `ansible-galaxy` : 

`ansible-galaxy collection install ansible.windows`

We gonna create several powershell script in a script_windows directory. And we gonna deploy all the powershell script with ansible.

![image](https://user-images.githubusercontent.com/35137250/148467065-b27b3f4b-00ec-43fe-b592-aaec64fbc6fa.png)

(ansible file extension is yaml or yml)

The first two lines is the name of the playbook and the host (target server). The third line is to initialize all the different tasks.
After that, you can create all the tasks you want. In the part `script:` you need to enter the path to select the powershell script.

After that, you gonna lunch the playbook like this :

`ansible-playbook -i inventory.ini ans-role.yaml`


