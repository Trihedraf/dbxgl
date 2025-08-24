import configparser, os
import subprocess
from pathlib import Path

config = configparser.ConfigParser()

# Create config file if doesn't exist
if not os.path.isfile('dbxgl.ini'):
    open('dbxgl.ini', 'a').close()

# Read config file
config.read('dbxgl.ini')

# Check if sections and options exist, if not create them
if not config.has_section('Paths'):
    config['Paths'] = {}

if not config.has_option('Paths', 'DosBox-X'):
    config['Paths']['DosBox-X'] = 'dosbox-x'
if not config.has_option('Paths', 'DosBox-X Conf'):
    config['Paths']['DosBox-X Conf'] = 'dosbox-x.conf'
if not config.has_option('Paths', 'DosBox-X win9x Conf'):
    config['Paths']['DosBox-X win9x Conf'] = 'dosbox-x-win9x.conf'
if not config.has_option('Paths', 'Games Directory'):
    config['Paths']['Games Directory'] = 'games'

# Write out config file    
with open('dbxgl.ini', 'w') as configfile:
    config.write(configfile)

paths = config['Paths']

# Set variables from config file
dbx_path = paths.get('DosBox-X')
if dbx_path == '':
    print ("Please set the DosBox-X path in dbxgl.ini")
dbx_conf_path = paths.get('DosBox-X Conf')
if dbx_conf_path == '':
    print ("Please set the DosBox-X conf path in dbxgl.ini")
dbx_win9x_path = paths.get('DosBox-X win9x Conf')
if dbx_win9x_path == '':
    print ("Please set the DosBox-X win9x conf path in dbxgl.ini")
games_path = paths.get('Games Directory')
if games_path == '':
    print ("Please set the Games Directory in dbxgl.ini")

# DOS and Win9x game functions
def dos_game(dir, conf):
    print (dbx_path, "-conf", dbx_conf_path, "-conf", dir+"/"+conf)
    subprocess.run([dbx_path, "-conf", dbx_conf_path, "-conf", dir+"/"+conf])
def win9x_game(dir, conf):
    subprocess.run([dbx_path, "-conf", dbx_conf_path, "-conf", dbx_win9x_path, "-conf", dir+"/"+conf])

# Menu
def main():
    os.system('cls||clear')
    print ("")
    print ("    /-----------------------------------/")
    print ("   /               GAMES               /")
    print ("  /-----------------------------------/")
    print ("")
    games_list = []
    games_list.append("Exit")
    games_list_conf = []
    games_list_conf.append("Exit")
    games_list_dir = []
    games_list_dir.append("Exit")
    games_list_num = []
    games_list_num.append(0)
    games_list_os = []
    games_list_os.append("Exit")
    game_path = sorted(Path(games_path).glob('**/*.dbxgl'))
    game_num = 1
    for path in game_path:
        gameconfig = configparser.ConfigParser()
        gameconfig.read(path)
        games_list.append(gameconfig['Game']['Name'])
        games_list_conf.append(gameconfig['Game']['ConfName'])
        games_list_dir.append(os.path.dirname(path).replace(os.path.sep, '/'))
        games_list_num.append(game_num)
        games_list_os.append(gameconfig['Game']['OSType'])
        print(f'{"  "}{game_num:02d}{") "}{games_list[game_num]}')
        game_num +=1
    print("\n   0) Quit")

    game_choice = input("\n  Choose a game # > ")

    # Convert input to int and if is not a number reload the menu to try again
    try:
        game_choice = int(game_choice)
    except (TypeError, ValueError):
        main()

    # Verify number is a valid option
    if game_choice > len(games_list_num)-1 or game_choice < 0:
        main()
    
    # Start game of choice
    if games_list_os[game_choice] == "dos":
        dos_game(games_list_dir[game_choice],games_list_conf[game_choice])
        main()
    elif games_list_os[game_choice] == "win9x":
        win9x_game(games_list_dir[game_choice],games_list_conf[game_choice])
        main()
    else:
        exit

main()
