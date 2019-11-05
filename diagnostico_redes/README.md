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

**Ejemplo #1** - Para conocer los puertos abiertos de un equipo **nmap -v -A**

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
**Ejemplo #2** - Para conocer los equipos que responden a ping **nmap -sP**

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

**Ejemplo #3** - Verifique y escanee puertos abiertos **nmap  192.168.8.0/24**

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

**Ejemplo #4** - Identificar la el OS **nmap -O**

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

**Ejemplo #5** - Escanea los puertos TCP/UDP **nmap -sS -sU -PN**


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

## TCPDUMP herramienta para analizar paquetes de red

**Ejemplo #1 Escuchar la conexión de un equipo que se conecta via SSH, se puede visualizar los paquetes**

```
root@lvm:~# tcpdump -n ip host 192.168.8.29
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on br0, link-type EN10MB (Ethernet), capture size 262144 bytes
17:21:02.898546 IP 192.168.8.29.51406 > 192.168.8.197.22: Flags [S], seq 3277030250, win 29200, options [mss 1460,sackOK,TS val 12361109 ecr 0,nop,wscale 7], length 0
17:21:02.898586 IP 192.168.8.197.22 > 192.168.8.29.51406: Flags [S.], seq 3756513246, ack 3277030251, win 28960, options [mss 1460,sackOK,TS val 2531796 ecr 12361109,nop,wscale 7], length 0
17:21:02.898763 IP 192.168.8.29.51406 > 192.168.8.197.22: Flags [.], ack 1, win 229, options [nop,nop,TS val 12361118 ecr 2531796], length 0
17:21:02.899519 IP 192.168.8.29.51406 > 192.168.8.197.22: Flags [P.], seq 1:22, ack 1, win 229, options [nop,nop,TS val 12361118 ecr 2531796], length 21
17:21:02.899535 IP 192.168.8.197.22 > 192.168.8.29.51406: Flags [.], ack 22, win 227, options [nop,nop,TS val 2531796 ecr 12361118], length 0
17:21:02.909702 IP 192.168.8.197.22 > 192.168.8.29.51406: Flags [P.], seq 1:42, ack 22, win 227, options [nop,nop,TS val 2531798 ecr 12361118], length 41
17:21:02.910029 IP 192.168.8.29.51406 > 192.168.8.197.22: Flags [.], ack 42, win 229, options [nop,nop,TS val 12361129 ecr 2531798], length 0
17:21:02.910497 IP 192.168.8.29.51406 > 192.168.8.197.22: Flags [P.], seq 22:1518, ack 42, win 229, options [nop,nop,TS val 12361129 ecr 2531798], length 1496
17:21:02.910511 IP 192.168.8.197.22 > 192.168.8.29.51406: Flags [.], ack 1518, win 250, options [nop,nop,TS val 2531799 ecr 12361129], length 0
17:21:02.910964 IP 192.168.8.197.22 > 192.168.8.29.51406: Flags [P.], seq 42:1018, ack 1518, win 250, options [nop,nop,TS val 2531799 ecr 12361129], length 976
17:21:02.915211 IP 192.168.8.29.51406 > 192.168.8.197.22: Flags [P.], seq 1518:1566, ack 1018, win 244, options [nop,nop,TS val 12361131 ecr 2531799], length 48
17:21:02.920515 IP 192.168.8.197.22 > 192.168.8.29.51406: Flags [P.], seq 1018:1382, ack 1566, win 250, options [nop,nop,TS val 2531801 ecr 12361131], length 364
17:21:02.959860 IP 192.168.8.29.51406 > 192.168.8.197.22: Flags [.], ack 1382, win 259, options [nop,nop,TS val 12361180 ecr 2531801], length 0


```

**Ejemplo #2 Escuchar la conexion y poder ver parte del contenido si esta cifrado no se puede visualizar**

```
root@lvm:~# tcpdump -s 2000 -Aa ip host 192.168.8.29
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on br0, link-type EN10MB (Ethernet), capture size 2000 bytes
17:23:47.892335 IP 192.168.8.29.51408 > 192.168.8.197.ssh: Flags [S], seq 1660636153, win 29200, options [mss 1460,sackOK,TS val 12530069 ecr 0,nop,wscale 7], length 0
E..<zl@.@...............b.K.......r............
..1.........
17:23:47.892378 IP 192.168.8.197.ssh > 192.168.8.29.51408: Flags [S.], seq 642327404, ack 1660636154, win 28960, options [mss 1460,sackOK,TS val 2573044 ecr 12530069,nop,wscale 7], length 0
E..<..@.@...............&I#lb.K...q .a.........
.'B...1.....
17:23:47.892548 IP 192.168.8.29.51408 > 192.168.8.197.ssh: Flags [.], ack 1, win 229, options [nop,nop,TS val 12530074 ecr 2573044], length 0
E..4zm@.@..$............b.K.&I#m...........
..1..'B.
17:23:47.893281 IP 192.168.8.29.51408 > 192.168.8.197.ssh: Flags [P.], seq 1:22, ack 1, win 229, options [nop,nop,TS val 12530075 ecr 2573044], length 21
E..Izn@.@...............b.K.&I#m...........
..1..'B.SSH-2.0-OpenSSH_7.4

17:23:47.893295 IP 192.168.8.197.ssh > 192.168.8.29.51408: Flags [.], ack 22, win 227, options [nop,nop,TS val 2573044 ecr 12530075], length 0
E..4a.@.@.F.............&I#mb.L......Y.....
.'B...1.
17:23:47.901872 IP 192.168.8.197.ssh > 192.168.8.29.51408: Flags [P.], seq 1:42, ack 22, win 227, options [nop,nop,TS val 2573045 ecr 12530075], length 41
E..]a.@.@.F.............&I#mb.L............
.'B...1.SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.7

17:23:47.902244 IP 192.168.8.29.51408 > 192.168.8.197.ssh: Flags [.], ack 42, win 229, options [nop,nop,TS val 12530084 ecr 2573045], length 0
E..4zo@.@.."............b.L.&I#......U.....
..1..'B.


```

