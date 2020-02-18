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

## Paso #3

**Instalar epel repo**
```
[root@ipa ~]# yum install epel-release
```

## Paso #4

**Cambiar el nombre del equipo**
```
[root@ipa ~]# hostnamectl set-hostname ipa.greencore.local
```

## Paso #5

**Incluir el nombre largo del equipo y el corto para que pueda resolver**
```
[root@ipa ~]# echo "192.168.8.84 ipa.greencore.local ipa" >> /etc/hosts
```
Para probar  el FQDN  (Fully Qualified Domain Name), ejecutar el siguientes comandos

```
[root@ipa ~]# hostnamectl status
```
```
[root@ipa ~]# hostname -f
```

## Paso #6

**Instalar IPA SERVER**

```
[root@ipa ~]# yum install ipa-server bind-utils
```
Si uno quiere tener ipa con DNS(opcional)
```
[root@ipa ~]# yum install ipa-server-dns bindipa-server  bind-dyndb-ldap
```

## Paso #7

**Habilitar los puertos al firewall**
```
[root@ipa ~]# for SERVICES in ntp http https ldap ldaps kerberos kpasswd dns; do firewall-cmd --permanent --add-service=$SERVICES; done

[root@ipa ~]# firewall-cmd --reload
```

