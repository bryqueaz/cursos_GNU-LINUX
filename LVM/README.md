# LVM
En este documento se explica como extender, crear y reducir volúmenes lógicos de una m

**Comandos Volúmenes Físicos (PV)**

* []() **pvscan:** escanea todos los dispositivos para la búsqueda de volúmenes físicos.

* []() **pvdisplay:** muestra atributos de un volumen físico.

* []() **pvcreate:** inicializa una partición o disco para ser usado por LVM.

* []() **pvmove:** mover physical extends. Los distribuye en los demás volúmenes físicos.

**Comandos Grupo de Volúmenes (VG)**

* []() **vgscan:** escanea todos los dispositivos para la búsqueda de grupos de volúmenes.

* []() **vgdisplay:** muestra atributos de un grupo de volúmenes.

* []() **vgcreate:** crea un grupo de volúmenes.

* []() **vgextend:** agrega un volumen físico a un grupo de volúmenes.

* []() **vgreduce:** reduce un grupo de volúmenes (remueve un volumen físico)

* []() **vgchange:** cambia los atributos de un grupo de volúmenes.

**Comandos Volúmenes Lógicos (LV)**

* []() **lvscan:** escanea todos los dispositivos para la búsqueda de volúmenes lógicos.

* []() **lvdisplay:** muestra atributos de un volumen lógico.

* []() **lvcreate:** crea un volumen lógico en un grupo de volúmenes existente.

* []() **lvremove:** elimina un volumen lógico. Para realizar esta tarea el mismo no puede estar montado.

* []() **lvreduce:** reduce el tamaño de un volumen lógico.

* []() **lvextend:** aumenta el tamaño de un volumen lógico.


## LVM -  Extender

### Paso #1

* Crear dos particiones primarias o logicas de un 1GB
    * Cada una de ella debe ser tipo LVM

### Ejemplo realizar este proceso dos veces

```powershell
root@ubuntuLVM:~# fdisk /dev/sda

Welcome to fdisk (util-linux 2.27.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): p
Disk /dev/sda: 20 GiB, 21474836480 bytes, 41943040 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x86ef5cd6

Device     Boot  Start      End  Sectors  Size Id Type
/dev/sda1  *      2048   976895   974848  476M 83 Linux
/dev/sda2       976896 28319743 27342848   13G 8e Linux LVM

Command (m for help): n
Partition type
   p   primary (2 primary, 0 extended, 2 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (3,4, default 3): 3
First sector (28319744-41943039, default 28319744):
Last sector, +sectors or +size{K,M,G,T,P} (28319744-41943039, default 41943039): +1G

Created a new partition 3 of type 'Linux' and of size 1 GiB.

Command (m for help): p
Disk /dev/sda: 20 GiB, 21474836480 bytes, 41943040 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x86ef5cd6

Device     Boot    Start      End  Sectors  Size Id Type
/dev/sda1  *        2048   976895   974848  476M 83 Linux
/dev/sda2         976896 28319743 27342848   13G 8e Linux LVM
/dev/sda3       28319744 30416895  2097152    1G 83 Linux

Command (m for help): t
Partition number (1-3, default 3): 3
Partition type (type L to list all types): 8e
Changed type of partition 'Linux' to 'Linux LVM'.

Command (m for help): p

Disk /dev/sda: 20 GiB, 21474836480 bytes, 41943040 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x86ef5cd6

Device     Boot    Start      End  Sectors  Size Id Type
/dev/sda1  *        2048   976895   974848  476M 83 Linux
/dev/sda2         976896 28319743 27342848   13G 8e Linux LVM
/dev/sda3       28319744 30416895  2097152    1G 8e Linux LVM

Command (m for help): w

```

**Para actualizar la tabla de particiones a nivel de OS**

```
root@ubuntuLVM:~#partprobe
```
### Paso #2

Se debe extender el volumen logico de lv_root y lv_var un 1G para cada uno

**Paso 1: Inicializar los PV**

```
root@ubuntuLVM:~# pvcreate /dev/sda5
root@ubuntuLVM:~# pvcreate /dev/sda6
```

**Paso 2: Extender el volumen group greencore_vg**
```
root@ubuntuLVM:~# vgextend greencore_vg  /dev/sda5 /dev/sda6
```
**Paso 3: Extender lv_root y lv_var (Sin reiniciar el server)**

