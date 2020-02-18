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