## Crear TCP/UDP connections sockets

Para ello va usar el comando NETCAT **nc**

Este ejemplo lo que realiza es una conexion al puerto 80 de google, por lo general se utiliza para validar si se tiene acceso a nivel de RED

```
bryan@kal-kvm:~$ nc -v google.com 80
Connection to google.com 80 port [tcp/http] succeeded!
```
