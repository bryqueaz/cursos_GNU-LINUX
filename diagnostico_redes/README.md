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
echo "get index.html" > hola.txt

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

**Ejemplo #3 -  Servidor/Cliente**

Crear un **Servidor** en una sesión nueva

* []() -l para crear un server
* []() -k si el cliente cierra la conexion no cierre el socket
* []() 1234 es el puerto que se crea 

```
root@lvm:~# nc -k -l 1234
hola cliente 

```

Crear un **Cliente** en una sesión nueva, y poder transferir información
```
root@lvm:~# nc  127.0.0.1 1234
hola cliente

```
Transferir información dal Servidor, se pueden enviar la información de un archivo una foto, etc

```
root@lvm:~# cat hola.txt | nc  127.0.0.1 1234
root@lvm:~# 

```

## Herramienta de diagnóstico para administradores de red 

Herramienta llamada nmap, en caso si no esta se debe instalar

* []() Ubuntu/Debian **apt-get install nmap**
* []() Centos/Redhat **yum install nmap**

Ejemplo #1 - Para conocer los puertos abiertos de un equipo **nmap -v -A**

```
root@lvm:~# nmap -v -A 192.168.8.1

Starting Nmap 7.01 ( https://nmap.org ) at 2019-11-05 16:51 CST
NSE: Loaded 132 scripts for scanning.
NSE: Script Pre-scanning.
Initiating NSE at 16:51
Completed NSE at 16:51, 0.00s elapsed
Initiating NSE at 16:51
Completed NSE at 16:51, 0.00s elapsed
Initiating ARP Ping Scan at 16:51
Scanning 192.168.8.1 [1 port]
Completed ARP Ping Scan at 16:51, 0.19s elapsed (1 total hosts)
Initiating Parallel DNS resolution of 1 host. at 16:51
Completed Parallel DNS resolution of 1 host. at 16:51, 6.55s elapsed
Initiating SYN Stealth Scan at 16:51
Scanning 192.168.8.1 [1000 ports]
Discovered open port 80/tcp on 192.168.8.1
Discovered open port 53/tcp on 192.168.8.1
Discovered open port 22/tcp on 192.168.8.1
Discovered open port 2000/tcp on 192.168.8.1
Discovered open port 8291/tcp on 192.168.8.1
Completed SYN Stealth Scan at 16:51, 1.22s elapsed (1000 total ports)
Initiating Service scan at 16:51
Scanning 5 services on 192.168.8.1
```
Ejemplo #2 - Para conocer los equipos que responden a ping **nmap -sP**

```
root@lvm:~# nmap -sP 192.168.8.0/24

Starting Nmap 7.01 ( https://nmap.org ) at 2019-11-05 16:56 CST
Nmap scan report for 192.168.8.1
Host is up (0.00021s latency).
MAC Address: 6C:3B:6B:F3:25:C9 (Unknown)
Nmap scan report for 192.168.8.19
Host is up (-0.063s latency).
MAC Address: D0:27:00:14:E0:38 (Unknown)
Nmap scan report for 192.168.8.29
Host is up (-0.10s latency).
MAC Address: 08:00:27:90:F3:C4 (Oracle VirtualBox virtual NIC)
Nmap scan report for 192.168.8.85
Host is up (0.00025s latency).
MAC Address: F6:43:36:B1:CC:4F (Unknown)
Nmap scan report for 192.168.8.197
Host is up.
Nmap done: 256 IP addresses (5 hosts up) scanned in 26.07 seconds

```

Ejemplo #3 - Verifique y escanee puertos abiertos **nmap  192.168.8.0/24**

```
root@lvm:~# nmap  192.168.8.0/24

Starting Nmap 7.01 ( https://nmap.org ) at 2019-11-05 17:04 CST
Nmap scan report for 192.168.8.1
Host is up (0.00045s latency).
Not shown: 995 closed ports
PORT     STATE SERVICE
22/tcp   open  ssh
53/tcp   open  domain
80/tcp   open  http
2000/tcp open  cisco-sccp
8291/tcp open  unknown
MAC Address: 6C:3B:6B:F3:25:C9 (Unknown)

Nmap scan report for 192.168.8.13
Host is up (0.0074s latency).
All 1000 scanned ports on 192.168.8.13 are closed
MAC Address: 0C:70:4A:62:26:F8 (Unknown)

Nmap scan report for 192.168.8.16
Host is up (-0.099s latency).
All 1000 scanned ports on 192.168.8.16 are filtered
MAC Address: F0:43:47:E4:7F:11 (Unknown)

Nmap scan report for 192.168.8.29
Host is up (0.00039s latency).
Not shown: 999 filtered ports
PORT   STATE SERVICE
22/tcp open  ssh
MAC Address: 08:00:27:90:F3:C4 (Oracle VirtualBox virtual NIC)

Nmap scan report for 192.168.8.85
Host is up (0.00019s latency).
Not shown: 998 closed ports
PORT     STATE SERVICE
22/tcp   open  ssh
3389/tcp open  ms-wbt-server
MAC Address: F6:43:36:B1:CC:4F (Unknown)

Nmap scan report for 192.168.8.197
Host is up (0.000015s latency).
Not shown: 999 closed ports
PORT   STATE SERVICE
22/tcp open  ssh

Nmap done: 256 IP addresses (6 hosts up) scanned in 260.16 seconds

```

Ejemplo #4 - Identificar la el OS **nmap -O**

```
root@lvm:~# nmap -O 192.168.8.197

Starting Nmap 7.01 ( https://nmap.org ) at 2019-11-05 17:05 CST
Nmap scan report for 192.168.8.197
Host is up (0.000019s latency).
Not shown: 999 closed ports
PORT   STATE SERVICE
22/tcp open  ssh
Device type: general purpose
Running: Linux 3.X
OS CPE: cpe:/o:linux:linux_kernel:3
OS details: Linux 3.12 - 3.19, Linux 3.8 - 3.19
Network Distance: 0 hops

OS detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 10.49 seconds

```

Ejemplo #5 - Escanea los puertos TCP/UDP **nmap -sS -sU -PN**


```
root@lvm:~# nmap -sS -sU -PN 192.168.8.1

Starting Nmap 7.01 ( https://nmap.org ) at 2019-11-05 17:11 CST
Nmap scan report for 192.168.8.1
Host is up (0.00045s latency).
Not shown: 1991 closed ports
PORT     STATE         SERVICE
22/tcp   open          ssh
53/tcp   open          domain
80/tcp   open          http
2000/tcp open          cisco-sccp
8291/tcp open          unknown
53/udp   open          domain
67/udp   open|filtered dhcps
68/udp   open|filtered dhcpc
123/udp  open|filtered ntp
MAC Address: 6C:3B:6B:F3:25:C9 (Unknown)

Nmap done: 1 IP address (1 host up) scanned in 207.01 seconds
```





