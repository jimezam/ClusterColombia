# Envío de trabajos remotos al clúster con Slurm

A continuación se describen los pasos mínimos necesarios para enviar un trabajo remoto desde el nodo principal de un clúster (`CM`/`SN`) al `Slurm` del nodo principal de otro clúster del proyecto mediante la autenticación con `ID Tokens` y `Condor-C`.

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
| `+remote_jobuniverse`          | Debe ser exclusivamente `9` (*grid*)  |
| `+remote_gridresource`         | Debe ser `batch slurm` para indicar la ejecución en esa cola |
| `+remote_requirements`         | Requerimientos específicos de la tarea en enviarse, `False` para ninguno |
| `+remote_ShouldTransferFiles`  | ¿Se deberá transmitir archivos? | 
| `+remote_WhenToTransferOutput` | ¿Cuándo se deberá hacer la transmisión de los archivos? |

Por ejemplo, a continuación se describe el contenido de `slurm.sub`.

```
executable = /usr/bin/hostname
universe = grid
output = _slurm.out
error = _slurm.err
log = _slurm.log

grid_resource = condor cm.clusteramigo.com cm.clusteramigo.com
+remote_jobuniverse = 9
+remote_gridresource = "batch slurm"
+remote_requirements = False
+remote_ShouldTransferFiles = "YES"
+remote_WhenToTransferOutput = "ON_EXIT"
queue
```

| Importante |
| --- |
| Cuando el nodo cuenta con varias interfaces de red posiblemente sea necesario especificar el `schedd` (primer parámetro) del `grid_resource` de la forma `nodo@interfaz_de_red`.  
Por ejemplo: `grid_resource = condor cm.clusteramigo.com@ibr1masterl01 cm.clusteramigo.com` |

## Enviar el trabajo al clúster local

Para hacer esto se debe ejecutar el comando `condor_submit` junto con el nombre del archivo `.sub` a enviarse.

