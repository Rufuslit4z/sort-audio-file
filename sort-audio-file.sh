#!/bin/bash

# Le but de ce programme est de pouvoir trier ces propres musiques

# --------------------------- #
#           ATTENTION         #
# AU PREALABLE, INSTALLER VLC #
#    apt-get install vlc -y   #
# --------------------------- #

# Booléen permettant de continuer ou arrêter le programme
# ---------- Reconnaître si le chargement a été effectué avec le choix "0.1"
# -------------------------- Avec le choix "0.2"
exit=false ; choix_01=false ; choix_02=false
# Initialisation du tableau
# Stocker le nom du répertoire parent charger par l'utilisateur
# exemple : /home/username/Musique/DISCO /home/username/Musique/ROCK
#           -> DISCO
#           -> ROCK
dirsNAME=()
# Initialisation du tableau
# Insertion des extension lisible par VLC
extensionVLC=("3G2" "3GP" "A52" "AAC" "AC3" "ASF" "ASX" "AVI" "B4S" "BIN"
              "BUP" "CUE" "DAT" "DIVX" "DTS" "DV" "FLAC" "FLV" "GXF" "IFO"
              "M1V" "M2TS" "M2V" "M3U" "M4A" "M4P" "M4V" "MKA" "MKV" "MOD"
              "MOV" "MP1" "MP2" "MP3" "MP4" "MPEG" "MPEG1" "MPEG2" "MPEG4" "MPG"
              "MTS" "MXF" "OGG" "OGM" "OMA" "PART" "PLS" "SPX" "SRT" "TS"
              "VLC" "VOB" "WAV" "WMA" "WMV" "XM" "XSPF")

