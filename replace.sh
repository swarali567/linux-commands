#!/bin/bash"
 
sed -i "s/$2/$3/g" "$1"
echo repleced $2 with $3
