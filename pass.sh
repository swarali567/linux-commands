#!/bin/bash
 
# Generate a password with at least one alphanumeric and one special character
# First, generate one alphanumeric character
alpha=$(< /dev/urandom tr -dc 'A-Za-z' | head -c 1)
 
num=$(< /dev/urandom tr -dc '0-9' | head -c 1)

# Then, generate one special character
special=$(< /dev/urandom tr -dc '!@#$%^&*()' | head -c 1)
 
# Generate the remaining 6 characters (can be alphanumeric or special)
remaining=$(< /dev/urandom tr -dc 'A-Za-z0-9!@#$%^&*()' | head -c 5)
 
# Combine all parts and shuffle the result to randomize the order
password=$(echo "$alpha$special$remaining$num" | fold -w1 | shuf | tr -d '\n')
 
# Output the password
echo "$password"
