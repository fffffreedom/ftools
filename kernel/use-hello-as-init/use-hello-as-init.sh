gcc -static -o init hello_kerenl.c
dd if=/dev/zero of=myinitrd.img bs=4096 count=2048
mke2fs -j myinitrd.img
#mke2fs  myinitrd.img
mkdir rootfs
sudo mount -o loop myinitrd.img rootfs
sudo cp init rootfs/
sudo mkdir rootfs/dev
sudo mknod rootfs/dev/console c 5 1
sudo mknod rootfs/dev/ram b 1 0
sudo umount rootfs
