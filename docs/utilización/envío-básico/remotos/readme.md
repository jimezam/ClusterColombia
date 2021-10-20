# Envío de trabajos remotos al clúster

A continuación se describen los pasos mínimos necesarios para enviar un trabajo remoto desde el nodo principal de un clúster (`CM`/`SN`) al nodo principal de otro clúster del proyecto mediante la autenticación con `ID Tokens` y `Condor-C`.

## Crear el archivo .submit

Crear un archivo con extension `.sub` (no es obligatorio) con mínimo las siguientes variables.

| Variable | Descripción |
| --- | --- |
| `executable` | Ruta del programa a ejecutarse |
| `universe`   | Debe ser exclusivamente `grid` |
| `log`        | Ubicación del archivo de registro de la ejecución |
| `output`     | Ubicación del archivo de la salida estándar del programa ejecutado |
| `error`      | Ubicación del archivo de la salida de error del programa ejecutado |
| `grid_resource` | Establece la información del clúster de destino: tipo de *grid* (`condor`), `schedd` y `collector`.

Posteriormente se definen en el mismo archivo, las variables concernientes a las opciones que determinarán cómo se ejecutará el trabajo en el clúster de destino.  Por ejemplo se incluyen las siguientes.

| Variable | Descripción |
| --- | --- |
| `+remote_Universe`             | Tipo de programa a ejecutarse |
| `+remote_requirements`         | ¿Se incluirán requerimientos remotos? |
| `+remote_ShouldTransferFiles`  | ¿Se deberá transmitir archivos? | 
| `+remote_WhenToTransferOutput` | ¿Cuándo se deberá hacer la transmisión de los archivos? |

Por ejemplo, a continuación se describe el contenido de `remote.sub`.

```
executable = /usr/bin/hostname
universe   = grid
log        = _remote.log
output     = _remote.out
error      = _remote.err

grid_resource = condor cm.clusteramigo.com cm.clusteramigo.com

+remote_Universe = standard
+remote_requirements = True
+remote_ShouldTransferFiles = "YES"
+remote_WhenToTransferOutput = "ON_EXIT"
queue
```

| Importante |
| --- |
| Cuando el nodo cuenta con varias interfaces de red posiblemente sea necesario especificar el `schedd` (primer parámetro) del `grid_resource` de la forma `nodo@interfaz_de_red`.  
Por ejemplo: `grid_resource = condor cm.clusteramigo.com@ibr1masterl01 cm.clusteramigo.com` |

## Enviar el trabajo al clúster remoto

Para hacer esto se debe ejecutar el comando `condor_submit` junto con el nombre del archivo `.sub` a enviarse.

```
$ condor_submit remote.sub
```

## Revisar el estado del trabajo local

Para hacer esto se debe utilizar el comando `condor_q`.

```
$ condor_q -verbose

Fetching job ads... 0 ads


-- Schedd: cm.clustercolombia.com : <192.168.0.250:9618?... @ 10/07/21 05:09:47
OWNER   BATCH_NAME    SUBMITTED   DONE   RUN    IDLE  TOTAL JOB_IDS
jimezam ID: 9       10/7  05:09      _      _      1      1 9.0

Total for query: 1 jobs; 0 completed, 0 removed, 1 idle, 0 running, 0 held, 0 suspended 
Total for jimezam: 1 jobs; 0 completed, 0 removed, 1 idle, 0 running, 0 held, 0 suspended 
Total for all users: 1 jobs; 0 completed, 0 removed, 1 idle, 0 running, 0 held, 0 suspended

```

Las opciones `-debug`, `-analyze` y `-better-analyze` de este comando pueden dar mayor información acerca de lo que está sucediendo con los trabajos en ejecución.

## Revisar el registro de Condor-C

