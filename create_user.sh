#!/bin/bash

<< comment 
This file is for creating new user 
new user is created or not you can verify cat /etc/passwd
comment

#echo "What is the username?"
#read username
read -p "What is the username?" username 
echo "Username is $username"

sudo useradd -m $username

echo "New user has been added"


