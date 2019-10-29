# Direccionamiento mediante el protocolo de Internet.

Descripción:
En este tema  se vera el uso de direccionamiento por medio de protocolo de Internet en GNU/Linux mediante el configuración de interfaces de red y definición de rutas.

## Configurtacion de Red estatica

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
