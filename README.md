#🐚Bash-scripting#
_in this repo I created three simple bash scripts that are applied in cronjob_

## What is Bash?? ##
Bash (Bourne-Again SHell) is a script language that is used to interact with Unix-like operating system such as Linux, macOS and WSL. 

## What Bash can be used for? ##
- Task Automation
- File Management and Directory
- System Management

## What is CronJob? ##
CronJob is a feature or program that is able to run automated and scheduled task in Unix operating system like Linux.

## How CronJob work? ##
1. Crontab (Cron Table) = Schedule and configure the task that will be executed
2. Daemon Cron (Crond) = Running in system background and keep checking crontab file to decide which task should be executed
3. Execute Automatically = When the time has come, Daemon Cron will automatically execute the task or script in the background

## Cron Format ##
```markdown
* * * * * command_to_run
```
(minute, hour, day in a month, day in a week)

### Examples ###
```markdown
* 7 * * * command_to_run
```
Running the script on **7am**

```markdown
/15 * * * * command_to_run
```
Running the script **every 15 minutes**

=========================================================
## Script Explaination : ##
**backup.sh**
```
#!/bin/bash
```
Shebang, telling the system that this script must be executed using Bash

```Bash
SOURCE="/home/fikri"
DEST="/home/backups"
DATE=$(date +"%Y%m%d_%H%M%S")
FILENAME="backup-$DATE.tar.gz"
```
Initialize the source(which directory will be backed up), dest(destination folder to save the backup file), date(the date and time when the directory has backed up), filename(the name of the backup file which contain the date and time of the execution)

```
mkdir -p $DEST
```
Making sure the backup folder exist

```
tar -czvf $DEST/$FILENAME $SOURCE
```
Create compressed archive from $SOURCE to $DEST/$FILENAME using tar
- -c = create archive
- -z = compress gzip
- -v = verbose(showing the list of file when processed)
- -f = file name output

```
find $DEST -type f -name "backup-*.tar.gz" -mtime +7 -exec rm {} \;
```
Finding file in $DEST, 
-type f = making sure that we are looing for file only
-name *backup-*.tar.gz = making sure that the file contain name "backup-" and have .tar.gz extension
-mtime +7 = created more than 7x24 hour
-exec rm {} \; = run "rm" command for every result

```
echo "Backup complete! File : $DEST/$FILENAME"
```
Print out the file path of the backup

