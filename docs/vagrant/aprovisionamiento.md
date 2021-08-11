# Aprovisionamiento

## General

El aprovisionamiento se realiza mediante los siguientes *playbooks* de Vagrant.

| *Playbook* | Descripción |
| --- | --- |
| `cluster/ansible/common.playbook.yml` | Realiza tareas básicas y comúnes a todos los nodos: actualiza el sistema operativo, instala paquetes necesarios, sincroniza la hora y actualiza el `/etc/hosts`. |
| `cluster/ansible/condor_base.playbook.yml` | Instala los paquetes de HTC Condor |

## Específicos de cada rol

### Central Manager (`cm`)

| *Playbook* | Descripción |
| --- | --- |
| `cluster/ansible/condor_role_cm.playbook.yml` | Realiza las tareas de configuración para los nodos con el rol *Central Manager*. |


### Submit Node (`sn`)

| *Playbook* | Descripción |
| --- | --- |
| `cluster/ansible/condor_role_sn.playbook.yml` | Realiza las tareas de configuración para los nodos con el rol *Submit Node*. |

### Execution Node (`en`)

| *Playbook* | Descripción |
| --- | --- |
| `cluster/ansible/condor_role_en.playbook.yml` | Realiza las tareas de configuración para los nodos con el rol *Execute Node*. |
