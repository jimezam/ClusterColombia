# Instalación del clúster

## Precondición

Durante la elaboración de las presentes guías se realizaron los siguiente supuestos de infraestructura.

| Hostname | Rol | IP interna | IP externa |
| --- | --- | --- | --- |
| cm.clustercolombia.com | `Central Manager` | 192.168.1.250 | 10.70.70.14 |
| sn.clustercolombia.com | `Submit Node` | 192.168.1.251 | 10.70.70.15 |
| en1.clustercolombia.com | `Execute Node` | 192.168.1.240 | N/A |
| en2.clustercolombia.com | `Execute Node` | 192.168.1.241 | N/A |

Cada uno de los servidores tiene instalado [Centos 7.9](http://isoredirect.centos.org/centos/7/isos/x86_64/) mientras que las máquinas virtuales utilizadas para experimentación, utilizan su respectiva imagen de [Vagrant](https://app.vagrantup.com/centos/boxes/7).

## Procedimiento

1. [Requerimientos de software](software_requerido.md)
1. [Instalación base](base.md)
1. Instalación de HTCondor
    1. [General](instalación_htcondor-base.md)
    1. [Rol `Central Manager` (`CM`)](instalación_htcondor-rol_cm.md)
    1. [Rol `Execute Node` (`EN`)](instalación_htcondor-rol_en.md)
    1. [Rol `Submit Node` (`SN`)](instalación_htcondor-rol_sn.md)
1. Interconexión entre clústers
    1. [Nodo principal (`CM`/`SN`)](interconexión/readme.md)
    1. [Nodos de ejecución (`EN`)](interconexión/nodo_en.md)
    1. [Gestión de ID Tokens](interconexión/gestion_tokens.md)
1. [Interacción con Slurm](interacción_slurm.md)

## Observaciones

- En el proyecto ClusterColombia se instalará un nodo principal que tendrá tanto el rol de `Central Manager` (`CM`) como el de `Submit Node` (`SN`).