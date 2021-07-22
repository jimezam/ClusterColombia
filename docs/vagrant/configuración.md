# Configuración

A continuación se describirán las opciones de configuración que se tienen para el clúster virtualizado local.

Editar el archivo de configuración del clúster `cluster/vagrantfiles/config.yaml`.

## Versión de Virtualbox

Bajo la opción `config` > `virtualbox` > `version` ajustar la versión de virtualbox que efectivamente se instaló en el sistema y que se va a utilizar como hipervisor para el clúster.

Por defecto: `6.1.22`.

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
