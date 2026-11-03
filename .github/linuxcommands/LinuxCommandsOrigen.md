```
   __ _                      ___                                          _     
  / /(_)_ __  _   ___  __   / __\___  _ __ ___  _ __ ___   __ _ _ __   __| |___ 
 / / | | '_ \| | | \ \/ /  / /  / _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
/ /__| | | | | |_| |>  <  / /__| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
\____/_|_| |_|\__,_/_/\_\ \____/\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/
[By - Andrés Abadías] - [V.1.0.7]

//[Linux-OS-Terminal-Most-Function]//Bilingual Single-User Operating Systems-[SOM-B]

#--------------->>-------------------------------------->>--------------#
| DIRECTORY	>>					>>	 	|
#--------------->>-------------------------------------->>--------------#
/bin		>>
/boot		>>
/dev		>>
/etc		>>
/home		>>
/lib		>>
/media		>>
/etc/group


/////[COMMANDS:]>>///////////////////
#--------------->>-------------------------------------->>---------#
| COMMAND 	>> DESCRIPTION 				>> EXAMPLE |
#--------------->>-------------------------------------->>---------#
pwd		>>	Current dierction			>> pwd
cd /#		>>	Go to /#				>> cd /Documents
cd #		>>	Go to #					>> cd Main/Docs/Data
cd ..		>>	Go back					>> cd ..
cd ../..	>>	Go back twice				>> cd ../..
cd ./#		>>	From where you are to #			>> cd ./Root/Resources
ls		>>	Show path content			>> ls
clear		>>	Clear console				>> clear
rm #		>>	Remove file				>> rm log.txt
rm -r #		>>	Remove Directoy				>> rm -r Data
touch #		>>	Create empty file			>> touch logs.txt
mkdir -p #	>>	Create Directory / Folder		>> mkdir -p Documents/Word
su root		>>	Login as Admin				>> su root
su #		>>	Login as #				>> su Example
passwd @user	>>	Change password of @user		>> passwd @Example2
sudo adduser #	>>	Create new user				>> sudo adduser Example3
deluser @user	>>	Delete a user				>> deluser @Example4
exit		>>	Exit the Terminal			>> exit
mkdir -p /#/#/#	>>	Create the full line of Dirs		>> mkdir -p /Main/Docs/Example/Example2
nano		>>	Open/Modify file			>> nano Page.txt
cut		>>	Send the file to the clipboard		>> cut Page.txt
apt install #	>>	Install # from 				>> apt install tree
apt upgrade	>>	Download All Lastest Versions		>> apt upgrade
cat		>>	Show the content of a file		>> cat Page.txt
man		>>	Help about something			>> man ssh
sudo f disk -l	>>	See partitions and free space		>> sudo f disk -l
df -h		>>	See free space in each partition	>> df -h
ip a -c		>>	Show Ip on color			>> ip a -c
ip a		>>	Show Ip					>> ip a
cp		>>	Copy files/directory & paste it 	>> cp Documents/Page.txt /home/user/Documents
mv		>>	Move file to other direction		>> mv home/user/Reports/text.txt /home/user/Public
cal		>>	Show Calendar				>> cal
chmod		>>	Gestion permissions of dir/docs		>> chmod 700 test.txt 
chgrp		>>	Change a group of users from dir	>> chgrp -R hiox test
groupadd #	>>	Create user's group			>> sudo groupadd #
adduser @# #gr	>>	Add a user to a group			>> adduser @test1 group1
ls -l example*	>>	Show the relacionated items with	>> ls -l test*
ls -l *[A-Z]	>>	Show uppercase relatinated with		>> ls -l *[A-Z]
grep		>>	Show the number of lines that a file has>> cat /etc/passwd |  grep /bin/bash | wc -l
unalias		>>	Unalias an alias			>> unalias ls (that ls was sl)
tail		>>	Only shows the las line of an output	>> cut -d ':' -f 1.7 /etc/passwd | tail -n 3 
ps -a		>>	Show all process			>> ps -A
kill -9 (PID)	>>	Kill task				>> kill -9 3172



[COOL COMMANDS:]>>///////////////////
#--------------->>-------------------------------------->>--------------#
| COMMAND 						>> WHAT DOES 	|
#--------------->>-------------------------------------->>--------------#
telnet mapscii.me					>> Show World map
telnet towel.blinkenlights.nl				>> Star Wars Movie



//[FILE CONFIG:]>>///////////////////

Control + X	>>	Exit				>>
Control + O	>>	Save Without Exit		>>
Ctrl + Alt + T	>>	Create new terminal		>>


////[DISK INFO:]>>///////////////////
#--------------->>-------------------------------------->>--------------#
| NAME	 						>> ABOUT IT 	|
#--------------->>-------------------------------------->>--------------#

/dev/sda						>> First name of partition
/dev/sdb						>>
/dev/sde5						>> The fifth partition


[VARIABLE COMMANDS:]>>///////////////
#--------------->>-------------------------------------->>--------------#
| COMMAND 						>> WHAT DOES 	|
#--------------->>-------------------------------------->>--------------#

ls -a							>> Show hidden files and directories
ls -l							>> Show files and directories wit multiple information
ls -la							>> Combination of ("ls -a")&("ls -l")


UID	>> User identification
GID	>>

Every hidden file (in "ls") starts with a "."

Each user has his own directory in /home
root user - Administrator

UID: User ID
GID: Group ID

mkdir -p /home/user/Documents/Letters/Personal
```