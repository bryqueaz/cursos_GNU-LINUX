# Instalar un Servidor de FreeIPA

## Paso #1

**Deshabilitar SELINUX  de manera volatil**

```
[root@ipa ~]# setenforce 0 
```
**Instalar los paquetes básicos**
```
[root@ipa ~]# yum install bash-completion vim nss
```

## Paso #2

**Activar centosPlus**

Editar el archivo /etc/yum.repos.d/CentOS-Base.repo y en la sección [centosplus]  cambiar la opción enabled de 0 a 1.