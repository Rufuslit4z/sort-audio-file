#!/bin/bash

# Le but de ce programme est de pouvoir trier ses propres musiques

# --------------------------- #
#           ATTENTION         #
# AU PREALABLE, INSTALLER VLC #
#    apt-get install vlc -y   #
# --------------------------- #

# Booléen permettant de continuer ou arrêter le programme
# ---------- Reconnaître si le chargement a été effectué avec le choix "0.1"
# --------------------------- Avec le choix "0.2"
exit=false ; choix_01=false ; choix_02=false
# Initialisation du tableau
# Stocker le nom du répertoire parent charger par l'utilisateur
# exemple : /home/username/Musique/DISCO /home/username/Musique/ROCK
#           -> DISCO
#           -> ROCK
dirsNAME=()
dirsABSOLUTE=()
# Initialisation du tableau
# Insertion des extensions lisibles par VLC
extensionVLC=("3G2" "3GP" "A52" "AAC" "AC3" "ASF" "ASX" "AVI" "B4S" "BIN"
              "BUP" "CUE" "DAT" "DIVX" "DTS" "DV" "FLAC" "FLV" "GXF" "IFO"
              "M1V" "M2TS" "M2V" "M3U" "M4A" "M4P" "M4V" "MKA" "MKV" "MOD"
              "MOV" "MP1" "MP2" "MP3" "MP4" "MPEG" "MPEG1" "MPEG2" "MPEG4" "MPG"
              "MTS" "MXF" "OGG" "OGM" "OMA" "PART" "PLS" "SPX" "SRT" "TS"
              "VLC" "VOB" "WAV" "WMA" "WMV" "XM" "XSPF")

tmpFILE="tmp"
linkFILE="path.txt"
# Tant que $exit = false
#   Continuer le programme
#   Si $exit = true
# Fin du programme

bandeau() {
    nbCOLONNES=$(tput cols)
    nbDIESES=38
    let "remplissageINT=($nbCOLONNES - $nbDIESES)/2"
    remplissageSTR=""

    for (( i = 0; i < $remplissageINT; i++ )); do
        remplissageSTR+="-"
    done
    
    titreBLOCK_01="####################################"
    titreBLOCK_02="#                                  #"
    titreBLOCK_03="#       Programme YES OR NOT       #"

    echo
    echo
    echo "$remplissageSTR $titreBLOCK_01 $remplissageSTR"
    echo
    echo "$remplissageSTR $titreBLOCK_02 $remplissageSTR"
    echo
    echo "$remplissageSTR $titreBLOCK_03 $remplissageSTR"
    echo
    echo "$remplissageSTR $titreBLOCK_02 $remplissageSTR"
    echo
    echo "$remplissageSTR $titreBLOCK_01 $remplissageSTR"
    echo
    echo    
}

menu() {
    echo "Le répertoire dans lequel vous travaillez : " $(pwd) 
    echo
    echo "x - Déplacer le programme ; param (\"/home/username/Vidéos/Dr NOZMAN\"/)"
    echo
    echo "0 - Charger un chemin absolu ; exemple : \"/home/username/Musique/DISCO\" \"/home/username/Musique/ROCK\""
    echo
    echo "1 - Gestion des répertoires delete/favorite/later"
    echo "  1.1 - Création"
    echo "  1.2 - Suppression"
    echo
    echo "2 - Lire les fichiers dans un ordre spécifique"
    echo "  2.1 - Ordre alphabétique"
    echo "  2.2 - Aléatoire"
    echo
    echo "3 - Télécharger des fichiers audio"
    echo "  3.1 - Lister les formats disponible ; param -> [ fichier ] [ URL ]"
    echo "  3.2 - Lien ; param -> format URL [ /destination ]"
    echo "  3.3 - Vos playlist Soundcloud ; param -> format fichier /destination"
    echo
    echo "4 - Gestion pour un fichier compressé zip"
    echo "  4.1 - Création"
    echo "  4.2 - Extraction"
    echo "  4.3 - Suppression"
    echo
    echo "5 - Statistiques"
    echo
    echo "help - Notes"
    echo "exit - Quitter le programme"   
    echo    
}

amorce(){
    # "Amorce : $1 ; Destination : $2"
    cd "$2"
    amorce=$(pwd)
}

