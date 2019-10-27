# Consulta de información de red en GNU/Linux

## Comando de consulta - Capa física

Los comandos para validar el estado del enlace fisico: **ip link show**.
Importante mencionar que si tiene la Interfaz de red conectada al servidor debe teber un estado **state UP**
```
bryan@lvm:~$ ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:3b:7c:9b brd ff:ff:ff:ff:ff:ff

```

## Permite ver estado de la negociacion de capa fisica

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

## Permite ubicar a nivel fisico la interfaz por que la pone a parpadear
**ethtool -p {nombre interfaz}**

```
 ethtool -p enp3s0
 
```