* -L (LogicalVolumeSize): Nos permite establecer el tamaño en unidades tales como M para megabytes, G para gigabytes, T para terabytes, P para petabytes y E para exabytes. Con el signo + el valor se agrega al tamaño real y sin él se toma el valor como absoluto
* -r (Resize): Esta opción es muy importantes y es la que indica que se va a redimensionar el sistema de archivos al mismo tiempo, sin esta opción tendríamos que aplicar un paso extra con el comando resize2fs

```
root@ubuntuLVM:~# lvextend  /dev/greencore_vg/lv_root -L +1G -r (size)
root@ubuntuLVM:~# lvextend  /dev/greencore_vg/lv_var -l +254 -r (extents opcion #2)
root@ubuntuLVM:~# lvextend  /dev/greencore_vg/lv_var -l +100%FREE -r (utiliza el porcentaje disponible libre del VG opcion #3 )
```
## Como crear un LV

### Paso #1 - Crear el LV

* -n: Esta opción se utiliza para asignar el nombre del nuevo volumen lógico, (-n nombre).
* Volumen de grupo: Indicar en cual volumen de grupo vamos a crear el volumen lógico.
* -L (LogicalVolumeSize): Nos permite establecer el tamaño que vamos a asignar al volumen lógico en unidades tales como M para megabytes, G para gigabytes, T para terabytes, P para petabytes y E para exabytes
* -l extends

```
lvcreate -n lv_backup -L  1G vg_greencore   (size)
lvcreate -n lv_backup -l  255 vg_greencore   (extends)
lvcreate -n lv_data vg_greencore -l +100%FREE   (utiliza el porcentaje disponible libre del VG)
```
### Paso #2 - Format ext4 o xfs

```
mkfs.xfs /dev/mapper/greencore_vg-backup
mkfs.ext4 /dev/mapper/greencore_vg-backup   (ejemplo de como se realiza para ext4)
```
### Paso #3 - Crear la ruta donde va estar el punto de montaje
```
mkdir /backup
```
### Paso #4 - Realizar el punto de montaje manual
```
mount /dev/mapper/greencore_vg-backup /backup/ 
```

### Paso #5 - Manera persistente el siguiente reinicio, debe tener cuidado en este punto

* Incluir al /etc/fstab
```
/dev/mapper/greencore_vg-backup  /backup xfs defaults 0 0

```

## Como reducir LVM usando EXT4

**Paso #1**

Identificar cual LV se le va aplicar el reduce

* -L (LogicalVolumeSize): Nos permite establecer el tamaño en unidades tales como M para megabytes, G para gigabytes, T para terabytes, P para petabytes y E para exabytes. Con el signo - el valor se  disminuye al tamaño real y sin él se toma el valor como absoluto
* -r (Resize): Esta opción es muy importantes y es la que indica que se va a redimensionar el sistema de archivos al mismo tiempo, sin esta opción tendríamos que aplicar un paso extra con el comando resize2fs


```
 lvreduce /dev/vg_greencore/lv_backup -L 400M -r
```

## Como reducir LVM usando XFS

Es de ejemplo academico -- "workaround"

En caso mayores si no queremos reinstalar el sistema operativo. Esto puede ser una receta debe tener espacio disponible:

**Paso #1**

Hacer el dump del filesystem

```
xfsdump -l 0 -f /home/bryan/xfs_dump_lvm_data.image /dev/mapper/vg_greencore-lv_data 
```
**Paso #2**

Desmontar la particion

```
umount /data
```

**Paso #3**

Borrar el LV por ejemplo lv_data 

```
root@lvm:/# lvremove /dev/vg_greencore/lv_data 
Do you really want to remove and DISCARD active logical volume lv_data? [y/n]: y
  Logical volume "lv_data" successfully removed
```
**Paso #4**

Volver a crear el LV con el tamaño más pequeño

```
root@lvm:/# lvcreate -n lv_data vg_greencore -L 200M
WARNING: xfs signature detected on /dev/vg_greencore/lv_data at offset 0. Wipe it? [y/n]: y
  Wiping xfs signature on /dev/vg_greencore/lv_data.
  Logical volume "lv_data" created.
```

**Paso #5**

Format de XFS al LV, ejemplo 

