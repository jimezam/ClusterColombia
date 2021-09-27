# Instalación del rol `Execute Node` de HTCondor

Los procedimientos descritos en esta guía se deben realizar en todas las máquinas que harán parte del clúster HTCondor y se designen como `Execute Node` o `en`.

## Configuración

### Establecer el rol de `en`

```
$ sudo vi /etc/condor/config.d/51-role-exec

use ROLE: Execute
```

### Reiniciar el servicio de HTCondor

Una vez configurado el nodo con el rol de `en`, reiniciar el servicio para que los cambios recién hechos sean tenidos en cuenta.

```
$ sudo service condor restart
```