**Ejemplo #3 Escuchar la conexion de un equipo en rango de puertos usando una interfaz especifica**

```
root@lvm:~# tcpdump  -nn ip host 192.168.8.29 and portrange 22-162 -i br0
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on br0, link-type EN10MB (Ethernet), capture size 262144 bytes
17:26:30.582406 IP 192.168.8.29.51408 > 192.168.8.197.22: Flags [P.], seq 1660638567:1660638603, ack 642331122, win 290, options [nop,nop,TS val 12696671 ecr 2573630], length 36
17:26:30.583107 IP 192.168.8.197.22 > 192.168.8.29.51408: Flags [P.], seq 1:37, ack 36, win 295, options [nop,nop,TS val 2613717 ecr 12696671], length 36
17:26:30.583425 IP 192.168.8.29.51408 > 192.168.8.197.22: Flags [.], ack 37, win 290, options [nop,nop,TS val 12696672 ecr 2613717], length 0
17:26:30.860945 IP 192.168.8.29.51408 > 192.168.8.197.22: Flags [P.], seq 36:72, ack 37, win 290, options [nop,nop,TS val 12696956 ecr 2613717], length 36
17:26:30.861256 IP 192.168.8.197.22 > 192.168.8.29.51408: Flags [P.], seq 37:73, ack 72, win 295, options [nop,nop,TS val 2613786 ecr 12696956], length 36
17:26:30.861576 IP 192.168.8.29.51408 > 192.168.8.197.22: Flags [.], ack 73, win 290, options [nop,nop,TS val 12696957 ecr 2613786], length 0
17:26:31.119842 IP 192.168.8.29.51408 > 192.168.8.197.22: Flags [P.], seq 72:108, ack 73, win 290, options [nop,nop,TS val 12697221 ecr 2613786], length 36
17:26:31.120128 IP 192.168.8.197.22 > 192.168.8.29.51408: Flags [P.], seq 73:109, ack 108, win 295, options [nop,nop,TS val 2613851 ecr 12697221], length 36
17:26:31.120425 IP 192.168.8.29.51408 > 192.168.8.197.22: Flags [.], ack 109, win 290, options [nop,nop,TS val 12697222 ecr 2613851], length 0
17:26:31.244496 IP 192.168.8.29.51408 > 192.168.8.197.22: Flags [P.], seq 108:144, ack 109, win 290, options [nop,nop,TS val 12697349 ecr 2613851], length 36
17:26:31.244776 IP 192.168.8.197.22 > 192.168.8.29.51408: Flags [P.], seq 109:145, ack 144, win 295, options [nop,nop,TS val 2613882 ecr 12697349], length 36
17:26:31.245033 IP 192.168.8.29.51408 > 192.168.8.197.22: Flags [.], ack 145, win 290, options [nop,nop,TS val 12697349 ecr 2613882], length 0
17:26:31.735951 IP 192.168.8.29.51408 > 192.168.8.197.22: Flags [P.], seq 144:180, ack 145, win 290, options [nop,nop,TS val 12697852 ecr 2613882], length 36
17:26:31.736869 IP 192.168.8.197.22 > 192.168.8.29.51408: Flags [P.], seq 145:189, ack 180, win 295, options [nop,nop,TS val 2614005 ecr 12697852], length 44
17:26:31.737141 IP 192.168.8.29.51408 > 192.168.8.197.22: Flags [.], ack 189, win 290, options [nop,nop,TS val 12697853 ecr 2614005], length 0
17:26:31.739636 IP 192.168.8.197.22 > 192.168.8.29.51408: Flags [P.], seq 189:365, ack 180, win 295, options [nop,nop,TS val 2614006 ecr 12697853], length 176
17:26:31.739921 IP 192.168.8.29.51408 > 192.168.8.197.22: Flags [.], ack 365, win 305, options [nop,nop,TS val 12697856 ecr 2614006], length 0
17:26:31.740174 IP 192.168.8.29.51408 > 192.168.8.197.22: Flags [P.], seq 180:216, ack 365, win 305, options [nop,nop,TS val 12697856 ecr 2614006], length 36
17:26:31.740337 IP 192.168.8.29.51408 > 192.168.8.197.22: Flags [P.], seq 216:276, ack 365, win 305, options [nop,nop,TS val 12697857 ecr 2614006], length 60
17:26:31.740487 IP 192.168.8.29.51408 > 192.168.8.197.22: Flags [F.], seq 276, ack 365, win 305, options [nop,nop,TS val 12697857 ecr 2614006], length 0
17:26:31.740782 IP 192.168.8.197.22 > 192.168.8.29.51408: Flags [.], ack 277, win 295, options [nop,nop,TS val 2614006 ecr 12697856], length 0
17:26:31.748446 IP 192.168.8.197.22 > 192.168.8.29.51408: Flags [F.], seq 365, ack 277, win 295, options [nop,nop,TS val 2614008 ecr 12697856], length 0
17:26:31.748747 IP 192.168.8.29.51408 > 192.168.8.197.22: Flags [.], ack 366, win 305, options [nop,nop,TS val 12697865 ecr 2614008], length 0
```
