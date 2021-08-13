# Alias de comandos

## Administración del clúster

Para activar los alias de administración de los nodos del clúster se debe ejecutar el siguiente comando.

En Linux:

```
$ cd ClusterColombia/cluster

$ source bin/aliases.sh
```

En Windows: (experimental)

```
> cd ClusterColombia\cluster

> bin\aliases.bat
```

### Alias disponibles

| Alias | Descripción |
| --- | --- |
| `cs` | Estado actual de los nodos del clúster |
| `cmu` | Iniciar nodo CM |
| `cmh` | Detener nodo CM |
| `cmd` | Destruir nodo CM |
| `cms` | Abrir una conexión SSH al nodo CM |
| `e1u` | Iniciar nodo EN1 |
| `e1h` | Detener nodo EN1 |
| `e1d` | Destruir nodo EN1 |
| `e1s` | Abrir una conexión SSH al nodo EN1 |
| `e2u` | Iniciar nodo EN2 |
| `e2h` | Detener nodo EN2 |
| `e2d` | Destruir nodo EN2 |
| `e2s` | Abrir una conexión SSH al nodo EN2 |
