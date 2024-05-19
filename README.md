# BackupScript
# Backup Tool for Directories

This repository contains a bash script that provides a tool for backing up directories, scheduling backups using cron, and restoring backups. It is designed to make the process of managing backups straightforward and efficient.

## Features

1. **Manual Backup**: 
   - Allows the user to create a backup of a specified directory immediately.
   - Verifies the existence of the directory before proceeding.
   - Logs the backup details, including the size of the generated backup file.

2. **Scheduled Backup using Cron**: 
   - Allows the user to schedule backups at a specified time using cron.
   - Ensures the scheduled directory exists before setting up the cron job.
   - Creates the cron job file and logs the backup schedule.

3. **Restore Backup**: 
   - Lists available backup files.
   - Allows the user to restore a specified backup.
   - Verifies the existence of the backup file before proceeding with the restoration.

## Usage

### Manual Backup

To create a backup manually, follow these steps:

1. Run the script.
2. Choose option `1` from the menu.
3. Enter the relative path of the directory you wish to back up.
4. Confirm if you want to proceed with the backup.
5. The backup file will be created in the `backups` directory and details will be logged.

### Scheduled Backup using Cron

To schedule a backup using cron, follow these steps:

1. Run the script.
2. Choose option `2` from the menu.
3. Enter the absolute path of the directory you wish to back up.
4. Enter the time at which you want the backup to be executed (format: HH:MM).
5. Confirm if you want to schedule the backup.
6. The cron job will be created and details will be logged.

### Restore Backup

To restore a backup, follow these steps:

1. Run the script.
2. Choose option `3` from the menu.
3. A list of available backups will be displayed.
4. Enter the name of the backup file you wish to restore.
5. The specified backup will be restored to the `recovery` directory.


