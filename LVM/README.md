# LVM
El siguiente escenario es para extender una particion usando LVM

### Paso #1

* Crear dos particiones primarias de un 1GB
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

**Para actualizar la tabla departiciones a nivel de OS**

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
```
root@ubuntuLVM:~# lvextend  /dev/greencore_vg/lv_root -L +1G -r (size)
root@ubuntuLVM:~# lvextend  /dev/greencore_vg/lv_var -l +254 -r (extents)
```


