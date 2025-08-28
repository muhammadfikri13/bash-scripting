# bash-scripting
in this repo I created three simple bash scripts that are applied in cronjob

Auto backup 
```Bash
SOURCE="/home/fikri"
DEST="/home/backups"
DATE=$(date +"%Y%m%d_%H%M%S")
FILENAME="backup-$DATE.tar.gz"
```
