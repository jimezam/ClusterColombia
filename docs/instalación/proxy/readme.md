# Proxy para acceso al API

A continuación se describen los pasos para instalar y configurar un proxy reverso con `nginx` para facilitar el acceso a los nodos con el API del clúster (Slurm).

TODO

## Instalación

### Instalación de `nginx`

```
$ sudo yum install nginx
```

## Configuración

### Configuración del firewall para permitir el tráfico

Debe tenerse en cuenta cuáles puertos utilizará el `nginx` para exponer el API (http 80, https 443).

```
$ sudo firewall-cmd --permanent --zone=public --add-service=http 

$ sudo firewall-cmd --permanent --zone=public --add-service=https
```

Reiniciar el sericio del firewall para que los ajustes recién hechos sean tenidos en cuenta.

```
$ sudo firewall-cmd --reload
```

### Configurar el inicio automático de `nginx` 

```
$ sudo systemctl enable nginx
```

## Configuración del servicio

TODO

## Configuración de TLS

TODO

https://www.scaleway.com/en/docs/tutorials/nginx-reverse-proxy/