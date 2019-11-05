# Direccionamiento mediante el protocolo de Internet.

Descripción:
En este tema  se vera el uso de direccionamiento por medio de protocolo de Internet en GNU/Linux mediante el configuración de interfaces de red y definición de rutas.

## Configuración de Red estatica -- Debian ó Ubuntu

Usando networking

Se debe editar el archivo

vim /etc/network/interfaces

```
auto eth0
iface eth0 inet static
address 192.168.10.197
netmask 255.255.255.0
gateway 192.168.10.24
dns-nameservers 8.8.8.8 4.4.4.4

```

## Configuración de Red estatica -- CentOS ó RHEL

Se debe editar el archivo /etc/sysconfig/network-scripts/ifcfg-enp0s3

```
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=none
IPADDR=192.168.8.217
PREFIX=24
GATEWAY=192.168.8.1
DNS1=8.8.8.8
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=enp0s3
UUID=da33bf64-dc38-49e4-8b2c-c2ba32486078
DEVICE=enp0s3
ONBOOT=yes

```

## Verificar si esta activo networking

```
root@kal:~# systemctl status network-manager.service // si usa network manager

● NetworkManager.service - Network Manager
   Loaded: loaded (/lib/systemd/system/NetworkManager.service; enabled; vendor preset: enabled)
   Active: active (running) since Sun 2019-02-17 18:24:50 CST; 8s ago
     Docs: man:NetworkManager(8)
 Main PID: 8638 (NetworkManager)
   CGroup: /system.slice/NetworkManager.service
           └─8638 /usr/sbin/NetworkManager --no-daemon

```
## Para generar un nuevo request de DHCP

```
dhclient -r  enp0s3
dhclient enp0s3

```
## Para instalar network-manager y habilitar 

* []() apt-get install network-manager
* []() systemctl status network-manager.service
* []() systemctl start network-manager.service // inicia el servicio
* []() systemctl enable network-manager.service // habilitar después de un reinicio

## Deshabilitar network

* []() systemctl status networking.service
* []() systemctl stop networking.service
* []() systemctl disable networking.service
* []() systemctl mask networking.service // mask el servicio 

## Comentar las lineas /etc/network/interfaces

* []() #auto lo
* []() #iface lo inet loopback
* []() ##auto enp0s3
* []() ##iface enp0s3 inet dhcp

## Si vamos utilizar network manager 

Crear la conexión manual

* []() con-name = Nombre de la conexión
* []() autoconnect = Levante la conexión después de reiniciar el servidor
* []() ifname = Nombre de la interfaz de red cargada
* []() type = tipo de conexion
* []() ipv4.method = conexion por dhcp,  estatica
* []() ipv4.addresses =  ip v4
* []() ipv4.gateway =  gateway
* []() ipv4.dns  

## Crear la conexion estatica

Se puede usando el cli **nmcli** o gráfico usando con **nmtui**  

Ejemplo nmcli

```
root@kal:~# nmcli connection add con-name static autoconnect yes ifname enp0s3 type ethernet ipv4.method manual ipv4.addresses 192.168.8.216/24 ipv4.gateway 192.168.8.1 ipv4.dns 8.8.8.8
Connection 'static' (da33bf64-dc38-49e4-8b2c-c2ba32486078) successfully added.

```

Otro Ejemplo

Se crea la conexion **nmcli connection add**

```
[root@centos7minimal ~]# nmcli connection add con-name pruebas autoconnect yes ifname enp0s3 type ethernet ipv4.method manual ipv4.addresses 192.168.8.28/24 ipv4.gateway 192.168.8.1 ipv4.dns 8.8.8.8
Connection 'pruebas' (f1283682-7cfe-40d5-a8ef-211a40120741) successfully added.

```

Verifica la conexion de pruebas **nmcli connection show** 

```
[root@centos7minimal ~]# nmcli connection show 
NAME     UUID                                  TYPE      DEVICE 
static   da33bf64-dc38-49e4-8b2c-c2ba32486078  ethernet  enp0s3 
pruebas  f1283682-7cfe-40d5-a8ef-211a40120741  ethernet  -- 

```

Levanta la interfaz **nmcli connection up pruebas**

Después de levantar se va perder conexion por lo tanto se debe conectar usando la IP  nueva

```
[root@centos7minimal ~]# nmcli connection up pruebas 

```

Ejemplo nmtui

```
root@lvm:~# nmtui

```
## Habilitar el control de la interfaces con NetworkManager

```
root@kal:~# nmcli networking on

```

## Luego levantar las interfaces

```
nmcli connection down static
nmcli connection up static
```
## Modificar la conexion con NetworkManager 

Se usa el comando **nmcli connection modify**

```
nmcli connection modify pruebas2 ipv4.dns 1.1.1.1
```

Para aplicar el cambio **nmcli connection up**

```
[root@centos7minimal ~]# nmcli connection up pruebas2 
Connection successfully activated (D-Bus active path: /org/freedesktop/NetworkManager/ActiveConnection/2)
```











