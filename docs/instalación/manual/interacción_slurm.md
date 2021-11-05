# Interacción con Slurm

## Ajustes de HTCondor

### Spool

Para que Slurm pueda tener acceso a los archivos que son enviados con el trabajo de HTCondor entre los clústeres, es necesario que el *spool* de HTCondor se encuentre en un medio compartido y que pueda ser accedido por los nodos de Slurm.

Para hacer esto es necesario editar el archivo `/etc/condor/condor_config.local` de cada nodo y agregar la definición de la siguiente variable.

```
SPOOL = /shared/filesystem/condor_spool
```

Siendo el directorio `/shared/filesystem/condor_spool` propiedad de `condor:condor`.

## Ajustes de Slurm

### Alias de usuarios

Por cada usuario que puede enviar trabajos al clúster, es decir, cada usuario con un *token* válido, es necesario crear su respectiva cuenta en Slurm de la siguiente manera.

```
$ sacctmgr add user xxxx Account=zzzz
```

Siendo `zzzz` una cuenta de Slurm existente y `xxxx` el nombre de usuario del propietario del token.

Por ejemplo:

```
$ sacctmgr add user ingeniero Account=bios
```