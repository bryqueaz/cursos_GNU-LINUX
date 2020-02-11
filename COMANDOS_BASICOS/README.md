# Instalar dicionario de words

**Ejemplos**

* []() **yum install words** -> instala el paquete.
* []()  find /home/student/ -iname *6.mp3 -exec cp {} /home/student/work/ \;

**Buscar contenido en archivos**

* []() cd /usr/share/dict
* []() cat words  | grep -e 'Nick\|bryan' |  sed 's/Nick/John/g' > algo.txt -> busca las palabras bryan o Nick y la palabra Nick la reemplaza por John
* []()  sed -n 12,18p  algo.txt  -> muestra las lineas de 12 a 18
* []()  df -hT | awk '{print  "file system " $1  " -----> size: "  $4}' . -> Parsea informacion y la concatena
* []() hostnamectl  | awk -F : '/Operating System/ {print $2}' -> Busca la version del OS y la separa por :
