# Crear usuarios

A continuación se detallan los pasos necesarios para crear un nuevo usuario que pueda enviar trabajos al clúster.

## Ajustes en el nodo principal del clúster

Los siguientes ajustes de configuración se deben realizar en el nodo principal del clúster **que va a recibir los trabajos** del usuario.

### Creación del usuario en el sistema operativo

```
$ sudo useradd --comment 'NOMBRE REAL' \
               --create-home \
               NOMBRE_DE_USUARIO
```

Por ejemplo:

```
$ sudo useradd --comment 'Pepito Pimentón' \
               --create-home \
               pepito
```

Asignar una contraseña al usuario recién creado.

```
$ sudo passwd NOMBRE_DE_USUARIO
```

Por ejemplo:

```
$ sudo passwd pepito
```

### Creación del ID Token

TODO: verificar si el token debe estar en quién recibe o sólo en quién envía.

```
$ sudo condor_token_create -identity NOMBRE_DE_USUARIO@DOMINIO > NOMBRE_DE_USUARIO@DOMINIO.token
```

| Importante |
| --- |
| La nomenclatura propuesta de `NOMBRE_DE_USUARIO@DOMINIO` no es obligatoria, sin embargo se sugiere para evitar confusiones entre los múltiples usuarios.

Por ejemplo:

```
$ sudo condor_token_create -identity pepito@clustercolombia.com > pepito@clustercolombia.com.token
```

Ubicar el *token* recién creado en el directorio  del usuario (`SEC_TOKEN_DIRECTORY`).

```
$ sudo mkdir -p ~NOMBRE_DE_USUARIO/.condor/tokens.d

$ sudo chown -R NOMBRE_DE_USUARIO:NOMBRE_DE_GRUPO ~NOMBRE_DE_USUARIO/.condor/tokens.d

$ sudo mv "NOMBRE_DE_USUARIO@DOMINIO.token" ~NOMBRE_DE_USUARIO/.condor/tokens.d

$ sudo chown NOMBRE_DE_USUARIO:NOMBRE_DE_GRUPO ~NOMBRE_DE_USUARIO/.condor/tokens.d/NOMBRE_DE_USUARIO@DOMINIO.token

$ sudo chmod 0700 ~NOMBRE_DE_USUARIO/.condor/tokens.d/NOMBRE_DE_USUARIO@DOMINIO.token
```

Por ejemplo:

```
$ sudo mkdir -p ~pepito/.condor/tokens.d

$ sudo chown -R pepito:pepito ~pepito/.condor/tokens.d

$ sudo mv "pepito@clustercolombia.com.token" ~pepito/.condor/tokens.d

$ sudo chown pepito:pepito ~pepito/.condor/tokens.d/pepito@clustercolombia.com.token

$ sudo chmod 0700 ~pepito/.condor/tokens.d/pepito@clustercolombia.com.token
```
TODO: repliación en ENs

## Ajustes en el nodo emisor de los trabajos

Los siguientes ajustes de configuración se deben realizar en el nodo del clúster remoto **que enviará los trabajos** al clúster.

Se debe copiar el *token* del nodo principal del clúster al nodo que envía los trabajos del clúster remoto.

```
$ sudo scp ~NOMBRE_DE_USUARIO/.condor/tokens.d/NOMBRE_DE_USUARIO@DOMINIO.token NOMBRE_DE_USUARIO@DOMINIOAMIGO:/tmp
```

Por ejemplo:

```
$ sudo scp ~pepito/.condor/tokens.d/pepito@clustercolombia.com.token pepito@clustercaldas.com:/tmp
```

En el nodo que enviará trabajos desde el clúster remoto, ubicar el *token* recibido en el directorio  del usuario (`SEC_TOKEN_DIRECTORY`).

```
$ sudo mkdir -p ~NOMBRE_DE_USUARIO/.condor/tokens.d

$ sudo chown -R NOMBRE_DE_USUARIO:NOMBRE_DE_GRUPO ~NOMBRE_DE_USUARIO/.condor/tokens.d

$ sudo mv "/tmp/NOMBRE_DE_USUARIO@DOMINIO.token" ~NOMBRE_DE_USUARIO/.condor/tokens.d

$ sudo chown NOMBRE_DE_USUARIO:NOMBRE_DE_GRUPO ~NOMBRE_DE_USUARIO/.condor/tokens.d/NOMBRE_DE_USUARIO@DOMINIO.token

$ sudo chmod 0700 ~NOMBRE_DE_USUARIO/.condor/tokens.d/NOMBRE_DE_USUARIO@DOMINIO.token
```

Por ejemplo:

```
$ sudo mkdir -p ~pepito/.condor/tokens.d

$ sudo chown -R pepito:pepito ~pepito/.condor/tokens.d

$ sudo mv "/tmp/pepito@clustercolombia.com.token" ~pepito/.condor/tokens.d

$ sudo chown pepito:pepito ~pepito/.condor/tokens.d/pepito@clustercolombia.com.token

$ sudo chmod 0700 ~pepito/.condor/tokens.d/pepito@clustercolombia.com.token
```
