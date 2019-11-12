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

## Comentar las lineas /etc/network/interfaces

* []() #auto lo
* []() #iface lo inet loopback
* []() ##auto enp0s3
* []() ##iface enp0s3 inet dhcp

## Deshabilitar network

* []() systemctl status networking.service
* []() systemctl stop networking.service
* []() systemctl disable networking.service
* []() systemctl mask networking.service // mask el servicio 

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

Ejemplo nmcli configuracion completa

```
root@kal:~# nmcli connection add con-name static autoconnect yes ifname enp0s3 type ethernet -- ipv4.method manual ipv4.addresses 192.168.8.216/24 ipv4.gateway 192.168.8.1 ipv4.dns 8.8.8.8
Connection 'static' (da33bf64-dc38-49e4-8b2c-c2ba32486078) successfully added.

```

Opcional --  Otra manera es si a uno se le olvida los parametros, la crea por default por dhcp


```
root@kal:~# nmcli connection add con-name static autoconnect yes ifname enp0s3 type ethernet
Connection 'static' (da33bf64-dc38-49e4-8b2c-c2ba32486078) successfully added.

```

Opcional -- Despues se cambia a estatica de manera usando **nmtui**

```
root@lvm:~# nmtui
```

Otro Ejemplo

Se crea la conexion **nmcli connection add**

```
[root@centos7minimal ~]# nmcli connection add con-name pruebas autoconnect yes ifname enp0s3 type ethernet -- ipv4.method manual ipv4.addresses 192.168.8.28/24 ipv4.gateway 192.168.8.1 ipv4.dns 8.8.8.8
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

Recordar que si se hace este metodo se debe tener acceso fisico al equipo.

```
nmcli connection down static
nmcli connection up static
```
## Modificar la conexion con NetworkManager 

Se usa el comando **nmcli connection modify**

```
nmcli connection modify pruebas ipv4.dns 1.1.1.1
```

Para aplicar el cambio **nmcli connection up**

```
[root@centos7minimal ~]# nmcli connection up pruebas 
Connection successfully activated (D-Bus active path: /org/freedesktop/NetworkManager/ActiveConnection/2)
```

## Crear rutas volatil para host

Una ruta para poder alcanzar un host

```
root@lvm:~# route add -host 10.0.1.6 gw 192.168.8.1
root@lvm:~# ip route 
```

##  Borrar rutas volatil para host

```
root@lvm:~# route  del -host 10.0.1.6 gw 192.168.8.1
root@lvm:~# ip route 
```

## Crear rutas volatil para red

```
root@lvm:~# route add -net 172.16.0.0 netmask 255.255.0.0 gw 192.168.8.1
root@lvm:~# ip route 
```

##  Borrar rutas volatil para red

```
root@lvm:~# route del -net 172.16.0.0 netmask 255.255.0.0 gw 192.168.8.1
root@lvm:~# ip route 
```

## Crear y borrar rutas volatil para host y red

Otra manera de agregar rutas, las dos maneras son funcionales

* []() **Crea Host:** ip route add 10.0.1.3 via 192.168.10.1 dev enp0s3 
* []() **Borra host:** ip route del 10.0.1.3 via 192.168.10.1 dev enp0s3 
* []() **Crea red:** ip route add 192.0.2.0/24 via 192.168.8.1  dev enp0s3
* []() **Borra red:** ip route del 192.0.2.0/24 via 192.168.8.1  dev enp0s3


## Rutas persistente Ubuntu

Se debe editar el archivo

vim /etc/network/interfaces

```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto enp0s3
iface enp0s3 inet static
address 192.168.8.197
netmask 255.255.255.0
gateway 192.168.10.24
dns-nameservers 8.8.8.8 4.4.4.4
# Rutas
up route add -host 192.168.8.101 gw 192.168.8.1
up route add -net 172.28.0.0 netmask 255.255.0.0 gw 192.168.8.1
post-up route add -host 10.0.1.4  gw 192.168.8.1

```

## Rutas persistente usando NetworkManager CentOS7 y RHEL7

Para agregar RED

```
nmcli connection modify pruebas +ipv4.routes "172.8.1.0/24 192.168.8.1"

```

Para eliminar RED

```
nmcli connection modify pruebas -ipv4.routes "172.8.1.0/24 192.168.8.1"

```

Para  agregar host

```
nmcli connection modify pruebas +ipv4.routes "172.8.1.5 192.168.8.1"

```

Para  eliminar  host

```
nmcli connection modify pruebas -ipv4.routes "172.8.1.5 192.168.8.1"

```
Para cargar la rutas, se debe conectar con la nueva IP

```
root@lvm:~# nmcli connection up pruebas 

```
Verificar las rutas, se recuerda que anteriormente se borraron

```
root@lvm:~# ip route 
default via 192.168.8.1 dev enp0s3  proto static  metric 100 
172.8.1.0/24 via 192.168.8.1 dev enp0s3  proto static  metric 100 
172.8.1.5 via 192.168.8.1 dev enp0s3  proto static  metric 100 
192.168.8.0/24 dev enp0s3  proto kernel  scope link  src 192.168.8.28  metric 100 

```



## Archivo de rutas persistente CentOS7 y RHEL7

Ir al archivo vim /etc/sysconfig/network-scripts/route-pruebas2

```
ADDRESS0=172.16.0.0
NETMASK0=255.255.255.0
GATEWAY0=192.168.8.1
ADDRESS1=172.16.1.3
NETMASK1=255.255.255.255
GATEWAY1=192.168.8.1
ADDRESS2=172.16.1.4
NETMASK2=255.255.255.0
GATEWAY2=192.168.8.1
ADDRESS3=172.16.1.4
NETMASK3=255.255.255.255
GATEWAY3=192.168.8.1
ADDRESS4=172.16.1.5
NETMASK4=255.255.255.255
GATEWAY4=192.168.8.1
ADDRESS5=172.8.1.5
NETMASK5=255.255.255.255
GATEWAY5=192.168.8.1
ADDRESS6=172.8.1.6
NETMASK6=255.255.255.255
GATEWAY6=192.168.8.1
ADDRESS7=10.122.2.111
NETMASK7=255.255.255.255
GATEWAY7=192.168.8.1

```
## Configurar un bridge para ello se debe incluir una interface de red extra con nat Debian ó Ubuntu

Editar el archivo vim /etc/network/interfaces
```
# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
##auto enp0s3

##iface enp0s3 inet static

# Bridge between enp0s3 and enp0s8
auto br0
#iface br0 inet dhcp
iface br0 inet static

address 192.168.8.197
netmask 255.255.255.0
gateway 192.168.8.1
dns-nameservers 8.8.8.8 4.4.4.4
up route add -host 192.168.8.101 gw 192.168.8.1
up route add -net 172.28.0.0 netmask 255.255.0.0 gw 192.168.8.1
post-up route add -host 10.0.1.4  gw 192.168.8.1
bridge_ports enp0s3  enp0s8
bridge_stp off
bridge_fd 0
bridge_maxwait 0

```
Reiniciar el servicio de red o reiniciar el servidor por que puede dar error

```
root@lvm:~# systemctl restart networking.service 
Job for networking.service failed because the control process exited with error code. See "systemctl status networking.service" and "journalctl -xe" for details.

```


Verificar la creación de bridge

```
root@lvm:~# brctl show
bridge name	bridge id		STP enabled	interfaces
br0		8000.0800273b7c9b	no		enp0s3
							        enp0s8
```





