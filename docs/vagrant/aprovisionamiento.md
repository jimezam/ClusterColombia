# Aprovisionamiento

## General

En cada uno de los nodos, sin importar su tipo, se realizan las siguientes tareas de aprovisionamiento.

| *Script* | Descripción |
| --- | --- |
| `scripts/os_upgrade.sh` | Actualizar los paquetes del sistema operativo (repositorios). |
| `scripts/base_software_install.sh` | Instalar herramientas básicas necesarias. |
| `scripts/ssh_allow_password.sh` | Permitir acceso con contraseñas a través de SSH. |
| `scripts/vbox_guest_additions_install.sh` | Instalar lasa ^Virtualbox Guest Additions* para mejorar la interacción con las máquinas virtuales. |
| `scripts/condor_install.sh` | Instalar los páquetes de HPC Condor. |

## Específicos de cada rol

### Central Manager (`cm`)

TODO

### Submit Node (`sn`)

TODO

### Execution Node (`en`)

TODO