```
root@lvm:/#  mkfs.xfs /dev/mapper/vg_greencore-lv_data
meta-data=/dev/mapper/vg_greencore-lv_data isize=512    agcount=4, agsize=12800 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=0
data     =                       bsize=4096   blocks=51200, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=855, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0

```

**Paso #6**

Montar el LV, revisamos que este con df -h

```
mount /dev/mapper/vg_greencore-lv_data /data/
```

**Paso #7**

El ultimo paso la restauracion del dump hacia el punto de montaje /data
```
root@lvm:/# xfsrestore -f /home/bryan/xfs_dump_lvm_data.image /data/
xfsrestore: using file dump (drive_simple) strategy
xfsrestore: version 3.1.6 (dump format 3.0) - type ^C for status and control
xfsrestore: searching media for dump
xfsrestore: examining media file 0
xfsrestore: dump description: 
xfsrestore: hostname: lvm
xfsrestore: mount point: /data
xfsrestore: volume: /dev/mapper/vg_greencore-lv_data
xfsrestore: session time: Mon Oct 14 21:35:52 2019
xfsrestore: level: 0
xfsrestore: session label: "dump"
xfsrestore: media label: "dump"
xfsrestore: file system id: 9e612ae1-f42b-41ee-b98d-4b8975e0e48a
xfsrestore: session id: 3fbc16ca-fb55-4f1c-9370-1a19b6b9b0cf
xfsrestore: media id: 761eac6a-c497-4589-804b-15c88340dec7
xfsrestore: using online session inventory
xfsrestore: searching media for directory dump
xfsrestore: reading directories
xfsrestore: 1 directories and 4 entries processed
xfsrestore: directory post-processing
xfsrestore: restoring non-directory files
xfsrestore: restore complete: 0 seconds elapsed
xfsrestore: Restore Summary:
xfsrestore:   stream 0 /home/bryan/xfs_dump_lvm_data.image OK (success)
xfsrestore: Restore Status: SUCCESS
```

## Extender Swap usando LVM

**Paso #1** 

Inicializar los PV, usando el disco /dev/sda o /dev/sdb o cualquier otro disco, Importante antes se tuvo que haber realizado el particionamiento

```
root@lvm:~# pvcreate /dev/sdb3
  Physical volume "/dev/sdb3" successfully created
```

**Paso #2** 

Extender el volume group  vg_greencore con el PV creado anteriormente /dev/sdb3

```
root@lvm:~# vgextend vg_greencore /dev/sdb3
  Volume group "vg_greencore" successfully extended
```

**Paso #3**

Extender el Volumen logico de swap se debe buscar cual o cuales Ejemplo lv_swap

```
root@lvm:~# lvextend /dev/vg_greencore/lv_swap -L +1G -r
fsck from util-linux 2.27.1
  Size of logical volume vg_greencore/lv_swap changed from 2.86 GiB (733 extents) to 3.86 GiB (989 extents).
  Logical volume lv_swap successfully resized.
fsadm: Filesystem "swap" on device "/dev/mapper/vg_greencore-lv_swap" is not supported by this tool
  fsadm failed: 1
```

**Paso #4**

Para poder extender primero se debe liberar el swap
Antes se puede revisar con el comando free -gh

```
root@lvm:~# free -gh
              total        used        free      shared  buff/cache   available
Mem:           1.9G         63M        1.7G        3.2M        152M        1.7G
Swap:          2.9G          0B        3.9G
```

Liberar el swap:

```
swapoff /dev/mapper/vg_greencore-lv_swap
```

**Paso #5**

Se debe realizar el format tipo swap para que luego se pueda utilizar el nuevo espacio

```
root@lvm:~# mkswap /dev/mapper/vg_greencore-lv_swap 
mkswap: /dev/mapper/vg_greencore-lv_swap: warning: wiping old swap signature.
```

**Paso #6**

Levantar la particion de LVM con el nuevo espacio

```
swapon /dev/mapper/vg_greencore-lv_swap 
```
Por ultimo verificar que el espacio este disponible a nivel de OS

```
root@lvm:~# free -gh
              total        used        free      shared  buff/cache   available
Mem:           1.9G         60M        1.7G        3.2M        151M        1.7G
Swap:          3.9G          0B        3.9G
```


