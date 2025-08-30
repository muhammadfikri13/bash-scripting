# 🐚Bash-scripting #
> _in this repo I created three simple bash scripts that are applied in cronjob_ | I hope this repo could be a good learning and practical documentation about Bash Scripting and simple job automation in Linux

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

## Scripts Explaination : ##
### **backup.sh** ###
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
<img width="736" height="234" alt="image" src="https://github.com/user-attachments/assets/2d9c2236-7d35-414b-a459-4b8529050de4" />

Log  
<img width="771" height="418" alt="image" src="https://github.com/user-attachments/assets/3dc6a9a8-1815-43bc-9e83-2bd024610ba7" />


### **auto_update.sh** ###
```
#!/bin/bash
```
Shebang, telling the system that the script must be run using Bash

```
echo "🚀 System update started..." | wall
sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y
echo "✅ System up-to-date!" | wall
```
Doing update using apt (Advanced Package Tool) / Debian-based Linux distributions.
- update = update or sync package list
- full-upgrade = upgrade all including packages that needs new dependency
- autoremove = deletes all old or unused packages

Log screenshot of autoupdate  
<img width="1156" height="622" alt="image" src="https://github.com/user-attachments/assets/e0cc4f26-edf9-4d42-a250-1b550da2dc9a" />
<img width="1333" height="603" alt="image" src="https://github.com/user-attachments/assets/b2bf20e8-60fa-42bc-a15f-fe5624ad3d5b" />


###  **check_disk.sh** ###
```
#!/bin/bash
```
Shebang, telling the system that the script must be run using Bash

```
THRESHOLD=80
```
THRESHOLD = Initiate the THRESHOLD number, the amound of usage that needs to be alreted

```
USAGE=$(/bin/df -h / | grep '/' | awk '{print $5}' | sed 's/%//')
```
Find out the current amount of disk usage by running df -h command
- df         = means _disk free_ , showing current disk usage
- -h         = means _human readable_ , so the output using M(mega), G(giga) measurement
- | grep '/' = filter a line that includes "/" which contain the number of disk percentage
- | awk      = break the line to become columns based on spaces
- '{print $5}' = take the fifth column from the left
- sed 's/%//'= stream editor that deletes % symbol
- USAGE=$(_) = save the final result to USAGE variable

```
if [ $USAGE -ge $THRESHOLD ]; then
    echo "⚠️ WARNING: Disk usage reach $USAGE%"| wall
fi
```
- if ...; then  = Bash conditional structure. Run the code block if it's true
- $USAGE        = Disk usage percentage
- -ge           = numeric comparison operator, greater than or equal
- $THRESHOLD    = The amound of usage that needs to be alreted

Example output in linux terminal  
<img width="844" height="243" alt="image" src="https://github.com/user-attachments/assets/e12b4c7b-dc47-4da4-ad55-95ab73ca4188" />

## Crontab ##
```
* * * * * /home/backups/backup.sh >> /tmp/testcron.log 2>&1
@reboot /home/fikri/scripts/auto_update.sh >> /home/fikri/log/update/update.log 2>&1
* * * * * /home/fikri/scripts/check_disk.sh >> /home/fikri/log/disk/disk.log 2>&1
```  
<img width="971" height="131" alt="image" src="https://github.com/user-attachments/assets/a84a94dc-7df3-4d2f-b418-42e02ff4121c" />


Unfortunately crontab can't show the process of the backup and update. The output only can be showed through log file that I set in crontab
