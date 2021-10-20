# Instalación del rol `Central Manager` de HTCondor

Los procedimientos descritos en esta guía se deben realizar en todas las máquinas que harán parte del clúster HTCondor y se designen como `Central Manager` o `cm`.

## Instalación

### Instalar OpenVPN

Este software es requerido para conectarse a la VPN del `Centro de Bioinformática y Biología Computacional de Colombia - BIOS`.

``` 
$ sudo yum install openvpn
```

## Configuración

### Establecer el rol de `cm`

```
$ sudo vi /etc/condor/config.d/51-role-cm

use ROLE: CentralManager
```

### Establecer quienes pueden acceder al `condor-collector`

Al archivo `51-role-cm` creado previamente, concatenar el texto mostrado a continuación.

```
$ sudo vi /etc/condor/config.d/51-role-cm

# ...
ALLOW_WRITE_COLLECTOR=$(ALLOW_WRITE) sn.clustercolombia.com
```
| Importante |
| --- |
| Agregar a este listado separado por espacios, a cualquier `Submit Node` (`SN`) que se tenga en el clúster |

### Reiniciar el servicio de HTCondor

Una vez configurado el nodo con el rol de `cm`, reiniciar el servicio para que los cambios recién hechos sean tenidos en cuenta.

```
$ sudo service condor restart
```
