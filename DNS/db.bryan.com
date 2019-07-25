$TTL	604800
$ORIGIN bryan.com.
@	IN	SOA	bryan.com. root.bryan.com. (
          	2019070721   	; Serial
         	604800    	; Refresh
          	86400    	; Retry
        	2419200    	; Expire
         	604800 )	; Negative Cache TTL
;DNS
@		 IN  	NS  	dns1.bryan.com.
dns1.bryan.com.     IN  	A   	10.42.25.166 ; 127.0.0.1
;WWW
bryan.com.			 IN  	A   	10.42.25.166
hercules			 IN  	A   	192.168.8.100
 
;Email
@              		 IN  	MX  	10	mail1.bryan.com.
mail1.bryan.com.     IN  	A   	10.42.25.150
 
;WWW Alias
www.bryan.com. 	 IN  	CNAME   bryan.com.
joomla.bryan.com. 	 IN  	CNAME   bryan.com.
ftp     			 IN 	CNAME   hercules
