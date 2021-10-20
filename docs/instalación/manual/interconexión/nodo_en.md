# Configuración de la interconexión entre clústers para los nodos de ejecución

## Introducción

En este documento se describirán los pasos necesarios para configurar la autenticación entre nodos utilizando *ID Tokens* para permitir el envío de trabajos entre diferentes clústers (*Condor-C*).

Estos ajustes se deben realizar cada uno de los nodos de ejecución (`EN`) del clúster.

## Configuración general

Realizar los ajustes de configuración explicados a continuación en el archivo `/etc/condor/condor_config.local`.

### Información de red

Agregar las variables descritas a continuación.

| Nombre | Descripción |
| --- | --- |
| `NETWORK_INTERFACE` | Dirección IP de la interfaz de red (hacia el nodo principal) |
| `PRIVATE_NETWORK_NAME` | Nombre único de la red privada.  Debe coincidir con el asignado en el nodo principal |


Por ejemplo:

```
NETWORK_INTERFACE = 192.168.1.240
PRIVATE_NETWORK_NAME = ClusterColombia
``` 

### Configuración de autenticación con ID Tokens

Agregar las siguientes variables.

```
SEC_DEFAULT_AUTHENTICATION_METHODS=IDTOKENS
SEC_CLIENT_AUTHENTICATION_METHODS=IDTOKENS
SEC_TOKEN_DIRECTORY = /home/$(USERNAME)/.condor/tokens.d
```

## Observaciones

- Cada `EN` debe tener la cuenta de usuario del sistema operativo de cada usuario que ejecutará tareas en dichos nodos.
- Cada usuario del sistema operativo que ejecutará tareas en el `EN` deberá contar con su respectivo *token* en `SEC_TOKEN_DIRECTORY`, es decir, `/home/$(USERNAME)/.condor/tokens.d`.

## Reiniciar el servicio

Reiniciar el servicio de `condor` para garantizar que los ajustes de configuración recién hechos sean tenidos en cuenta.

```
$ sudo service condor restart
```
