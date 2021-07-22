# Instalación

A continuación se describen los pasos necesarios para instalar el clúster virtualizado de manera local.

## Fuentes del proyecto de documentación

Ubicarse en el directorio donde se va a realizar la instalación, por ejemplo `~/proyectos`.

```
$ cd ~/proyectos
```

Clonar el repositorio del proyecto de documentación.

```
$ git clone https://github.com/jimezam/ClusterColombia.git
```

## Obtener la imagen de las máquinas virtuales (opcional)

Este paso es opcional y consiste en descargar la imagen del sistema operativo con la cual se crearán las máquinas virtuales de los nodos.  Si desea no hacerlo en este momento, se realizará de manera automática en el momento justo en que se cree el primer nodo que la requiera.

```
$ vagrant box add centos/7

1) hyperv
2) libvirt
3) virtualbox
4) vmware_desktop
```

Elegir la opción `3` para utilizar a Virtualbox como hipervisor.