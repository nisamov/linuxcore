Por reestructurar
```sh
sudo dd if=/dev/zero of=/disco1 bs=1M count=1024
sudo dd if=/dev/zero of=/disco2 bs=1M count=1024
sudo losetup -fP /disco1
sudo losetup -fP /disco2
sudo mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/loop3 /dev/loop4
sudo mkfs.ext4 /dev/md0
sudo mkdir /mnt/raid && sudo mount /dev/md0 /mnt/raid
sudo mdadm --detail --scan >> /etc/mdadm/mdadm.conf
```