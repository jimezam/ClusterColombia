# Envío de trabajos remotos al clúster

A continuación se describen los pasos mínimos necesarios para enviar un trabajo remoto desde el nodo principal de un clúster (`CM`/`SN`) al nodo principal de otro clúster del proyecto mediante la autenticación con `ID Tokens` y `Condor-C`.

## Crear el archivo .submit

Crear un archivo con extension `.sub` (no es obligatorio) con mínimo las siguientes variables.

| Variable | Descripción |
| --- | --- |
| executable | Ruta del programa a ejecutarse |
| universe   | Debe ser exclusivamente `grid` |
| log        | Ubicación del archivo de registro de la ejecución |
| output     | Ubicación del archivo de la salida estándar del programa ejecutado |
| error      | Ubicación del archivo de la salida de error del programa ejecutado |
| grid_resource | Establece la información del clúster de destino: tipo de *grid* (`condor`), `schedd` y `collector`.

Posteriormente se definen en el mismo archivo, las variables concernientes a las opciones que determinarán cómo se ejecutará el trabajo en el clúster de destino.  Por ejemplo se incluyen las siguientes.

| Variable | Descripción |
| --- | --- |
| +remote_Universe             | Tipo de programa a ejecutarse |
| +remote_requirements         | ¿Se incluirán requerimientos remotos? |
| +remote_ShouldTransferFiles  | ¿Se deberá transmitir archivos? | 
| +remote_WhenToTransferOutput | ¿Cuándo se deberá hacer la transmisión de los archivos? |

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

## Enviar el trabajo al clúster local

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

TODO
```

## Consultar el resultado de la ejecución local

La información relacionada con la ejecución del trabajo, incluyendo el resultado obtenido, se almacena en los archivos especificados por las variables `log`, `output` y `error` del archivo `.sub` ejecutado.

```
$ cat _remote.log

TODO
```

```
$ cat _remote.out

en1.clusteramigo.com
```

``` 
$ cat _remote.err

[Vacío]]
```

## Recursos

- The Grid Universe  
  [https://htcondor.readthedocs.io/en/latest/grid-computing/grid-universe.html](https://htcondor.readthedocs.io/en/latest/grid-computing/grid-universe.html)
