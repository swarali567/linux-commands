#!/bin/bash
 
 
# MySQL credentials
 
DB_USER="newuser"         # Replace with your MySQL username
 
DB_PASSWORD="Newforgot@1"     # Replace with your MySQL password
 
DB_NAME="new"          # Replace with the name of your database
 
BACKUP_DIR="sql_backup"    # Replace with the path to your backup directory
 
  # Create the backup directory if it doesn't exist
 
  mkdir -p "$BACKUP_DIR"
 
   # Get the current date in YYYY-MM-DD format
 
   CURRENT_DATE=$(date +%F)
 
    # Define the backup file name
 
    BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$CURRENT_DATE.sql"
 
     # Take the backup
# mysqldump -u "$DB_USER" "$DB_NAME" > "$BACKUP_FILE"
  mysqldump -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$BACKUP_FILE"
 
      # Check if the backup was successful
 
      if [ $? -eq 0 ]; then
 
          echo "Backup of database '$DB_NAME' completed successfully and saved to '$BACKUP_FILE'."
 
          else
 
           echo "Error occurred during backup of database '$DB_NAME'."
 
       fi
