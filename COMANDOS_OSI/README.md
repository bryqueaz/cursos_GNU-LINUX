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
