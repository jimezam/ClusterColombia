# Proxy para acceso al API

A continuación se describen los pasos para instalar y configurar un proxy reverso con `nginx` para facilitar el acceso a los nodos con el API del clúster (Slurm).

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

En caso de utilizarse un puerto diferente al de los servicios mencionados, puede utilizarse la siguiente sintáxis del comando.

```
$ firewall-cmd --permanent --zone=public --add-port=3332/tcp
```

Reiniciar el sericio del firewall para que los ajustes recién hechos sean tenidos en cuenta.

```
$ sudo firewall-cmd --reload
```

### Configurar el inicio automático de `nginx` 

```
$ sudo systemctl enable nginx
```

### Configuración del proxy

Crear el archivo `/etc/nginx/conf.d/api-proxy.conf` con el siguiente contenido.

```
server {
	listen 3332;

	# server_name proxy.clustercolombia.co;
	
	# ssl on;
	# ssl_certificate "/etc/pki/nginx/ca.crt";
	# ssl_certificate_key "/etc/pki/nginx/private/ca.key";
	# ssl_session_timeout 5m;
	# ssl_prefer_server_ciphers on;
	# ssl_protocols TLSv1.2 TLSv1.3;
	# ssl_ciphers ECDH+AESGCM:ECDH+AES256-CBC:ECDH+AES128-CBC:DH+3DES:!ADH:!AECDH:!MD5;
       
    access_log  /var/log/nginx/proxy_access.log;
	error_log  /var/log/nginx/proxy_error.log;

	location /aliado1 {
		proxy_pass_request_headers on;

		allow 127.0.0.0/24;
	    deny all;
		
		limit_except GET {
			deny all;
		}

		proxy_pass http://127.0.0.1/x/;
	}
}
```

Ajustar las siguientes variables de configuración del proxy de acuerdo con las necesidades del contexto.

| Variable | Descripción | Valor propuesto |
| --- | --- | --- |
| `listen` | Puerto en el cuál escuchará el proxy | `3332` |
| `server_name` | FQDN del proxy | `proxy.clustercolombia.co` |
| `access_log` | Ubicación del registro de accesos | `/var/log/nginx/proxy_access.log` |
| `error_log` | Ubicación del registro de errores | `/var/log/nginx/proxy_error.log` |

Modificar el archivo `/etc/nginx/conf.d/api-proxy.conf` para que sea propiedad del usuario `nginx`.

```
$ sudo chown nginx:nginx /etc/nginx/conf.d/api-proxy.conf
```

### Configuración de TLS

Remover el comentario de las siguientes variables de configuración relacionadas con SSL y ajustar sus valores de acuerdo con lo que se considere.

| Variable | Descripción | Valor propuesto |
| --- | --- | --- |
| `ssl` | Activa el soporte para TLS/SSL | `on` |
| `ssl_certificate` | Llave pública del certificado | `"/etc/pki/nginx/ca.crt"` |
| `ssl_certificate_key` | Llave privada del certificado | `"/etc/pki/nginx/private/ca.key"` |`
| `ssl_session_timeout` | Tiempo máximo de espera para transacciones SSL | `5m` |
| `ssl_prefer_server_ciphers` | Utilizar un listado personalizado de cifradores | `on` |
| `ssl_ciphers` | Algoritmos de cifrado a utilizarse | `ECDH+AESGCM:ECDH+AES256-CBC:ECDH+AES128-CBC:DH+3DES:!ADH:!AECDH:!MD5` |
| `ssl_protocols` | Versiones de protocolo TLS a utilizarse | `TLSv1.2 TLSv1.3` |

### Configuración de servidores de API

Por cada *servidor de API* que se desee incluir en el funcionamiento del proxy reverso, agregar una nueva sección `location` como la que se muestra a continuación.

```
	location /nombre {
		proxy_pass_request_headers on;

		allow 127.0.0.0/24;
	    deny all;
		
		limit_except GET {
			deny all;
		}

		proxy_pass http://192.168.0.33/api/;
	}
```

Ajustar el valor de las siguientes variables de acuerdo con la configuración específica de cada servidor de API.

| Varible | Tipo | Descripción |
| --- | --- | --- |
| `location /nombre` | Obligatoria | `/nombre` será el URI con el cual se accederá al servidor de API específico a través del proxy |
| `allow 127.0.0.0/24;` <br> `deny all;` | Opcional | Permite establecer la política de filtrado por defecto.  En este caso, permitir (`allow`) conexiones sólo desde una ubicación específica y negar las demás |
| `limit_except GET { deny all; }` | Opcional | Permite establecer una política de filtrado a nivel de verbos HTTP.  En este caso, sólo permite solicitudes tipo `GET` |
| `proxy_pass` | Obligatoria | Establece el URL exacto en el cual se consultará el API del servidor específico |

#### Acerca Slurm

En caso de que el servicio de API de `Slurm` se encuentre en el mismo nodo que el proxy, el valor de `proxy_pass` sería local de la forma: `http://unix:/var/run/slurmrestd.socket:/`.

En caso de que se encuentren en nodos diferentes, debe utilizarse de manera remota: `http://host/route/to/api/`.

### Reiniciar el servicio de nginx

Una vez terminados todos los ajustes de configuración se debe reiniciar el servicio de `nginx` para que estos sean tenidos en cuenta.

``` 
$ sudo service nginx restart
```

## Recursos

- NGINX Reverse Proxy  
  https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/
- Module ngx_http_proxy_module  
  http://nginx.org/en/docs/http/ngx_http_proxy_module.html
- How Properly Configure Nginx Server for TLS  
  https://hackernoon.com/how-properly-configure-nginx-server-for-tls-sg1d3udt
- Configuring an Nginx HTTPs Reverse Proxy on Ubuntu Bionic
  https://www.scaleway.com/en/docs/tutorials/nginx-reverse-proxy/
- Open a Port or Service with firewalld  
  https://firewalld.org/documentation/howto/open-a-port-or-service.html