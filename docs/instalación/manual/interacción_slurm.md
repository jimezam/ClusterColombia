# Interacción con Slurm

## Ajustes de HTCondor

### Spool

Para que Slurm pueda tener acceso a los archivos que son enviados con el trabajo de HTCondor entre los clústeres, es necesario que el *spool* de HTCondor se encuentre en un medio compartido y que pueda ser accedido por los nodos de Slurm.

Para hacer esto es necesario editar el archivo `/etc/condor/condor_config.local` de cada nodo y agregar la definición de la siguiente variable.

```
SPOOL = /shared/filesystem/condor_spool
```

Siendo el directorio `/shared/filesystem/condor_spool` propiedad de `condor:condor`.