viderDIRSname(){
    while [ ${#dirsNAME[@]} != 0 ]; do
        unset dirsNAME[-1]
    done    
}

viderDIRSabsolute(){
    while [ ${#dirsABSOLUTE[@]} != 0 ]; do
        unset dirsABSOLUTE[-1]
    done
}

ajouterDIRSabsolute(){
    # Enregistrer les noms des répertoires parents
    while read value; do
        dirsABSOLUTE+=("$value")
    done < $1 ; rm $1
}

ajouterDIRSname(){
    # Enregistrer les noms des répertoires parents
    while read value; do
        dirsNAME+=("$value")
    done < $1 ; rm $1
}

gererPATH(){
    # Créer OU écraser les données de path.txt
    if [ -f "path.txt" ]; then
        rm path.txt
        > path.txt
    else
        > path.txt
    fi    
}

regexABSOLU(){    
    # On affiche le chemin absolu
    # --------- Expression régulière
    # --------- Remplacer " " par "\n"
    # --------- "\n" -> retour à la ligne
    # --------- "///g" -> toutes les occurrences
    # -------------------------- Sauvegarder dans le fichier
    echo "$1" | sed 's/\" \"/\n/g' | sed 's/\"//g' > "$2"    
}

regexRACINE(){
    # Afficher le répertoire
    # --------- Expression régulière
    # --------- Remplacer tout les " " par "\n"
    # -------------------------- rev -> reverse
    # -------------------------- exemple : echo | bonjour | rev -> ruojnob
    # -------------------------------- On sélectionne le nom du répertoire parent
    # ------------------------------------------------- Remettre à l'endroit
    # ------------------------------------------------------- Enregistrer        
    echo "$1" | sed 's/\" \"/\n/g' | sed 's/\"//g' | rev | cut -d '/' -f1 | rev > "$2"
}

enregistrerCHEMINabsolu(){
    # Pour toutes les extensions lisibles par VLC
    for i in ${extensionVLC[@]}; do
        # Pour tous les chemins absolus
        for (( j = 0; j < ${#dirsABSOLUTE[@]}; j++ )); do
            # Rechercher les fichiers lisibles
            find "${dirsABSOLUTE[$j]}" -name "*.$i"     >> $1
            find "${dirsABSOLUTE[$j]}" -name "*.${i,,}" >> $1
        done
    done
}

afficherCONTENU(){
    echo
    echo FOUND:
    # Lire le fichier trié dans l'ordre alphabétique
    # Pour tous les répertoires parents
    for (( i = 0; i < ${#dirsNAME[@]}; i++ )); do
        while read value; do
            if [[ "$value" == *"${dirsNAME[$i]}"* ]]  ; then
                # Supprimer la partie de gauche du répertoire parent et garder la partie de droite
                # ----------- "." -> un caractère
                # ----------- "*" -> 0 ou plusieurs
                # ----------- \(valeur\) -> valeur à garder
                # ----------- "\1" -> remplacer par la valeur gardée
                # ----------- Pour tout ce qui est avant "$i", on supprime puis on garde "$i" et le reste   
                echo "$value" | sed 's/.*\('"${dirsNAME[$i]}"'\)/\1/'
            fi
        done < <(sort $1)                
        # Boucler sur une sortie de commande
    done
}

chargerFICHIER_chemin_absolu(){
    viderDIRSname
    viderDIRSabsolute

    # Demander le(s) répertoire(s)
    read -p "Répertoire : " dir
                
    regexABSOLU         "$dir"     "$tmpFILE"    
    ajouterDIRSabsolute "$tmpFILE"

    regexRACINE         "$dir"     "$tmpFILE"
    ajouterDIRSname     "$tmpFILE"

    gererPATH
    enregistrerCHEMINabsolu "$linkFILE"

    afficherCONTENU "$linkFILE"
    echo
    nombreFICHIER
    echo

    read -p "ENTRER pour continuer" skip
}

createDirectory(){
    # Vérifier si le répertoire existe
    # Si non -> le créer
    if [ ! -d "delete" ]  ; then mkdir -v delete;   fi
    if [ ! -d "favorite" ]; then mkdir -v favorite; fi
    if [ ! -d "later" ]   ; then mkdir -v later;    fi
}

deleteDirectory(){
    if [ -d "delete" ]  ; then rm -rv delete;   fi
    if [ -d "favorite" ]; then rm -rv favorite; fi
    if [ -d "later" ]   ; then rm -rv later;    fi
}

moveTOdir(){
    echo $1
    echo $2
    echo $3
    # Pour tous les répertoires parent
    for i in ${dirsNAME[@]}; do
        # ----------------------- $2 -> Paramètre 2 de la fonction = chemin du fichier à lire
        # ----------------------------------- Ne garder que $i et ce qui est à sa droite
        # ----------------------------------- exemple : ROCK/Linkin Park/Linkin Park - Faint.mp3
        pathDIR=$(cat "$1" | grep -F "$2" | sed 's/.*\('"$i"'\)/\1/')
        echo $pathDIR        
        # Le chemin absolu du fichier                        
        absolutePATHfile=$(cat "$1" | grep -F "$2")
        echo $absolutePATHFILE
        # Le nom du fichier                        
        fileNAME=$(echo "$pathDIR" | rev | cut -d '/' -f1 | rev)
        echo $fileNAME        
        # Le chemin à partir du répertoire racine
        pathDIR=$(echo "$pathDIR" | sed 's/\(.*\)'"$fileNAME"'/\1/')
        echo $pathDIR        
        echo > /dev/tty
        # ------------------------------------- renvoyer vers le terminal
        # ------------------------------------- il me semble qu'un echo dans une fonction
        # ------------------------------------- permet de retourner une valeur
        # ------------------------------------- alors /dev/tty est une alternative
        echo "$fileNAME" ENVOYE VERS "$3"/"$pathDIR" > /dev/tty
        # Faire sauter une ligne dans le terminal
        echo > /dev/tty
        # Créer l'arborescence
        #echo ${3[@]}
        mkdir -p "$3"/"$pathDIR"
        # Déplacer le fichier
        mv "$absolutePATHfile" "$3/$pathDIR"
    done                   
}

choix(){
    # Case Statement
    # Plus joli qu'une série de if ; elif ; else
    # $1 -> Paramètre 1 de la fonction = décision
    # Si cette valeur contient d/f/l/exit
    case $1 in 
        d)
            moveTOdir "$linkFILE" "$2" "delete" ;;
        f)
            moveTOdir "$linkFILE" "$2" "favorite" ;;
        l)
            moveTOdir "$linkFILE" "$2" "later" ;;
        exit)
            echo exit ;; 
    esac
}

action(){
    read -p "Action : " action
    echo $action 
}

decision(){
    read -p "Votre décision d/f/l | exit : " decision </dev/tty
    echo $decision
}

lecture(){
    if [ $1 = "2.1" ]; then
        while read line; do
            vlc "$line"
            decision=$(decision)
            if [ "$(choix $decision "$line")" = "exit" ] ; then break ; fi
        done < <(sort $2)                
    elif  [ $1 = "2.2" ]; then
        while read line; do
            vlc "$line"
            decision=$(decision)
            if [ "$(choix $decision "$line")" = "exit" ] ; then break ; fi
        done < <(sort -R $2)        
    fi
}

skip(){
    read -p "ENTRER pour continuer " skip;
}

listerFORMAT(){
    # "Fichier ou URL : $1"
    favoriteMARKER='class="playableTile__artworkLink audibleTile__artworkLink"'
    uploadMARKER="trackItem__trackTitle sc-link-dark sc-font-light"
    if [ -f "$1" ]; then
        if [ $(cat "$1" | grep "$favoriteMARKER" | grep -Eo 'https[^\"]+' | wc -l) -ne 0 ]; then
            while read link; do
                echo "$link"
                skip
                youtube-dl -F "$link"
            done < <(cat "$1" | grep "$favoriteMARKER" | grep -Eo 'https[^\"]+')        
        else
            while read link; do
                echo "$link"
                skip
                youtube-dl -F "$link"
            done < <(cat "$1" | grep "$uploadMARKER" | grep -Eo "https://soundcloud[^\"]+" | cut -d "?" -f1)
        fi 
    else    
        youtube-dl -F "$1"
    fi
}

oneLINK(){
    # "Amorce : $1 ; Format : $2 ; URL : $3 ; Destination : $4" 
    if [ ! -d "$4" ]; then mkdir -p "$4"; fi
    cd "$4"
    youtube-dl -c -x --audio-format "$2" --audio-format "best" "$3"
    cd "$1"
}

ownPLAYLIST(){
    # "Amorce : $1 ; Format : $2 ; Fichier : $3 ; Destination : $4"        
    favoriteMARKER='class="playableTile__artworkLink audibleTile__artworkLink"'
    uploadMARKER="trackItem__trackTitle sc-link-dark sc-font-light"
    if [ ! -d "$4" ]; then mkdir -p "$4"; fi    
    if [ $(cat "$3" | grep "$favoriteMARKER" | grep -Eo 'https[^\"]+' | wc -l) -ne 0 ]; then
        cat "$3" | grep "$favoriteMARKER" | grep -Eo 'https[^\"]+' > "$4/tmp"
        cd "$4"
        while read link; do
            youtube-dl -c -x --audio-format "$2" --audio-format "best" "$link"
        done < tmp; rm tmp
        cd "$1"
    else
        cat "$3" | grep "$uploadMARKER" | grep -Eo "https://soundcloud[^\"]+" | cut -d "?" -f1 > "$4/tmp"
        cd "$4"
        while read link; do
            echo "$link"
            skip
            youtube-dl -c -x --audio-format "$2" --audio-format "best" "$link"
        done < tmp; rm tmp
        cd "$1"    
    fi
}


creerZIP(){
    zip -r sort.zip delete favorite later
}

extraireZIP(){
    unzip sort.zip
}

supprimerZIP(){
    rm sort.zip
}

# TO DO
nombreFICHIER(){
    sortedMIN=0 ; sortedMAJ=0
    for i in ${extensionVLC[@]}; do
        let "sortedMAJ+=$(ls -R delete   | grep -v '^ ' | grep "\.$i" | wc -l) + 
                        $(ls -R favorite | grep -v '^ ' | grep "\.$i" | wc -l) + 
                        $(ls -R later    | grep -v '^ ' | grep "\.$i" | wc -l)"
        
        let "sortedMIN+=$(ls -R delete   | grep -v '^ ' | grep "\.${i,,}" | wc -l) + 
                        $(ls -R favorite | grep -v '^ ' | grep "\.${i,,}" | wc -l) + 
                        $(ls -R later    | grep -v '^ ' | grep "\.${i,,}" | wc -l)"
    done
    let "sorted=$sortedMIN + $sortedMAJ"
    echo $sorted / $(cat path.txt | wc -l) fichiers triés
}

needHELP(){
    :
}

prgm(){
    amorce=$(pwd)
    while [ $exit = false ]; do
        bandeau
        menu
        action=$(action)
        case $action in
            x) read -p "Destination : " destination; amorce $amorce $destination ;;
            0) chargerFICHIER_chemin_absolu ; choix_01=true ; choix_02=false ;;
            # ----------------- "            
            1.1) createDirectory ;;
            1.2) deleteDirectory ;;
            # ----------------- "
            2.1) lecture $action $linkFILE ;;
            2.2) lecture $action $linkFILE ;;
            # ----------------- "            
            3.1) read -p "Fichier ou URL : " fichierOUurl; 
                 listerFORMAT $fichierOUurl; 
                 echo ; read -p "ENTRER pour continuer" skip ;;
            
            3.2) read -p "Format : " format; read -p "URL : " url; 
                 read -p "Destination : " destination;
                 oneLINK $amorce $format $url $destination;;

            3.3) read -p "Format : " format; read -p "Fichier : " fichierHTML; 
                 read -p "Destination : " destination;
                 ownPLAYLIST $amorce $format $fichierHTML $destination ;;

            # ----------------- "            
            4.1) creerZIP ; echo ; read -p "ENTRER pour continuer" skip ;;            
            4.2) extraireZIP ;;
            4.3) supprimerZIP ;;
            # ----------------- "
            5) nombreFICHIER ; echo ; read -p "ENTRER pour continuer" skip ;;
            # ----------------- "
            help) needHELP ;;
            exit) exit=true ;;
        esac
    done
}

prgm

