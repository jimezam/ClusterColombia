# Envío de trabajos locales al clúster

A continuación se describen los pasos mínimos necesarios para enviar un trabajo local al clúster HTCondor a través del `SN`.

## Crear el archivo .submit

Crear un archivo con extension `.sub` (no es obligatorio) con mínimo las siguientes variables.

| Variable | Descripción |
| --- | --- |
| `executable` | Ruta del programa a ejecutarse |
| `universe`   | Tipo de programa a ejecutarse |
| `log`        | Ubicación del archivo de registro de la ejecución |
| `output`     | Ubicación del archivo de la salida estándar del programa ejecutado |
| `error`      | Ubicación del archivo de la salida de error del programa ejecutado |

Por ejemplo, a continuación se describe el contenido de `hostname.sub`.

```
executable = /bin/hostname
universe   = vanilla
log        = _hostname.log
output     = _hostname.out
error      = _hostname.err
queue
```

## Enviar el trabajo al clúster local

Para hacer esto se debe ejecutar el comando `condor_submit` junto con el nombre del archivo `.sub` a enviarse.

```
$ condor_submit hostname.sub
```

## Revisar el estado del trabajo local

Para hacer esto se debe utilizar el comando `condor_q`.

```
$ condor_q -verbose

Fetching job ads... 0 ads


-- Schedd: cm.clustercolombia.com : <192.168.0.250:9618?... @ 10/07/21 04:44:17
OWNER   BATCH_NAME    SUBMITTED   DONE   RUN    IDLE  TOTAL JOB_IDS
jimezam ID: 5       10/7  04:44      _      1      _      1 5.0

Total for query: 1 jobs; 0 completed, 0 removed, 0 idle, 1 running, 0 held, 0 suspended 
Total for jimezam: 1 jobs; 0 completed, 0 removed, 0 idle, 1 running, 0 held, 0 suspended 
Total for all users: 1 jobs; 0 completed, 0 removed, 0 idle, 1 running, 0 held, 0 suspended

```

Las opciones `-debug`, `-analyze` y `-better-analyze` de este comando pueden dar mayor información acerca de lo que está sucediendo con los trabajos en ejecución.

## Consultar el resultado de la ejecución local

La información relacionada con la ejecución del trabajo, incluyendo el resultado obtenido, se almacena en los archivos especificados por las variables `log`, `output` y `error` del archivo `.sub` ejecutado.

```
$ cat _hostname.log

000 (006.000.000) 2021-10-07 04:45:40 Job submitted from host: <192.168.0.250:9618?PrivAddr=%3c192.168.0.250:9618%3fsock%3dschedd_3606_fe9a%3e&PrivNet=Jorge&addrs=192.168.0.250-9618&alias=cm.clustercolombia.com&noUDP&sock=schedd_3606_fe9a>
...
040 (006.000.000) 2021-10-07 04:45:55 Started transferring input files
	Transferring to host: <192.168.0.240:9618?addrs=192.168.0.240-9618&alias=en1.clustercolombia.com&noUDP&sock=slot1_3461_5666_8>
...
040 (006.000.000) 2021-10-07 04:45:55 Finished transferring input files
...
001 (006.000.000) 2021-10-07 04:45:56 Job executing on host: <192.168.0.240:9618?addrs=192.168.0.240-9618&alias=en1.clustercolombia.com&noUDP&sock=startd_3428_e6be>
...
006 (006.000.000) 2021-10-07 04:45:56 Image size of job updated: 17
	0  -  MemoryUsage of job (MB)
	0  -  ResidentSetSize of job (KB)
...
040 (006.000.000) 2021-10-07 04:45:56 Started transferring output files
...
040 (006.000.000) 2021-10-07 04:45:56 Finished transferring output files
...
005 (006.000.000) 2021-10-07 04:45:56 Job terminated.
	(1) Normal termination (return value 0)
		Usr 0 00:00:00, Sys 0 00:00:00  -  Run Remote Usage
		Usr 0 00:00:00, Sys 0 00:00:00  -  Run Local Usage
		Usr 0 00:00:00, Sys 0 00:00:00  -  Total Remote Usage
		Usr 0 00:00:00, Sys 0 00:00:00  -  Total Local Usage
	22  -  Run Bytes Sent By Job
	15784  -  Run Bytes Received By Job
	22  -  Total Bytes Sent By Job
	15784  -  Total Bytes Received By Job
	Partitionable Resources :    Usage  Request Allocated 
	   Cpus                 :                 1         1 
	   Disk (KB)            :       25       17  50905932 
	   Memory (MB)          :        0        1       990 

	Job terminated of its own accord at 2021-10-07T04:45:56Z.
...
```

```
$ cat _hostname.out

en1.clustercolombia.com
```

``` 
$ cat _hostname.err

[Vacío]
```

## Recursos

- Submitting a Job  
  [https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html](https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html)
- Submitting Jobs Without a Shared File System: HTCondor’s File Transfer Mechanism  
  [https://htcondor.readthedocs.io/en/latest/users-manual/file-transfer.html](https://htcondor.readthedocs.io/en/latest/users-manual/file-transfer.html)