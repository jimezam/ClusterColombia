# Instalación base de HTCondor

Los procedimientos descritos en esta guía se deben realizar en todas las máquinas que harán parte del clúster HTCondor.

## Instalación

### Importar la llave PGP del repositorio oficial de HTCondor

```
$ sudo wget -O /etc/yum.repos.d/RPM-GPG-KEY-HTCondor https://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor

$ sudo rpm --import /etc/yum.repos.d/RPM-GPG-KEY-HTCondor
```

### Agregar el repositorio oficial de HTCondor al sistema operativo.

```
$ sudo wget -O /etc/yum.repos.d/htcondor-development-rhel7.repo https://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-development-rhel7.repo
```

| Importante |
| --- |
| Se utiliza el repositorio de `development` ya que se requiere como mínimo de la versión `8.9`.  En caso de que esta ya se encuentre `stable` se debe utilizar el siguiente repositorio  
https://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-stable-rhel7.repo |

### Instalar los paquetes básicos.

```
$ sudo yum install -y epel-release condor-all
```

### Configurar el servicio de HTCondor para que se inicie junto con el sistema operativo.

```
$ sudo systemctl enable condor
```

## Configuración

### Definir la variable `CONDOR_HOST` 

Esta variable define la ubicación del `condor_collector`, el cual en este caso es el mismo `CM`.

```
$ sudo vi /etc/condor/config.d/49-common

CONDOR_HOST = cm.clustercolombia.com
```

### Establecer la interfaz de red pública del `CM`.

```
$ sudo vi /etc/condor/condor_config.local

NETWORK_INTERFACE = 10.10.10.100
```

### Permitir conexiones externas al puerto del `condor_collector` a través del firewall

```
$ sudo firewall-cmd --zone=public --add-port=9618/tcp --permanent

$ sudo firewall-cmd --reload
```

### Establecer la configuración base de seguridad de HTCondor

```
$ sudo cp /usr/share/doc/condor-8.9.13/examples/50-security /etc/condor/config.d
```

| Importante |
| --- |
| La ruta del archivo de origen que contiene la configuración base depende de la versión de HTCondor que se haya instalado.  En este caso se utilizó la `8.9.13` para hacer la guía.  Su valor se debe ajustar de manera acorde. |

### Establecer la contraseña de conexión entre nodos

Crear el directorio en el cuál se almacenará la contraseña.

```
$ sudo mkdir /etc/condor/passwords.d

$ sudo chmod 700 /etc/condor/passwords.d
```

Establecer la contraseña.

```
$ sudo condor_store_cred add -c -p "MiContraseña"
```

| Importante |
| --- |
| Para efectos de la elaboración de esta guía, se utilizó el valor de `MiContraseña`, este valor debe ajustarse de acuerdo con el diseño del clúster. |