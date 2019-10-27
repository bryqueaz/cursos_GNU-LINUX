# Consulta de información de red en GNU/Linux

## Comando de consulta - Capa física ( Capa 1) 

Los comandos para validar el estado del enlace fisico: **ip link show**.
Importante mencionar que si tiene la Interfaz de red conectada al servidor debe teber un estado **state UP**
```
bryan@lvm:~$ ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:3b:7c:9b brd ff:ff:ff:ff:ff:ff

```

Permite ver estado de la negociacion de capa fisica 

Se describe los puntos más importante para ver el estado usando el comando: **ethtool enp0s3**
```
bryan@lvm:~$ ethtool enp0s3
Settings for enp0s3:
	Supported ports: [ TP ]
	Supported link modes:   10baseT/Half 10baseT/Full 
	                        100baseT/Half 100baseT/Full 
	                        1000baseT/Full 
	Supported pause frame use: No
	Supports auto-negotiation: Yes
	Advertised link modes:  10baseT/Half 10baseT/Full 
	                        100baseT/Half 100baseT/Full 
	                        1000baseT/Full 
	Advertised pause frame use: No
	Advertised auto-negotiation: Yes
	Speed: 1000Mb/s
	Duplex: Full
	Port: Twisted Pair
	PHYAD: 0
	Transceiver: internal
	Auto-negotiation: on
	MDI-X: off (auto)
Cannot get wake-on-lan settings: Operation not permitted
	Current message level: 0x00000007 (7)
			       drv probe link
	Link detected: yes

```
Puntos a validar:

* []() Supports auto-negotiation: Yes  -> Tipo de negociación con el otro dispositivo de red
* []() Speed: 1000Mb/s -> Velocidad de la interfaz
* []() Duplex: Full   -> Tipo de enlace Full(transmision y recepción simultanea) Half(sin transmisión simultanea)
* []() Link detected: yes -> Link detectado

Permite ubicar a nivel fisico la interfaz por que la pone a parpadear
**ethtool -p {nombre interfaz}**

```
 ethtool -p enp3s0
 
```

## Comando de consulta - Capa de enlace de datos ( Capa 2) 

Los comandos para validar el estado del enlace logico por medio de la MAC de la NIC de red
Permite listar la dirección MAC de todas las intrefaces de red: **ip maddress**

```
bryan@lvm:~$ ip maddress 
1:	lo
	inet  224.0.0.1
	inet6 ff02::1
	inet6 ff01::1
2:	enp0s3
	link  33:33:00:00:00:01
	link  01:00:5e:00:00:01
	link  33:33:ff:3b:7c:9b
	inet  224.0.0.1
	inet6 ff02::1:ff3b:7c9b
	inet6 ff02::1
	inet6 ff01::1
```
Permite listar la tabla arp del equipo la cual nos permite ubicar un equipo por su red comunicandonos por medio de la dirección MAC: **arp**

```
bryan@lvm:~$ arp
Address                  HWtype  HWaddress           Flags Mask            Iface
192.168.8.85             ether   f6:43:36:b1:cc:4f   C                     enp0s3
router                   ether   6c:3b:6b:f3:25:c9   C                     enp0s3
192.168.8.16             ether   38:c9:86:37:32:47   C                     enp0s3

```
## Comando de consulta - Capa de red ( Capa 3) 

Los comandos para validar el estado y el direcionamineto de los enlaces de red

Permite listar la dirección MAC de todas las intrefaces de red: **ip address show**

```
bryan@lvm:~$ ip add show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:3b:7c:9b brd ff:ff:ff:ff:ff:ff
    inet 192.168.8.12/24 brd 192.168.8.255 scope global enp0s3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe3b:7c9b/64 scope link 
       valid_lft forever preferred_lft forever

```

Permite conocer nuestra puerta de enlace: **netstat -rn**

```
bryan@lvm:~$ netstat -rn
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
0.0.0.0         192.168.8.1     0.0.0.0         UG        0 0          0 enp0s3
192.168.8.0     0.0.0.0         255.255.255.0   U         0 0          0 enp0s3

```

Permite listar todas las redes conectadas y la puerta de enlace: **ip route show**

```
bryan@lvm:~$ ip route show
default via 192.168.8.1 dev enp0s3 
192.168.8.0/24 dev enp0s3  proto kernel  scope link  src 192.168.8.12 

```

## Comando de consulta - Capa de transporte ( Capa 4) 

Los comandos para validar el estado y el direcionamineto de los enlaces de capa de transporte

Permite listar puertos utilizados en nuestro equipo, tanto de **entrada** como de **salida**: **netstat -anp**


* []() **-a** --> muestra todas los socket conectados
* []() **-n** --> no resuelve
* []() **-p** -->  muestra el PID y el nombre del programa

