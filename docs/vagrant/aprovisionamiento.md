# Aprovisionamiento

## General

En cada uno de los nodos, sin importar su tipo, se realizan las siguientes tareas de aprovisionamiento.

| *Script* | Descripción |
| --- | --- |
| `scripts/base_software_install.sh` | Instalar herramientas básicas necesarias. |
| `scripts/condor_install.sh` | Instalar los páquetes de HPC Condor. |
| `scripts/hosts_add.sh` | Agrega el listado de nodos del cluster al `/etc/hosts` del nodo. |
| `scripts/os_upgrade.sh` | Actualizar los paquetes del sistema operativo (repositorios). |
| `scripts/rol_general.sh` | Realiza las tareas de configuración que se deben realizar en *todos* los nodos del cluster. |
| `scripts/ssh_allow_password.sh` | Permitir acceso con contraseñas a través de SSH. |
| `scripts/vbox_guest_additions_install.sh` | Instalar lasa *Virtualbox Guest Additions* para mejorar la interacción con las máquinas virtuales. |

## Específicos de cada rol

### Central Manager (`cm`)

| *Script* | Descripción |
| --- | --- |
| `scripts/rol_cm.sh` | Realiza las tareas de configuración para los nodos con el rol *Central Manager*. |


### Submit Node (`sn`)

| *Script* | Descripción |
| --- | --- |
| `scripts/rol_sn.sh` | Realiza las tareas de configuración para los nodos con el rol *Submit Node*. |

### Execution Node (`en`)

| *Script* | Descripción |
| --- | --- |
| `scripts/rol_en.sh` | Realiza las tareas de configuración para los nodos con el rol *Execute Node*. |
