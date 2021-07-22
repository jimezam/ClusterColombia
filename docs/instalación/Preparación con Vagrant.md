# Preparación de las máquinas con Vagrant (Virtualbox)

## Instalación de Vagrant

```
$ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

$ sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

$ sudo apt-get update && sudo apt-get install vagrant
```

## Obtención de la imagen del sistema operativo

Para obtener la *caja* del sistema operativo, Centos 7 en este caso, se debe ejecutar el siguiente comando.

```
$ vagrant box add centos/7 --provider=virtualbox
```

## Creación de los Vagrantfile

Se crea un `Vagrantfile` por cada uno de los perfiles del clúster:

- Central Manager (`cm`)
- Execute Node (`en`)
- Submit Node (`sn`)

```
$ mkdir cm; mkdir en; mkdir sn
```

### Central Manager

```
$ vi cm/Vagrantfile
```

``` ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.hostname = "cm"
  config.vm.define "cm", primary: true

  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "cm"
    vb.gui = false
    vb.cpus = 1
    vb.memory = 1024
  end
end
```

### Execute Node

Ajustar el arreglo `servers` con la cantidad y configuración de los nodos trabajadores que se requieran.

```
$ vi en/Vagrantfile
```

``` ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

servers=[
  {
    :hostname => "en1",
    :ip => "192.168.33.20",
    :box => "centos/7",
    :ram => 1024,
    :cpu => 1
  },
  {
    :hostname => "en2",
    :ip => "192.168.33.21",
    :box => "centos/7",
    :ram => 1024,
    :cpu => 1
  }
]

Vagrant.configure("2") do |config|  
  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.vm.box = machine[:box]
      node.vm.hostname = machine[:hostname]
      node.vm.network "private_network", ip: machine[:ip]

      node.vm.provider "virtualbox" do |vb|
        vb.name = machine[:hostname]
        vb.gui = false
        vb.cpus = machine[:cpu] 
        vb.memory = machine[:ram] 
      end
    end
  end
end
```

### Submit Node

```
$ vi sn/Vagrantfile
```

``` ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.hostname = "sn"
  config.vm.define "sn", primary: true

  config.vm.network "private_network", ip: "192.168.33.30"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "sn"
    vb.gui = false
    vb.cpus = 1
    vb.memory = 1024
  end
end
```

## Inicio de los diferentes nodos

Consultar el documento [Inicio de los nodos del clúster](Inicio%20del%20clúster.md)

## Consultar el estado de los nodos

```
$ vagrant global-status
```