# Tant que $exit = false
#   Continuer le programme
#   Si $exit = true
# Fin du programme
while [ $exit = false ]; do
    # 38 étant le nomnbre de "#" présent dans le menu
    widthMENU=38
    # Récupérer le nombre de colonnes du terminal
    # Redimensionner le terminal modifie cette valeur
    columns=$(tput cols)
    # Connaître le nombre qu'il faut de caractère pour ajuter les "#"
    # Remplir le reste de "-"
    let "centerMenu=($columns - $widthMENU)/2"
    # Boucler pour créer la variable contenant les "-" nécessaire au menu
    for i in $(seq 0 $centerMenu)
    do
        # += -> Lui-même + valeur
        space+="-"
    done

    # Afficher le menu
    echo
    echo
    echo
    echo $space"####################################"$space
    echo
    echo $space"#                                  #"$space
    echo
    echo $space"#       Programme YES OR NOT       #"$space
    echo
    echo $space"#                                  #"$space
    echo
    echo $space"####################################"$space
    echo
    echo
    echo

    # Réinitialiser la variable afin que le positionnement du menu ne soit pas romput
    space=""

    # Suite du menu
    echo "0 - Charger les fichiers audio"
    echo "  0.1 - Chemin absolu      | exemple : \"/home/username/Musique/DISCO\" \"/home/username/Musique/ROCK\""
    echo "  0.2 - Répertoire courant | exemple : \"DISCO\" \"ROCK\""
    echo
    echo "1 - Gestion des répertoires delete/favorite/later"
    echo "  1.1 - Création"
    echo "  1.2 - Suppression"
    echo
    echo "2 - Lire les fichiers dans un ordre spécifique"
    echo "  2.1 - Ordre alphabétique"
    echo "  2.2 - Aléatoire"
    echo
    echo "3 - Gestion pour un fichier compressé zip"
    echo "  3.1 - Création"
    echo "  3.2 - Extraction"
    echo "  3.3 - Suppression"
    echo
    echo "4 - Statistiques"
    echo
    echo "exit - Quitter le programme"   
    echo

    # Demander l'action à l'utilisateur
    # read -> lire
    #         -p -> ne pas ajouter un passage à la ligne "\n"
    read -p "Action : " action
       
    chargerFICHIER_chemin_absolu(){
        # Demander le(s) répertoire(s)
        read -p "Répertoire : " dir

        # Initialisation du tableau
        dirsABSOLUTE=()
        
        # On affiche le chemin absolu
        # --------- Expression régulière
        # --------- Remplacer " " par "\n"
        # --------- "\n" -> retour à la ligne
        # --------- "/g" -> toutes les occurences
        # -------------------------- Sauvegarder dans le fichier
        echo $dir | sed 's/ /\n/g' > tmp
        
        # Enregistrer dans le tableau les chemins absolus
        while read value; do
            dirsABSOLUTE+=("$value")
        done < tmp

        # Supprimer le fichier
        rm tmp

        # Initialisation du tableau
        dirsNAME=()

        # Afficher le répertoire
        # --------- Expression régulière
        # --------- Remplacer tout les " " par "\n"
        # -------------------------- rev -> reverse
        # -------------------------- exemple : echo | bonjour | rev -> ruojnob
        # -------------------------------- On sélectionne le nom du répertoire parent
        # ------------------------------------------------- Remettre à l'endroit
        # ------------------------------------------------------- Enregistrer        
        echo $dir | sed 's/ /\n/g' | rev | cut -d '/' -f1 | rev > tmp

        # Enregistrer le nom des répertoires parents
        while read value; do
            dirsNAME+=("$value")
        done < tmp

        # Supprimer
        rm tmp

        # Créer OU écraser les données de path.txt
        > path.txt
        # Pour toutes les extensions lisibles par VLC
        for i in ${extensionVLC[@]}; do
            # Pour tout les chemin absolu
            for j in ${dirsABSOLUTE[@]}; do
                # Rechercher les fichiers lisibles
                find $j -name "*.$i" >> path.txt
                find $j -name "*.${i,,}" >> path.txt
            done
        done
        echo FOUND:
        # Lire le fichier trié dans l'ordre alphabétique
        while read value; do
            # Pour tout les répertoires parents
            for i in ${dirsNAME[@]}; do
                # Supprimer la partie de gauche du répertoire parent et garder la partie de droite
                # ----------- "." -> un caractère
                # ----------- "*" -> 0 ou plusieurs
                # ----------- \(valeur\) -> valeur à garder
                # ----------- "\1" -> remplacer par la valeur garder
                # ----------- Pour tout ce qui est avant "$i", on supprime puis on garde "$i" et le reste   
            echo $value | sed 's/.*\('$i'\)/\1/'    
            done
        # Boucler sur une sortie de commande
        done < <(sort path.txt)
        echo
        # Attendre avant de continuer le programme
        read -p "ENTRER pour continuer" skip
    }

    chargerFICHIER_repertoire_courant(){
        # Demander le répertoire        
        read -p "Répertoire : " dir
      
        # Initialiser tableau
        dirs=()
        
              
        echo "$dir" | sed 's/\"//g' | sed 's/ /\n/g' > tmp        
        while read value; do
            dirs+=("$value")
        done < tmp
        rm tmp
        
        > path.txt
        for i in ${extensionVLC[@]}; do
            for j in ${dirs[@]}; do
                find $j -name "*.$i" >> path.txt
                find $j -name "*.${i,,}" >> path.txt
            done        
        done
        echo FOUND:
        sort path.txt
        echo
        nombreFICHIER
        echo
        read -p "ENTRER pour continuer" skip
    }

    # -----

    createDirectory(){
        if [ ! -d "delete" ]  ; then mkdir -v delete;   fi
        if [ ! -d "favorite" ]; then mkdir -v favorite; fi
        if [ ! -d "later" ]   ; then mkdir -v later;    fi
    }

    deleteDirectory(){
        if [ -d "delete" ]  ; then rm -rv delete;   fi
        if [ -d "favorite" ]; then rm -rv favorite; fi
        if [ -d "later" ]   ; then rm -rv later;    fi
    }

    # ----

    choix(){
        case $1 in 
            d)
                # Récréer une erreur, copy bien le fichier
                # dans le bon répertoire
                # mais rajoute en plus de ça
                # le répertoire de base /home/pmarie/......./
                # dans le choix effectué...
                
                if [ $choix_01 = true ]; then
                    for i in ${dirsNAME[@]}; do
                        pathFILE=$(cat path.txt | grep "$2" | sed 's/.*\('$i'\)/\1/')
                        echo                    
                        echo "EN COURS DE LECTURE : "$pathFILE 1>&2
                        echo                        
                        cp -r --parent "$pathFILE" delete/
                        rm "$pathFILE"
                    done
                else
                    pathFILE=$(cat path.txt | grep "$2")
                    echo                    
                    echo "EN COURS DE LECTURE : "$pathFILE 1>&2
                    echo
                    cp -r --parent "$pathFILE" delete/
                    rm "$pathFILE"
                fi
                ;;
            f)
                if [ $choix_01 = true ]; then
                    for i in ${dirsNAME[@]}; do
                        pathFILE=$(cat path.txt | grep "$2" | sed 's/.*\('$i'\)/\1/')
                        echo                    
                        echo "EN COURS DE LECTURE : "$pathFILE 1>&2
                        echo                        
                        cp -r --parent "$pathFILE" favorite/
                        rm "$pathFILE"
                    done
                else
                    pathFILE=$(cat path.txt | grep "$2")
                    echo                    
                    echo "EN COURS DE LECTURE : "$pathFILE 1>&2
                    echo
                    cp -r --parent "$pathFILE" favorite/
                    rm "$pathFILE"
                fi
                ;;
            l)
                if [ $choix_01 = true ]; then
                    for i in ${dirsNAME[@]}; do
                        pathFILE=$(cat path.txt | grep "$2" | sed 's/.*\('$i'\)/\1/')
                        echo                    
                        echo "EN COURS DE LECTURE : "$pathFILE 1>&2
                        echo                        
                        cp -r --parent "$pathFILE" later/
                        rm "$pathFILE"
                    done
                else
                    pathFILE=$(cat path.txt | grep "$2")
                    echo                    
                    echo "EN COURS DE LECTURE : "$pathFILE 1>&2
                    echo
                    cp -r --parent "$pathFILE" later/
                    rm "$pathFILE"
                fi
                ;;           
            exit)
                echo exit
                ;; 
        esac
    }

    lectureAlphabetique(){
        while read line; do
            vlc "$line"
            read -p "Votre décision d/f/l | exit : " decision </dev/tty
            if [ "$(choix $decision "$line")" = "exit" ]; then
                break
            fi
        done < <(sort path.txt)
    }

    lectureAleatoire(){
        while read line; do
            vlc "$line"
            read -p "Votre décision d/f/l | exit : " decision </dev/tty
            if [ $(choix $decision "$line") = "exit" ]; then
                break
            fi
        done < <(sort -R path.txt)
    }


    # -----

    creerZIP(){
        zip -r sort.zip delete favorite later
    }

    extraireZIP(){
        unzip sort.zip
    }

    supprimerZIP(){
        rm sort.zip
    }

    # -----

    nombreFICHIER(){
        sortedMIN=0 ; sortedMAJ=0
        for i in ${extensionVLC[@]}; do
            let "sortedMAJ+=$(ls -R delete   | grep -v '^d' | grep "\.$i" | wc -l) + 
                            $(ls -R favorite | grep -v '^d' | grep "\.$i" | wc -l) + 
                            $(ls -R later    | grep -v '^d' | grep "\.$i" | wc -l)"
            
            let "sortedMIN+=$(ls -R delete   | grep -v '^d' | grep "\.${i,,}" | wc -l) + 
                            $(ls -R favorite | grep -v '^d' | grep "\.${i,,}" | wc -l) + 
                            $(ls -R later    | grep -v '^d' | grep "\.${i,,}" | wc -l)"
        done
        let "sorted=$sortedMIN + $sortedMAJ"
        echo $sorted / $(cat path.txt | wc -l) fichiers triés
    }

    # -----

    case $action in
        0.1)
            chargerFICHIER_chemin_absolu ; choix_01=true ; choix_02=false ;;
        0.2)
            chargerFICHIER_repertoire_courant ; choix_01=false ; choix_02=true ;;
        1.1)
            createDirectory ;;
        1.2)
            deleteDirectory ;;
        2.1)
            lectureAlphabetique ;;
        2.2)
            lectureAleatoire ;;
        3.1)
            creerZIP ; echo ; read -p "ENTRER pour continuer" skip ;;
        3.2)
            extraireZIP ;;
        3.3)
            supprimerZIP ;;
        4)
            nombreFICHIER ; echo ; read -p "ENTRER pour continuer" skip ;;
        exit)
            exit=true ;;
    esac
done
