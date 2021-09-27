# Instalación del rol `Submit Node` de HTCondor

Los procedimientos descritos en esta guía se deben realizar en todas las máquinas que harán parte del clúster HTCondor y se designen como `Submit Node` o `sn`.

## Configuración

### Establecer el rol de `sn`

```
$ sudo vi /etc/condor/config.d/51-role-submit

use ROLE: Submit
```

### Reiniciar el servicio de HTCondor

Una vez configurado el nodo con el rol de `sn`, reiniciar el servicio para que los cambios recién hechos sean tenidos en cuenta.

```
$ sudo service condor restart
```