Consultar el contenido del archivo `/tmp/CGAHPWorkerLog.USUARIO`, donde `USUARIO` corresponde con el nombre de usuario que envía el trabajo remoto.  Por ejemplo, a continuación se muestra cómo hacerlo para el usuario `jimezam`.

```
$ tail -f /tmp/CGAHPWorkerLog.jimezam

10/19/21 23:20:27 ******************************************************
10/19/21 23:20:27 ** condor_c-gahp_worker_thread (CONDOR_C_GAHP_WORKER_THREAD) STARTING UP
10/19/21 23:20:27 ** /usr/sbin/condor_c-gahp_worker_thread
10/19/21 23:20:27 ** SubsystemInfo: name=C_GAHP_WORKER_THREAD type=GAHP(9) class=DAEMON(1)
10/19/21 23:20:27 ** Configuration: subsystem:C_GAHP_WORKER_THREAD local:<NONE> class:DAEMON
10/19/21 23:20:27 ** $CondorVersion: 8.9.13 Mar 30 2021 BuildID: 535058 PackageID: 8.9.13-1 $
10/19/21 23:20:27 ** $CondorPlatform: x86_64_CentOS7 $
10/19/21 23:20:27 ** PID = 2898353
10/19/21 23:20:27 ** Log last touched 10/11 10:47:21
10/19/21 23:20:27 ******************************************************
10/19/21 23:20:27 Using config source: /etc/condor/condor_config
10/19/21 23:20:27 Using local config sources: 
10/19/21 23:20:27    /etc/condor/config.d/00-htcondor-9.0.config
10/19/21 23:20:27    /etc/condor/config.d/49-common
10/19/21 23:20:27 ******************************************************
10/19/21 23:20:27    /etc/condor/config.d/50-security
10/19/21 23:20:27 ** condor_c-gahp_worker_thread (CONDOR_C_GAHP_WORKER_THREAD) STARTING UP
10/19/21 23:20:27    /etc/condor/config.d/51-role-cm
10/19/21 23:20:27 ** /usr/sbin/condor_c-gahp_worker_thread
10/19/21 23:20:27    /etc/condor/config.d/51-role-submit
10/19/21 23:20:27 ** SubsystemInfo: name=C_GAHP_WORKER_THREAD type=GAHP(9) class=DAEMON(1)
10/19/21 23:20:27    /etc/condor/condor_config.local
10/19/21 23:20:27 ** Configuration: subsystem:C_GAHP_WORKER_THREAD local:<NONE> class:DAEMON
10/19/21 23:20:27 config Macros = 83, Sorted = 83, StringBytes = 3206, TablesBytes = 3076
10/19/21 23:20:27 ** $CondorVersion: 8.9.13 Mar 30 2021 BuildID: 535058 PackageID: 8.9.13-1 $
10/19/21 23:20:27 CLASSAD_CACHING is ENABLED
10/19/21 23:20:27 ** $CondorPlatform: x86_64_CentOS7 $
10/19/21 23:20:27 ** PID = 2898354
10/19/21 23:20:27 Daemon Log is logging: D_ALWAYS D_ERROR
10/19/21 23:20:27 ** Log last touched 10/19 23:20:27
10/19/21 23:20:27 ******************************************************
10/19/21 23:20:27 Using config source: /etc/condor/condor_config
10/19/21 23:20:27 Using local config sources: 
10/19/21 23:20:27    /etc/condor/config.d/00-htcondor-9.0.config
10/19/21 23:20:27    /etc/condor/config.d/49-common
10/19/21 23:20:27    /etc/condor/config.d/50-security
10/19/21 23:20:27    /etc/condor/config.d/51-role-cm
10/19/21 23:20:27    /etc/condor/config.d/51-role-submit
10/19/21 23:20:27    /etc/condor/condor_config.local
10/19/21 23:20:27 config Macros = 83, Sorted = 83, StringBytes = 3206, TablesBytes = 3076
10/19/21 23:20:27 CLASSAD_CACHING is ENABLED
10/19/21 23:20:27 Daemon Log is logging: D_ALWAYS D_ERROR
10/19/21 23:20:27 Daemoncore: Listening at <0.0.0.0:17403> on TCP (ReliSock) and UDP (SafeSock).
10/19/21 23:20:27 DaemonCore: command socket at <10.70.70.12:17403?PrivAddr=%3c192.168.1.250:17403%3e&PrivNet=ClusterColombia&addrs=10.70.70.12-17403&alias=cm.clustercolombia.com>
10/19/21 23:20:27 Daemoncore: Listening at <0.0.0.0:20559> on TCP (ReliSock) and UDP (SafeSock).
10/19/21 23:20:27 DaemonCore: private command socket at <192.168.1.250:17403?addrs=10.70.70.12-17403>
10/19/21 23:20:27 DaemonCore: command socket at <10.70.70.12:20559?PrivAddr=%3c192.168.1.250:20559%3e&PrivNet=ClusterColombia&addrs=10.70.70.12-20559&alias=cm.clustercolombia.com>
10/19/21 23:20:27 DaemonCore: private command socket at <192.168.1.250:20559?addrs=10.70.70.12-20559>
10/19/21 23:20:43 [2898354] Adding 37.0 to STAGE_IN batch
10/19/21 23:21:00 [2898354] EOF reached on DaemonCore pipe 65536
10/19/21 23:21:00 [2898353] EOF reached on DaemonCore pipe 65536
10/19/21 23:21:00 [2898354] Request pipe closed. Exiting...
10/19/21 23:21:00 [2898353] Request pipe closed. Exiting...
10/19/21 23:21:00 [2898354] **** condor_c-gahp_worker_thread (condor_C_GAHP_WORKER_THREAD) pid 2898354 EXITING WITH STATUS 1
10/19/21 23:21:00 [2898353] **** condor_c-gahp_worker_thread (condor_C_GAHP_WORKER_THREAD) pid 2898353 EXITING WITH STATUS 1

```

