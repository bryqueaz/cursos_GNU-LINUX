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

## Paso #8 

**Configurar el server de IPA de manera desantendida**

Ejecutamos las siguinetes lineas para definir de manera volatil los valores de las variables para la instalación:

```
[root@ipa ~]# IP_ADDR=192.168.8.84
[root@ipa ~]# DOMAIN=greencore.local
[root@ipa ~]# HOSTNAME=ipa.greencore.local
[root@ipa ~]# SHORTNAME=ipa
[root@ipa ~]# REALM=GREENCORE.LOCAL
```
**Inicia la instalación**
```
[root@ipa ~]# ipa-server-install --domain=$DOMAIN --realm=$REALM --ds-password=password --admin-password=password --hostname=$HOSTNAME --ip-address=$IP_ADDR --unattended
```

## Paso #9

**Probar la conexion**
```
[root@ipa ~]# getent passwd admin
admin:*:1756200000:1756200000:Administrator:/home/admin:/bin/bash
```
**Realizar una conexión**

 Deber dar un error de /home/admin no existe, esta bien que error lo muestre.
 Probar conectar desde otro equipo

```
[root@ipa ~]# ssh admin@ipa.greencore.local 
```
Para eliminar el error del home del usuario se debe crear manual, o bien crear con autofs
```
[root@ipa ~]# cd /home
[root@ipa ~]# mkdir  admin
[root@ipa ~]#chown admin admin/
```
## Paso #10

**Creamos una sesión de Kerberos para finalizar con la configuración, via comandos**
```
[root@ipa ~]# kinit admin
```

## Paso #11

**Creamos un usuario**

```
[root@ipa ~]# ipa user-add blaster --first=coronado --last=dulce
```

```
[root@ipa ~]# ipa user-add kal --first=kal --last=kal
```

```
[root@ipa ~]# ipa user-add bryqueaz --first=bryqueaz --last=bryqueaz
```

## Paso #12

**Buscar con ldapsearch**

* []() **dn** es el nombre de la entrada; no es un atributo ni tampoco parte de la entrada. “cn=John Doe” es el nombre distinguido relativo
* []() **dc** es para domain component (componente de dominio)
* []() **sn**  para surname (apellido)
* []() **cn** para common name (nombre común),


Ejemplo #1
```
[root@ipa ~]# ldapsearch -x cn=kal -b dc=greencore,dc=local
```
Ejemplo #2
```
[root@ipa ~]# ldapsearch -x uid=bryqueaz -b dc=greencore,dc=local
```
Ejemplo #3

```
[root@ipa ~]# ldapsearch  -x  uid=admin -b dc=greencore,dc=local  -H ldaps://ipa.greencore.local -D "uid=admin,cn=users,cn=accounts,dc=greencore,dc=local" -W 
Enter LDAP Password: 
```


## Paso #13

**Cambiar constraseña**
```
[root@ipa ~]# ipa passwd blaster
```
## Paso #14

Ingresar via web, con el usuario admin y a contraseña definida en el paso de instalación
* []() https://ipa.greencore.local/
