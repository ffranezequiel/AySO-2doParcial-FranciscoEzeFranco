punto a:
lsblk
sudo fdisk /dev/sdc
n
p
+1G
#Hacerlo 3 veces para las particiones primarias

n
e
+3G
#PARA LA PARTICION EXTENDIDA

n
+1.5G
+1.3G
#hacer dos veces para las particiones logicas 5 y 6

t
1
l
82
#establecemos la particion 1 como primaria
w 

sudo mkswap /dev/sdb1
sudo swapon /dev/sdc1
free -h
#Crear PV, VG y LV con LVM:
#establecemos las particiones como lvm, hacerlo para la particion 2,3,5 y 6
sudo fdisk /dev/sdc
t
2
l
8E
w
sudo fdisk -l
#creamos los volumenes fisicos
sudo pvcreate /dev/sdc2 /dev/sdc3 /dev/sdc5 /dev/sdc6
sudo pvs
#CREO UN VOLUMEN GRUP PARA LA APP DE PRO
sudo vgcreate vgAdmin /dev/sdc2 /dev/sdc3
sudo vgs
#CREO GRUPO PARA DEVELOPERS
sudo vgcreate vgDevelopers /dev/sdc5 /dev/sdc6
sudo vgs 
sudo pvs
#CREO 3 volumens lógicos desde el vgDevelopers
sudo lvcreate -L 1G vgDevelopers -n lvDevelopers
sudo lvcreate -L 1G vgDevelopers -n lvTesters
sudo lvcreate -L .8G vgDevelopers -n lvDevops
sudo lvcreate -L .8G vgAdmin -n lvAdmin
sudo lvs
sudo pvs
#ASIGNAMOS LOS FS A LOS LV
sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvDevelopers
sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvTesters
sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvDevops
sudo mkfs.ext4 /dev/mapper/vgAdmin-lvAdmin
#MONTAMOS LOS DISCOS
sudo mount /dev/mapper/vgDevelopers-lvDevelopers /mnt/lvDevelopers
sudo mount /dev/mapper/vgDevelopers-lvTesters /mnt/lvTesters
sudo mount /dev/mapper/vgDevelopers-lvDevops /mnt/lvDevops
sudo mount /dev/mapper/vgAdmin-lvAdmin /mnt/lvAdmin
