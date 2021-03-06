# Configuración

A continuación se describirán las opciones de configuración que se tienen para el clúster virtualizado local.

Crear el archivo de configuración del clúster `cluster/vagrantfiles/config.yaml` a partir del `config.yaml.base`.

## Especificación de los nodos del clúster

El clúster contará con nodos de los siguientes roles.

- Central Manager (`cm`) por defecto 1.
- Submit Nodes (`sn`) por defecto 1.
- Execution Nodes (`en`) por defecto 2.

### Cantidad de nodos

La cantidad de nodos de cada rol, obedece a la cantidad de configuraciones asignadas bajo `config` > `nodes` en sus respectivas ramas `cm`, `sn` y `en`.

### Configuración de los nodos

Por cada uno de los nodos especificados bajo `config` > `nodes` se pueden determinar las siguientes opciones de configuración.

- `hostname`: nombre del equipo (tanto para Vagrant como para Virtualbox).
- `ip`: dirección IP del nodo.
- `box`: imagen base de Vagrant sobre la cual se basará el nodo.
- `ram`: cantidad de memoria RAM que se le asignará al nodo.
- `cpu`: cantidad de núcleos del procesador que se le asignarán al nodo.

| Tener en cuenta |
| --- |
| La dirección IP que se le asigne a cada nodo deberá:<br><br>- Pertenecer al direccionamiento público de la red que se utilice.<br>- No estar siendo utilizada por otro dispositivo activo en la red. |

| Tener en cuenta |
| --- |
| Cada vez que modifique el direccionamiento IP de los nodos del clúster deberá:<br><br>- Generar nuevamente el archivo de hosts (`bin/generate_hosts.rb`).<br>- Remover del archivo `/etc/hosts` de cada nodo los registros antiguos.<br>- Volver a correr el aprovisionamiento o incluir manualmente el contenido del archivo `files/hosts` en el `/etc/hosts` de cada nodo. |

## Archivos de la VPN

En el directorio `cluster/vpn` pueden copiarse los archivos necesarios para realizar la conexión con la VPN a través de la cual se conectarán los clústeres y serán vistos por todas las máquinas virtuales del clúster a través de `/vagrant/vpn`. 

Este directorio no es tenido en cuenta durante el versionamiento de archivos.