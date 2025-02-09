#!/bin/bash
echo currently logged users are $USER
echo your shell directory is $SHELL
echo your home directory is $HOME
 
echo OS name and version is a
uname -a
var1=$(pwd)
echo current working directory is $var1
echo number of users logged in
w
echo  available shells in your system are
cat /etc/shells
echo hard disk information is
df
echo CPU information is
lscpu
echo Memory information is
free -h
echo file system information is
df -h
echo current running process is
ps