## Consultar el resultado de la ejecución remota

La información relacionada con la ejecución del trabajo, incluyendo el resultado obtenido, se almacena en los archivos especificados por las variables `log`, `output` y `error` del archivo `.sub` ejecutado.

```
$ cat _remote.log

000 (005.000.000) 2021-10-19 23:20:24 Job submitted from host: <10.70.70.12:9618?PrivAddr=%3c192.168.1.250:9618%3fsock%3dschedd_951022_915f%3e&PrivNet=ClusterColombia&addrs=10.70.70.12-9618&alias=cm.clustercolombia.com&noUDP&sock=schedd_951022_915f>
...
027 (005.000.000) 2021-10-19 23:20:38 Job submitted to grid resource
    GridResource: condor cm.clusteramigo.com cm.clusteramigo.com
    GridJobId: condor cm.clusteramigo.com cm.clusteramigo.com 37.0
...
005 (005.000.000) 2021-10-19 23:21:00 Job terminated.
	(1) Normal termination (return value 0)
		Usr 0 00:00:00, Sys 0 00:00:00  -  Run Remote Usage
		Usr 0 00:00:00, Sys 0 00:00:00  -  Run Local Usage
		Usr 0 00:00:00, Sys 0 00:00:00  -  Total Remote Usage
		Usr 0 00:00:00, Sys 0 00:00:00  -  Total Local Usage
	0  -  Run Bytes Sent By Job
	0  -  Run Bytes Received By Job
	0  -  Total Bytes Sent By Job
	0  -  Total Bytes Received By Job
...

```

```
$ cat _remote.out

en1.clusteramigo.com
```

``` 
$ cat _remote.err

[Vacío]
```

## Recursos

- The Grid Universe  
  [https://htcondor.readthedocs.io/en/latest/grid-computing/grid-universe.html](https://htcondor.readthedocs.io/en/latest/grid-computing/grid-universe.html)
