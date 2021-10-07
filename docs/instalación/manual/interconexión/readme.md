# Configuración de la interconexión entre clústers para el nodo principal

## Introducción

En este documento se describirán los pasos necesarios para configurar la autenticación entre nodos utilizando *ID Tokens* para permitir el envío de trabajos entre diferentes clústers (*Condor-C*).

Estos ajustes se deben realizar en el nodo principal de cada clúster (`CM`/`SN`).

## Configuración general

Realizar los ajustes de configuración explicados a continuación en el archivo `/etc/condor/condor_config.local`.

### Información de red

Agregar las variables descritas a continuación.

| Nombre | Descripción |
| --- | --- |
| `NETWORK_INTERFACE` | Dirección IP de la interfaz pública de red (externa - hacia los clientes) |
| `PRIVATE_NETWORK_INTERFACE` | Dirección IP de la interfaz privada de red (interna - hacia los nodos de ejecución) |
| `PRIVATE_NETWORK_NAME` | Nombre único de la red privada |


Por ejemplo:

```
NETWORK_INTERFACE = 10.70.70.14
PRIVATE_NETWORK_INTERFACE = 192.168.1.250
PRIVATE_NETWORK_NAME = ClusterColombia
``` 

### Configuración de autenticación con ID Tokens

Agregar las siguientes variables.

```
SEC_CLIENT_AUTHENTICATION_METHODS=IDTOKENS
SEC_PASSWORD_FILE = /etc/condor/passwords.d/POOL
SEC_TOKEN_DIRECTORY = /home/$(USERNAME)/.condor/tokens.d
```

### Configuración del envío de trabajos con Condor-C

```
SCHEDD_NAME=$(CONDOR_HOST)
CONDOR_GAHP = $(SBIN)/condor_c-gahp
C_GAHP_LOG = /tmp/CGAHPLog.$(USERNAME)
C_GAHP_WORKER_THREAD_LOG = /tmp/CGAHPWorkerLog.$(USERNAME)
C_GAHP_WORKER_THREAD_LOCK = /tmp/CGAHPWorkerLock.$(USERNAME)
```

## Configuración de seguridad

Establecer las siguientes variables como el contenido del archivo `/etc/condor/config.d/50-security`.

```
# Require authentication and integrity checking by default.
use SECURITY : With_Authentication

# Host-based security is fine in a container environment, especially if
# we're also using a pool password or a token.
use SECURITY : Host_Based
# We also want root to be able to do reconfigs, restarts, etc.
ALLOW_ADMINISTRATOR = root@$(FULL_HOSTNAME) condor@$(FULL_HOSTNAME) $(ALLOW_ADMINISTRATOR)

# TOKEN-based auth is the preferred method starting with the HTCondor
# 8.9 series.
if version >= 8.9.7
    SEC_DEFAULT_AUTHENTICATION_METHODS = IDTOKENS
else
    SEC_DEFAULT_AUTHENTICATION_METHODS = TOKEN, FS
endif

if $(USE_POOL_PASSWORD:no)
    SEC_DEFAULT_AUTHENTICATION_METHODS = $(SEC_DEFAULT_AUTHENTICATION_METHODS), PASSWORD

    ALLOW_ADVERTISE_STARTD = condor_pool@*/* $(ALLOW_ADVERTISE_STARTD)
    ALLOW_ADVERTISE_SCHEDD = condor_pool@*/* $(ALLOW_ADVERTISE_SCHEDD)
    ALLOW_ADVERTISE_MASTER = condor_pool@*/* $(ALLOW_ADVERTISE_MASTER)
endif

# Allow public reads; in this case. Adjust according local setup.
ALLOW_READ = *
# Allow public writes; in this case. Adjust according local setup.
ALLOW_WRITE = *
SEC_READ_AUTHENTICATION = OPTIONAL

# Allow submit from individual users on below variables

ALLOW_ADVERTISE_MASTER = \
    $(ALLOW_ADVERTISE_MASTER) \
    $(ALLOW_WRITE_COLLECTOR) 

ALLOW_ADVERTISE_STARTD = \
    $(ALLOW_ADVERTISE_STARTD) \
    $(ALLOW_WRITE_COLLECTOR) 

ALLOW_ADVERTISE_SCHEDD = \
    $(ALLOW_ADVERTISE_STARTD) \
    $(ALLOW_WRITE_COLLECTOR) 

``` 

Esta es una [copia local](50-security) de un archivo `50-security` de ejemplo.

## Reiniciar el servicio

Reiniciar el servicio de `condor` para garantizar que los ajustes de configuración recién hechos sean tenidos en cuenta.

```
$ sudo service condor restart
```
