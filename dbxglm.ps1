function dos_game {
    param (
        $name
    )
    .\dosbox-x\dosbox-x -conf .\dosbox-x\dosbox-x.conf -conf .\games\$name\dosbox-x.conf
}

function win9x_game {
    param (
        $name
    )
    .\dosbox-x\dosbox-x -conf .\dosbox-x\dosbox-x.conf -conf .\dosbox-x\dosbox-x-win98.conf -conf .\games\$name\dosbox-x.conf
}

function games_menu {
    Clear-Host
    Write-Output "    /-----------------------------------/"
    Write-Output "   /               GAMES               /"
    Write-Output "  /-----------------------------------/"
    Write-Output ""
    $games = Get-ChildItem -Path .\games | Where-Object { $_.PSIsContainer }
    $menuCount = 1
    $gamesChoice = @()
    $gamesPlatform = @()
    foreach ($game in $games) {
        switch ($game.Name) {
            "BUSTER"        { Write-Output "  $menuCount) Buster and the Beanstalk";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            "DARK"          { Write-Output "  $menuCount) Dark Forces, Star Wars";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            "DOOM"          { Write-Output "  $menuCount) DOOM";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            "DOOM2"         { Write-Output "  $menuCount) DOOM II";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++;
                Write-Output "  $menuCount) DOOM II Setup";
                $gamesChoice += "DOOM2SETUP"; $gamesPlatform += "doom2setup";
                $menuCount++; break }
            "DOOM2MASTER"   { Write-Output "  $menuCount) DOOM II Master";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            "KEEN1"         { Write-Output "  $menuCount) Commander Keen 1: Marooned on Mars";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            "KEEN2"         { Write-Output "  $menuCount) Commander Keen 2: The Earth Explodes";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            "KEEN3"         { Write-Output "  $menuCount) Commander Keen 3: Keen Must Die!";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            "KEEN4"         { Write-Output "  $menuCount) Commander Keen 4: Secret of the Oracle";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            "KEEN5"         { Write-Output "  $menuCount) Commander Keen 5: The Armageddon Machine";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            "LINUXT"        { Write-Output "  $menuCount) Linux Tycoon";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            "MSPPCV12"      { Write-Output "  $menuCount) Ms. Pac-Man";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            "MATHBLASTER"   { Write-Output "  $menuCount) Math Blaster 6-9";
                $gamesChoice += $game.Name; $gamesPlatform += "win9x_game";
                $menuCount++; break }
            "NASCAR"        { Write-Output "  $menuCount) NASCAR";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            "PACPC2"        { Write-Output "  $menuCount) PAC-MAN";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            "PLANETX3"      { Write-Output "  $menuCount) Planet X3";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            "QUAKE"         { Write-Output "  $menuCount) Quake";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++;
                Write-Output "  $menuCount) Quake: Scourge of Armagon";
                $gamesChoice += "QUAKEMP1"; $gamesPlatform += "QUAKEMP1";
                $menuCount++; 
                Write-Output "  $menuCount) Quake: Dissolution of Eternity";
                $gamesChoice += "QUAKEMP2"; $gamesPlatform += "QUAKEMP2";
                $menuCount++; break }
            "READRAB1"      { Write-Output "  $menuCount) Reader Rabbit 1st Grade";
                $gamesChoice += $game.Name; $gamesPlatform += "win9x_game";
                $menuCount++; break }
            "TIE"           { Write-Output "  $menuCount) TIE Fighter, Star Wars";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            "WOLF3D"        { Write-Output "  $menuCount) Wolfenstein 3D";
                $gamesChoice += $game.Name; $gamesPlatform += "dos_game";
                $menuCount++; break }
            Default {}
        }
    }
    Write-Output ""
    Write-Output "  0) EXIT"
    Write-Output ""
    $choice = Read-Host "Choose an option"

    if ( $choice -eq 0 ) {
        exit
    }

    $choice-=1

    if ( $gamesPlatform[$choice] -eq "dos_game" )
    {
        dos_game -name $gamesChoice[$choice]
    } elseif ( $gamesPlatform[$choice] -eq "win9x_game" ) {
        win9x_game -name $gamesChoice[$choice]
    } elseif ( $gamesPlatform[$choice] -eq "doom2setup" ) {
        .\dosbox-x\dosbox-x -conf .\dosbox-x\dosbox-x.conf -conf .\games\DOOM2\dosbox-x-setup.conf
    } elseif ( $gamesPlatform[$choice] -eq "QUAKEMP1" ) {
        .\dosbox-x\dosbox-x -conf .\dosbox-x\dosbox-x.conf -conf .\games\QUAKE\dosbox-x-mp1.conf
    } elseif ( $gamesPlatform[$choice] -eq "QUAKEMP2" ) {
        .\dosbox-x\dosbox-x -conf .\dosbox-x\dosbox-x.conf -conf .\games\QUAKE\dosbox-x-mp2.conf
    }
    games_menu
}

games_menu