```
$ condor_submit slurm.sub
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

10/20/21 04:53:03 ******************************************************
10/20/21 04:53:03 ** condor_c-gahp_worker_thread (CONDOR_C_GAHP_WORKER_THREAD) STARTING UP
10/20/21 04:53:03 ** /usr/sbin/condor_c-gahp_worker_thread
10/20/21 04:53:03 ** SubsystemInfo: name=C_GAHP_WORKER_THREAD type=GAHP(9) class=DAEMON(1)
10/20/21 04:53:03 ** Configuration: subsystem:C_GAHP_WORKER_THREAD local:<NONE> class:DAEMON
10/20/21 04:53:03 ** $CondorVersion: 8.9.13 Mar 30 2021 BuildID: 535058 PackageID: 8.9.13-1 $
10/20/21 04:53:03 ** $CondorPlatform: x86_64_CentOS7 $
10/20/21 04:53:03 ** PID = 3618
10/20/21 04:53:03 ** Log last touched 10/20 04:52:37
10/20/21 04:53:03 ******************************************************
10/20/21 04:53:03 Using config source: /etc/condor/condor_config
10/20/21 04:53:03 Using local config sources: 
10/20/21 04:53:03    /etc/condor/config.d/00-htcondor-9.0.config
10/20/21 04:53:03    /etc/condor/config.d/49-common
10/20/21 04:53:03    /etc/condor/config.d/50-security
10/20/21 04:53:03    /etc/condor/config.d/51-role-cm
10/20/21 04:53:03    /etc/condor/config.d/51-role-submit
10/20/21 04:53:03    /etc/condor/condor_config.local
10/20/21 04:53:03 config Macros = 80, Sorted = 80, StringBytes = 2814, TablesBytes = 2968
10/20/21 04:53:03 CLASSAD_CACHING is ENABLED
10/20/21 04:53:03 Daemon Log is logging: D_ALWAYS D_ERROR
10/20/21 04:53:03 Daemoncore: Listening at <0.0.0.0:10043> on TCP (ReliSock) and UDP (SafeSock).
10/20/21 04:53:03 DaemonCore: command socket at <10.70.70.12:10043?PrivAddr=%3c192.168.0.250:10043%3e&PrivNet=ClusterColombia&addrs=10.70.70.12-10043&alias=cm.clustercolombia.com>
10/20/21 04:53:03 DaemonCore: private command socket at <192.168.0.250:10043?addrs=10.70.70.12-10043>
10/20/21 04:53:03 ******************************************************
10/20/21 04:53:03 ** condor_c-gahp_worker_thread (CONDOR_C_GAHP_WORKER_THREAD) STARTING UP
10/20/21 04:53:03 ** /usr/sbin/condor_c-gahp_worker_thread
10/20/21 04:53:03 ** SubsystemInfo: name=C_GAHP_WORKER_THREAD type=GAHP(9) class=DAEMON(1)
10/20/21 04:53:03 ** Configuration: subsystem:C_GAHP_WORKER_THREAD local:<NONE> class:DAEMON
10/20/21 04:53:03 ** $CondorVersion: 8.9.13 Mar 30 2021 BuildID: 535058 PackageID: 8.9.13-1 $
10/20/21 04:53:03 ** $CondorPlatform: x86_64_CentOS7 $
10/20/21 04:53:03 ** PID = 3617
10/20/21 04:53:03 ** Log last touched 10/20 04:53:03
10/20/21 04:53:03 ******************************************************
10/20/21 04:53:03 Using config source: /etc/condor/condor_config
10/20/21 04:53:03 Using local config sources: 
10/20/21 04:53:03    /etc/condor/config.d/00-htcondor-9.0.config
10/20/21 04:53:03    /etc/condor/config.d/49-common
10/20/21 04:53:03    /etc/condor/config.d/50-security
10/20/21 04:53:03    /etc/condor/config.d/51-role-cm
10/20/21 04:53:03    /etc/condor/config.d/51-role-submit
10/20/21 04:53:03    /etc/condor/condor_config.local
10/20/21 04:53:03 config Macros = 80, Sorted = 80, StringBytes = 2814, TablesBytes = 2968
10/20/21 04:53:03 CLASSAD_CACHING is ENABLED
10/20/21 04:53:03 Daemon Log is logging: D_ALWAYS D_ERROR
10/20/21 04:53:03 Daemoncore: Listening at <0.0.0.0:17885> on TCP (ReliSock) and UDP (SafeSock).
10/20/21 04:53:03 DaemonCore: command socket at <10.70.70.12:17885?PrivAddr=%3c192.168.0.250:17885%3e&PrivNet=ClusterColombia&addrs=10.70.70.12-17885&alias=cm.clustercolombia.com>
10/20/21 04:53:03 DaemonCore: private command socket at <192.168.0.250:17885?addrs=10.70.70.12-17885>
10/20/21 04:53:23 [3618] Adding 7.0 to STAGE_IN batch
10/20/21 04:55:31 [3618] EOF reached on DaemonCore pipe 65536
10/20/21 04:55:31 [3618] Request pipe closed. Exiting...
10/20/21 04:55:31 [3618] **** condor_c-gahp_worker_thread (condor_C_GAHP_WORKER_THREAD) pid 3618 EXITING WITH STATUS 1
10/20/21 04:55:31 [3617] EOF reached on DaemonCore pipe 65536
10/20/21 04:55:31 [3617] Request pipe closed. Exiting...
10/20/21 04:55:31 [3617] **** condor_c-gahp_worker_thread (condor_C_GAHP_WORKER_THREAD) pid 3617 EXITING WITH STATUS 1
```

## Consultar el resultado de la ejecución local

La información relacionada con la ejecución del trabajo, incluyendo el resultado obtenido, se almacena en los archivos especificados por las variables `log`, `output` y `error` del archivo `.sub` ejecutado.

```
$ cat _slurm.log

000 (040.000.000) 2021-10-20 05:04:38 Job submitted from host: <10.70.70.12:9618?PrivAddr=%3c192.168.0.250:9618%3fsock%3dschedd_3266_c867%3e&PrivNet=ClusterColombia&addrs=10.70.70.12-9618&alias=cm.clustercolombia.com&noUDP&sock=schedd_3266_c867>
...
027 (040.000.000) 2021-10-20 05:04:53 Job submitted to grid resource
    GridResource: condor cm.clusteramigo.com cm.clusteramigo.com
    GridJobId: condor cm.clusteramigo.com cm.clusteramigo.com 8.0
...
005 (040.000.000) 2021-10-20 05:06:59 Job terminated.
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
$ cat _slurm.out

en1.clusteramigo.com
```

``` 
$ cat _slurm.err

[Vacío]
```

## Recursos

- The Grid Universe  
  [https://htcondor.readthedocs.io/en/latest/grid-computing/grid-universe.html](https://htcondor.readthedocs.io/en/latest/grid-computing/grid-universe.html)
