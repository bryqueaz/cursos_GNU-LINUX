## Telnet 

Esta herramienta no sirve para validar si hay comunicación TCP y interactura con un servicio

Por ejemplo si ocupamos verificar si hay comunicación del protocolo de SSH(Puerto 22) con un servidor 192.168.8.197

```
bryan@kal-kvm:~$ telnet 192.168.8.197 22
Trying 192.168.8.197...
Connected to 192.168.8.197.
Escape character is '^]'.
SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.7
^]

telnet> quit
Connection closed.

```


## Crear TCP/UDP connections sockets

Para ello va usar el comando NETCAT **nc**

Este ejemplo lo que realiza es una conexion al puerto 80 de google, por lo general se utiliza para validar si se tiene acceso a nivel de RED

```
bryan@kal-kvm:~$ nc -v google.com 80
Connection to google.com 80 port [tcp/http] succeeded!
```
