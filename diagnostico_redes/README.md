## Telnet 

Esta herramienta no sirve para validar si hay comunicación TCP y interactuar con un servicio

Por ejemplo si ocupamos verificar si hay comunicación del protocolo de SSH(Puerto 22) con un servidor 192.168.8.197

Ejemplo de una conexión satisfatoria

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
Ejemplo de una conexión no satisfatoria

```
bryan@kal-kvm:~$ telnet 192.168.8.197 80
Trying 192.168.8.197...
telnet: Unable to connect to remote host: Connection refused

```

## Crear TCP/UDP connections sockets

Para ello va usar el comando NETCAT **nc**

**Ejemplo #1**
Este ejemplo lo que realiza es una conexion al puerto 80 de google, por lo general se utiliza para validar si se tiene acceso a nivel de RED

```
bryan@kal-kvm:~$ nc -v google.com 80
Connection to google.com 80 port [tcp/http] succeeded!
```
**Ejemplo #2**

Transferir información 

* []() Crear un archivo llamado hola.txt
* []() Incluir el siguiente contenido al archivo: echo "get index.html" > hola.txt 
* []() Realizar una solicitud a google haciendo el get: cat hola.txt  | nc -v google.com 80

```

root@lvm:~# touch hola.txt 
echo "get index.html" > hola1.txt

root@lvm:~# cat hola.txt  | nc -v google.com 80
Connection to google.com 80 port [tcp/http] succeeded!
HTTP/1.0 400 Bad Request
Content-Type: text/html; charset=UTF-8
Referrer-Policy: no-referrer
Content-Length: 1555
Date: Tue, 05 Nov 2019 22:21:16 GMT

<!DOCTYPE html>
<html lang=en>
  <meta charset=utf-8>
  <meta name=viewport content="initial-scale=1, minimum-scale=1, width=device-width">
  <title>Error 400 (Bad Request)!!1</title>
  <style>
    *{margin:0;padding:0}html,code{font:15px/22px arial,sans-serif}html{background:#fff;color:#222;padding:15px}body{margin:7% auto 0;max-width:390px;min-height:180px;padding:30px 0 15px}* > body{background:url(//www.google.com/images/errors/robot.png) 100% 5px no-repeat;padding-right:205px}p{margin:11px 0 22px;overflow:hidden}ins{color:#777;text-decoration:none}a img{border:0}@media screen and (max-width:772px){body{background:none;margin-top:0;max-width:none;padding-right:0}}#logo{background:url(//www.google.com/images/branding/googlelogo/1x/googlelogo_color_150x54dp.png) no-repeat;margin-left:-5px}@media only screen and (min-resolution:192dpi){#logo{background:url(//www.google.com/images/branding/googlelogo/2x/googlelogo_color_150x54dp.png) no-repeat 0% 0%/100% 100%;-moz-border-image:url(//www.google.com/images/branding/googlelogo/2x/googlelogo_color_150x54dp.png) 0}}@media only screen and (-webkit-min-device-pixel-ratio:2){#logo{background:url(//www.google.com/images/branding/googlelogo/2x/googlelogo_color_150x54dp.png) no-repeat;-webkit-background-size:100% 100%}}#logo{display:inline-block;height:54px;width:150px}
  </style>
  <a href=//www.google.com/><span id=logo aria-label=Google></span></a>
  <p><b>400.</b> <ins>That’s an error.</ins>
  <p>Your client has issued a malformed or illegal request.  <ins>That’s all we know.</ins>


```




