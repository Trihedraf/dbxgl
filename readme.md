# DosBox-X Game Launcher
Requires python 3.6 or higher

## Directory Structure
The structure of the games folder is as follows.  
    - GameName  
    |- *.dbxgl  
    |- dosbox-x.conf  

## Per Game Config
The .dbxgl file needs to be placed next to the per game dosbox config with the following options set.
```ini
[Game]
Name = {GameName}
OSType = {dos|win9x}
ConfName = {dosbox-x.conf}
```
