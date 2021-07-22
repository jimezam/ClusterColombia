# Gestión de los nodos virtualizados localmente

Ubicarse en el *shell* en el directorio `cluster/` del proyecto.

```
$ cd ~/proyectos/ClusterColombia/cluster/
```

## Scripts por tipo de nodo

Cada tipo de nodo tiene un *script* específico para gestionarlo.

| *Script* | Tipo de nodo |
| --- | --- |
| `bin/cm.sh` | Para los *Central Manager* |
| `bin/sn.sh` | Para los *Submit Node* |
| `bin/en.sh` | Para los *Execute Node* |

Si el *script* se utiliza de la siguiente manera, la `ACCIÓN` afectará a todos los nodos de ese tipo definidos durante la [configuración](configuración.md) del clúster.

```
$ bin/SCRIPT.sh ACCIÓN
```

Si el tipo de nodo relacionado al *script* utilizado cuenta con varias instanacias, la `ACCIÓN` solicitada afectará a *TODOS* los nodos.  Si se desea afectar a un nodo específico es necesario ejecutar el *script* de la siguiente manera.

```
$ bin/SCRIPT.sh ACCIÓN NOMBRE_NODO
```

## Iniciar los nodos

Para iniciar los nodos, en cantidades y configuraciones de acuerdo con los ajustes hechos en la etapa de configuración, se debe invocar el *script* del tipo de nodo deseado (ver [punto anterior](configuración.md)) y la opción `up`.

Para los *Central Manager* sería:

```
$ bin/cm.sh up
```

Para los *Submit Node* sería:

```
$ bin/sn.sh up
```

Para los *Execute Node* sería:

```
$ bin/en.sh up
```

| Tener en cuenta |
| --- |
| La *primera vez* que se inician los nodos puede tomar un tiempo significativo ya que se realizan las siguientes tareas:<br><br>- Descargar la imagen del sistema operativo elegido (una única vez para todos los nodos).<br>- Crear la máquina virtual para cada nodo a partir de la imagen del sistema operativo.<br>- Instalar y configurar el software requerido por el nodo (ver sección de [aprovisionamiento](aprovisionamiento.md)). |

## Detener los nodos

Es necesario invocar el *script* del tipo de nodo deseado y la opción `halt`.

Para los *Central Manager* sería:

```
$ bin/cm.sh halt
```

Para los *Submit Node* sería:

```
$ bin/sn.sh halt
```

Para los *Execute Node* sería:

```
$ bin/en.sh halt
```

Si se desea detener a un único *Execute Node* la ejecución del comando se debe realizar de la siguiente manera, siendo `en2` el nombre del nodo que se desea detener.

```
$ bin/en.sh halt en2
```

## Remover los nodos

Es necesario invocar el *script* del tipo de nodo deseado y la opción `destroy`.

| Advertencia |
| --- |
| Esta acción destruye la máquina virtual del nodo, incluyendo sistema operativo, datos almacenados, así como su registro en Vagrant y en Virtualbox. |

Para los *Central Manager* sería:

```
$ bin/cm.sh destroy
```

Para los *Submit Node* sería:

```
$ bin/sn.sh destroy
```

Para los *Execute Node* sería:

```
$ bin/en.sh destroy
```

Si se desea remover a un único *Execute Node* la ejecución del comando se debe realizar de la siguiente manera, siendo `en2` el nombre del nodo que se desea remover.

```
$ bin/en.sh destroy en2
```

## Estado de los nodos

El siguiente comando permite determinar el estado de ejecución de cada uno de los nodos del clúster.

```
$ bin/status.sh 

id       name   provider   state    directory                                    
---------------------------------------------------------------------------------
8c73008  cm     virtualbox poweroff /home/jimezam/ClusterColombia/cluster 
5236370  sn     virtualbox poweroff /home/jimezam/ClusterColombia/cluster 
5e17afd  en1    virtualbox running  /home/jimezam/ClusterColombia/cluster 
586e50e  en2    virtualbox running  /home/jimezam/ClusterColombia/cluster 
```