```
root@kal-kvm:~# netstat -anp 
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 192.168.122.1:53        0.0.0.0:*               LISTEN      2078/dnsmasq    
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      1238/sshd       
tcp        0      0 127.0.0.1:3350          0.0.0.0:*               LISTEN      1284/xrdp-sesman
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN      3631/cupsd      
tcp        0      0 192.168.8.85:42427      0.0.0.0:*               LISTEN      8490/dleyna-rendere
tcp        0      0 0.0.0.0:3389            0.0.0.0:*               LISTEN      1267/xrdp       
tcp        0      0 127.0.0.1:18083         0.0.0.0:*               LISTEN      1322/vboxwebsrv 
tcp        0      0 192.168.8.85:22         192.168.8.16:62073      ESTABLISHED 8596/sshd: bryan [p
tcp6       0      0 :::22                   :::*                    LISTEN      1238/sshd       
tcp6       0      0 ::1:631                 :::*                    LISTEN      3631/cupsd      

```

Permite listar puertos de red que estan escuchando trafico en nuestro equipo: **netstat -pltu**

* []() **-a** -->  muestra todas los socket conectados
* []() **-p** -->  muestra el PID y el nombre del programa
* []() **-l** -->  muestra los sockets que escuchan el servers
* []() **-t** -->  muestra las conexiones TCP
* []() **-u** -->  muestra las conexiones UDP

```
root@kal-kvm:~# netstat -apltu  
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 kal-kvm:domain          *:*                     LISTEN      2078/dnsmasq    
tcp        0      0 *:ssh                   *:*                     LISTEN      1238/sshd       
tcp        0      0 localhost:3350          *:*                     LISTEN      1284/xrdp-sesman
tcp        0      0 localhost:ipp           *:*                     LISTEN      3631/cupsd      
tcp        0      0 kal-kvm:42427           *:*                     LISTEN      8490/dleyna-rendere
tcp        0      0 *:3389                  *:*                     LISTEN      1267/xrdp       
tcp        0      0 localhost:18083         *:*                     LISTEN      1322/vboxwebsrv 
tcp        0      0 kal-kvm:35306           192.168.8.11:7676       TIME_WAIT   -               
tcp        0    188 kal-kvm:ssh             192.168.8.16:62073      ESTABLISHED 8596/sshd: bryan [p
tcp6       0      0 [::]:ssh                [::]:*                  LISTEN      1238/sshd       
tcp6       0      0 ip6-localhost:ipp       [::]:*                  LISTEN      3631/cupsd 
```

# Permite hacer calculos de red.

Con la siguiente herramienta nos permite calcular la red: 

* []() **Debian/Ubuntu** -> apt-get install ipcalc
* []() **CentOS/RHEL**   -> yum install ipcalc

Ejemplo Class C

* []() ipcalc 192.168.8.19/24
* []() ipcalc 192.168.8.19


```
bryan@lvm:~$ ipcalc 192.168.8.19/24

Address:   192.168.8.19         11000000.10101000.00001000. 00010011
Netmask:   255.255.255.0 = 24   11111111.11111111.11111111. 00000000
Wildcard:  0.0.0.255            00000000.00000000.00000000. 11111111
=>
Network:   192.168.8.0/24       11000000.10101000.00001000. 00000000
HostMin:   192.168.8.1          11000000.10101000.00001000. 00000001
HostMax:   192.168.8.254        11000000.10101000.00001000. 11111110
Broadcast: 192.168.8.255        11000000.10101000.00001000. 11111111
Hosts/Net: 254                   Class C, Private Internet

```
Ejemplo Class A

```
bryan@lvm:~$ ipcalc 10.122.3.116

perl: warning: Falling back to a fallback locale ("en_US.UTF-8").
Address:   10.122.3.116         00001010.01111010.00000011. 01110100
Netmask:   255.255.255.0 = 24   11111111.11111111.11111111. 00000000
Wildcard:  0.0.0.255            00000000.00000000.00000000. 11111111
=>
Network:   10.122.3.0/24        00001010.01111010.00000011. 00000000
HostMin:   10.122.3.1           00001010.01111010.00000011. 00000001
HostMax:   10.122.3.254         00001010.01111010.00000011. 11111110
Broadcast: 10.122.3.255         00001010.01111010.00000011. 11111111
Hosts/Net: 254                   Class A, Private Internet

```

Ejemplo Class B

```
bryan@lvm:~$ ipcalc 172.0.0.0/8
Address:   172.0.0.0            10101100. 00000000.00000000.00000000
Netmask:   255.0.0.0 = 8        11111111. 00000000.00000000.00000000
Wildcard:  0.255.255.255        00000000. 11111111.11111111.11111111
=>
Network:   172.0.0.0/8          10101100. 00000000.00000000.00000000
HostMin:   172.0.0.1            10101100. 00000000.00000000.00000001
HostMax:   172.255.255.254      10101100. 11111111.11111111.11111110
Broadcast: 172.255.255.255      10101100. 11111111.11111111.11111111
Hosts/Net: 16777214              Class B, In Part Private Internet

```







