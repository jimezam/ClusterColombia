# Instalación del software

En este documento se describe la instalación del software base que se debe instalar en cada uno de los nodos del clúster (`cm`, `en` y `sn`).

## Actualizaciones

Instalar las actualizaciones mas recientes del sistema operativo.

```
$ sudo yum -y update

$ sudo yum -y upgrade

$ sudo yum clean all
```

## Instalar las aplicaciones base

Aplicaciones mínimas requeridas

```
$ sudo yum install -y wget vim
```

Cliente y servidor de SSH.

```
$ sudo yum install -y openssh-server openssh-clients
```

[*Extra Packages for Enterprise Linux* (EPEL)](https://www.redhat.com/en/blog/whats-epel-and-how-do-i-use-it) es requerido con por HTCondor en ambientes RedHat/CentOS.

```
$ sudo yum install -y epel-release
```

## Instalar HTCondor

Importar las llaves y el repositorio para RedHat/CentOS 7.x.

```
$ sudo wget -O /etc/yum.repos.d/RPM-GPG-KEY-HTCondor https://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor

$ sudo rpm --import /etc/yum.repos.d/RPM-GPG-KEY-HTCondor

$ sudo wget -O /etc/yum.repos.d/htcondor-development-rhel7.repo https://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-stable-rhel7.repo
```

Instalar los paquetes de la distribución de HTCondor.

```
$ sudo yum install -y condor-all
```

Configurar el servicio de `condor` para que se inicie con el sistema operativo.

```
$ sudo systemctl enable condor
```

Iniciar manualmente al servicio de `condor`.

```
$ sudo systemctl start condor
```

## Verificar la ejecución de HTCondor

```
$ ps -aux | grep condor

condor   13358  0.0  0.6  68080  6336 ?        Ss   19:53   0:00 /usr/sbin/condor_master -f
root     13387  0.0  0.2  25952  2912 ?        S    19:53   0:00 condor_procd -A /var/run/condor/procd_pipe -L /var/log/condor/ProcLog -R 1000000 -S 60 -C 995
condor   13388  0.0  0.5  43552  5388 ?        Ss   19:53   0:00 condor_shared_port -f
```
