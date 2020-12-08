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
# Initialisation du tableau
# Insertion des extensions lisibles par VLC
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
    # 38 étant le nombre de "#" présent dans le menu
    widthMENU=38
    # Récupérer le nombre de colonnes du terminal
    # Redimensionner le terminal modifie cette valeur
    columns=$(tput cols)
    # Connaître le nombre qu'il faut de caractère pour ajuster les "#"
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

    # Réinitialiser la variable afin que le positionnement du menu ne soit pas rompu
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
    
    # ------------------- Partie 0.x ------------------- #
    # ------------------- 0.1
    # Récupérer les chemins absolus des fichiers audio via le répertoire indiqué
    # Enregistrer les données
    # exemple : /home/username/Musique/DISCO /home/username/Musique/ROCK

    chargerFICHIER_chemin_absolu(){
        # Demander le(s) répertoire(s)
        read -p "Répertoire : " dir

        # Initialisation du tableau
        dirsABSOLUTE=()
        
        # On affiche le chemin absolu
        # --------- Expression régulière
        # --------- Remplacer " " par "\n"
        # --------- "\n" -> retour à la ligne
        # --------- "///g" -> toutes les occurrences
        # -------------------------- Sauvegarder dans le fichier
        echo $dir | sed 's/ /\n/g' > tmp
        
        # Enregistrer dans le tableau les chemins absolus
        while read value; do
            dirsABSOLUTE+=("$value")
        done < tmp

        # Supprimer le fichier
        rm tmp

        # Afficher le répertoire
        # --------- Expression régulière
        # --------- Remplacer tout les " " par "\n"
        # -------------------------- rev -> reverse
        # -------------------------- exemple : echo | bonjour | rev -> ruojnob
        # -------------------------------- On sélectionne le nom du répertoire parent
        # ------------------------------------------------- Remettre à l'endroit
        # ------------------------------------------------------- Enregistrer        
        echo $dir | sed 's/\"//' | sed 's/ /\n/g' | rev | cut -d '/' -f1 | rev > tmp

        # Enregistrer les noms des répertoires parents
        while read value; do
            dirsNAME+=("$value")
        done < tmp

        # Supprimer
        rm tmp

        # Créer OU écraser les données de path.txt
        > path.txt
        # Pour toutes les extensions lisibles par VLC
        for i in ${extensionVLC[@]}; do
            # Pour tous les chemins absolus
            for j in ${dirsABSOLUTE[@]}; do
                # Rechercher les fichiers lisibles
                find $j -name "*.$i" >> path.txt
                find $j -name "*.${i,,}" >> path.txt
            done
        done
        echo FOUND:
        # Lire le fichier trié dans l'ordre alphabétique
        while read value; do
            # Pour tous les répertoires parents
            for i in ${dirsNAME[@]}; do
                # Supprimer la partie de gauche du répertoire parent et garder la partie de droite
                # ----------- "." -> un caractère
                # ----------- "*" -> 0 ou plusieurs
                # ----------- \(valeur\) -> valeur à garder
                # ----------- "\1" -> remplacer par la valeur gardée
                # ----------- Pour tout ce qui est avant "$i", on supprime puis on garde "$i" et le reste   
            echo $value | sed 's/.*\('$i'\)/\1/'    
            done
        # Boucler sur une sortie de commande
        done < <(sort path.txt)
        echo
        nombreFICHIER
        echo
        # Attendre avant de continuer le programme
        read -p "ENTRER pour continuer" skip
    }
    
    # ------------------- 0.2
    # Même principe, cependant à partir du répertoire courant
    # exemple : DISCO ROCK
    chargerFICHIER_repertoire_courant(){
        # Demander le répertoire        
        read -p "Répertoire : " dir
      
        # Initialiser tableau
        dirs=()
        
        # "$dir" dans le cas où la chaîne contient des espaces
        # ----------- Expression régulière
        # ----------- Supprimer les "
        # --------------------------- Remplacer les " " par "\n"
        echo "$dir" | sed 's/\"//g' | sed 's/ /\n/g' > tmp        
        while read value; do
            # Récupérer la liste de répertoire 
            dirs+=("$value")
        done < tmp

        rm tmp
        
        > path.txt
        # Pour tous les formats
        for i in ${extensionVLC[@]}; do
            # Pour tout les répertoires            
            for j in ${dirs[@]}; do
                # Sauvegarder le chemin des fichiers
                find $j -name "*.$i" >> path.txt
                find $j -name "*.${i,,}" >> path.txt
            done        
        done
        echo FOUND:
        sort path.txt
        echo
        # Afficher le nombre de fichiers à lire / triés
        nombreFICHIER
        echo
        # Demander avant de continuer
        read -p "ENTRER pour continuer" skip
    }

    # ------------------- Partie 1.x ------------------- #
    # ------------------- 1.1
    # Créer les répertoires delete/favorite/later
    createDirectory(){
        # Vérifier si le répertoire existe
        # Si non -> le créer
        if [ ! -d "delete" ]  ; then mkdir -v delete;   fi
        if [ ! -d "favorite" ]; then mkdir -v favorite; fi
        if [ ! -d "later" ]   ; then mkdir -v later;    fi
    }
    
    # ------------------- 1.2
    # Suppression des répertoires
    deleteDirectory(){
        if [ -d "delete" ]  ; then rm -rv delete;   fi
        if [ -d "favorite" ]; then rm -rv favorite; fi
        if [ -d "later" ]   ; then rm -rv later;    fi
    }

    # ------------------- Partie Destination ------------------- #
    # Envoyer un fichier vers un répertoire destinataire
    choix(){
        # Case Statement
        # Plus joli qu'une série de if ; elif ; else
        # $1 -> Paramètre 1 de la fonction = décision
        # Si cette valeur contient d/f/l/exit
        case $1 in 
            d)
                # Si choix "0.1" est à vrai
                if [ $choix_01 = true ]; then
                    # Pour tous les répertoires parent
                    for i in ${dirsNAME[@]}; do
                        # ----------------------- $2 -> Paramètre 2 de la fonction = chemin du fichier à lire
                        # ----------------------------------- Ne garder que $i et ce qui est à sa droite
                        # ----------------------------------- exemple : ROCK/Linkin Park/Linkin Park - Faint.mp3
                        pathDIR=$(cat path.txt | grep "$2" | sed 's/.*\('"$i"'\)/\1/')
                        # Le chemin absolu du fichier                        
                        absolutePATHfile=$(cat path.txt | grep "$2")                        
                        # Le nom du fichier                        
                        fileNAME=$(echo $pathDIR | rev | cut -d '/' -f1 | rev)
                        pathDIR=$(echo $pathDIR | sed 's/\(.*\)'"$fileNAME"'/\1/')
                        echo > /dev/tty
                        # ------------------------------------- renvoyer vers le terminal
                        # ------------------------------------- il me semble qu'un echo dans une fonction
                        # ------------------------------------- permet de retourner une valeur
                        # ------------------------------------- alors /dev/tty est une alternative
                        echo "$fileNAME ENVOYE VERS delete/$pathDIR" > /dev/tty
                        # Faire sauter une ligne dans le terminal
                        echo > /dev/tty
                        # Créer l'arborescence 
                        mkdir -p delete/"$pathDIR"
                        # Déplacer le fichier
                        mv "$absolutePATHfile" delete/"$pathDIR"
                    done
                
                # Si c'est le choix "0.2"
                else
                    # ----------------------- Récupérer le chemin à lire
                    pathFILE=$(cat path.txt | grep "$2")
                    echo > /dev/tty
                    echo $pathFILE " ENVOYE VERS delete/" > /dev/tty
                    echo > /dev/tty
                    # Copy
                    cp -r --parent "$pathFILE" delete/
                    # Suppression                    
                    rm "$pathFILE"
                fi
                ;;
            f)
                # " . . . . . . . "
                if [ $choix_01 = true ]; then
                    for i in ${dirsNAME[@]}; do
                        absolutePATHfile=$(cat path.txt | grep "$2")                        
                        pathDIR=$(cat path.txt | grep "$2" | sed 's/.*\('"$i"'\)/\1/')
                        fileNAME=$(echo $pathDIR | rev | cut -d '/' -f1 | rev)
                        pathDIR=$(echo $pathDIR | sed 's/\(.*\)'"$fileNAME"'/\1/')
                        echo > /dev/tty
                        echo "$fileNAME ENVOYE VERS favorite/$pathDIR" > /dev/tty
                        echo > /dev/tty
                        mkdir -p favorite/"$pathDIR"
                        mv "$absolutePATHfile" favorite/"$pathDIR"
                    done
                else
                    pathFILE=$(cat path.txt | grep "$2")
                    echo > /dev/tty               
                    echo $pathFILE " ENVOYE VERS favorite/" > /dev/tty
                    echo > /dev/tty
                    cp -r --parent "$pathFILE" favorite/
                    rm "$pathFILE"
                fi
                ;;
            l)
                # " . . . . . . . "
                if [ $choix_01 = true ]; then
                    for i in ${dirsNAME[@]}; do
                        absolutePATHfile=$(cat path.txt | grep "$2")                        
                        pathDIR=$(cat path.txt | grep "$2" | sed 's/.*\('"$i"'\)/\1/')
                        fileNAME=$(echo $pathDIR | rev | cut -d '/' -f1 | rev)
                        pathDIR=$(echo $pathDIR | sed 's/\(.*\)'"$fileNAME"'/\1/')
                        echo > /dev/tty
                        echo "$fileNAME ENVOYE VERS later/$pathDIR" > /dev/tty
                        echo > /dev/tty
                        mkdir -p later/"$pathDIR"
                        mv "$absolutePATHfile" later/"$pathDIR"
                    done
                else
                    pathFILE=$(cat path.txt | grep "$2")
                    echo > /dev/tty               
                    echo $pathFILE " ENVOYE VERS later" > /dev/tty
                    echo > /dev/tty
                    cp -r --parent "$pathFILE" later/
                    rm "$pathFILE"
                fi
                ;;           
            exit)
                echo exit
                ;; 
        esac
    }

    # ------------------- Partie 2.x - Ordre de lecture ------------------- #
    # ------------------- 2.1
    lectureAlphabetique(){
        # Lire les chemins triés dans l'ordre alphabétique
        while read line; do
            # Lancer le fichier avec vlc
            vlc "$line"
            # Décider de sa destination
            read -p "Votre décision d/f/l | exit : " decision </dev/tty
            # Tester la fonction choix(decision, chemin)
            # ----------- Param 1
            # ---------------------- Param 2
            if [ "$(choix $decision "$line")" = "exit" ] ; then break ; fi
        done < <(sort path.txt)
    }
    
    # ------------------- 2.2 
    lectureAleatoire(){
        # Lire les chemins mélangés
        while read line; do
            # " . . . . . . . "
            vlc "$line"
            # " . . . . . . . "
            read -p "Votre décision d/f/l | exit : " decision </dev/tty
            # " . . . . . . . "
            if [ "$(choix $decision "$line")" = "exit" ] ; then break ; fi
        done < <(sort -R path.txt)
    }


    # ------------------- Partie 3.x ------------------- #
    # ------------------- 3.1
    creerZIP(){
        # zip -> créer un fichier compressé
        # -r -> Récursif, prendre tout ce qu'il y a dans les répertoires indiqués
        zip -r sort.zip delete favorite later
    }

    # ------------------- 3.2
    extraireZIP(){
        # unzip -> décompresser un .zip
        unzip sort.zip
    }

    # ------------------- 3.3
    supprimerZIP(){
        # Le supprimer        
        rm sort.zip
    }

    # ------------------- Compter les fichiers en cours de trie ------------------- #
    nombreFICHIER(){

        # TODO -> TODO -> TODO -> TODO -> TODO -> TODO -> TODO -> TODO -> TODO -> TODO -> TODO #
        # IL Y A UN SOUCIS
        # La fonction ne compare pas le nom des fichiers présent dans les répertoires
        # delete/favorite/later
        # Avec celui du fichier path.txt
        # Par conséquent si en tout il y a 150 fichiers dans les 3 répertoires
        # Et que dans le fichier path.txt il y a 36 chemins absolus
        # Alors l'affichage sera : 150 / 36 fichiers triés
        # CE QUI N'EST PAS BON
        # TODO -> TODO -> TODO -> TODO -> TODO -> TODO -> TODO -> TODO TODO -> TODO -> TODO -> #

        # Reconnaissance de fichier avec l'extension en minuscule, exemple : filename.mp3
        # ----------- ext en MAJ, filename.MP3
        sortedMIN=0 ; sortedMAJ=0
        # Pour toutes les extensions connut de vlc
        for i in ${extensionVLC[@]}; do
            # On additionne les nombres trouvés
            # ls -> Lister
            # ------------------ -R -> récursif, lister tous les fichiers de delete/
            # -------------------------------- ------- ^ -> début de chaîne
            # -------------------------------- Le but est d'obtenir le contenu de ls
            # -------------------------------- de façon à que chaque résultat ait sa PROPRE ligne
            # -------------------------------- un " " car aucun fichier n'en contient au début de son nom
            # -------------------------------- -v -> Inverser le sens des matchs
            # -------------------------------- il permet d'afficher les résultats alors que normalement
            # -------------------------------- cette commande ne retourne rien
            let "sortedMAJ+=$(ls -R delete   | grep -v '^ ' | grep "\.$i" | wc -l) + 
                            $(ls -R favorite | grep -v '^ ' | grep "\.$i" | wc -l) + 
                            $(ls -R later    | grep -v '^ ' | grep "\.$i" | wc -l)"
            
            let "sortedMIN+=$(ls -R delete   | grep -v '^ ' | grep "\.${i,,}" | wc -l) + 
                            $(ls -R favorite | grep -v '^ ' | grep "\.${i,,}" | wc -l) + 
                            $(ls -R later    | grep -v '^ ' | grep "\.${i,,}" | wc -l)"
        done
        # Addition
        let "sorted=$sortedMIN + $sortedMAJ"
        # Affichage; exemple : 7 / 15 fichiers triés        
        echo $sorted / $(cat path.txt | wc -l) fichiers triés
    }

    # ------------------- Partie Action ------------------- #
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
            # Quitter le programme
            exit=true ;;
    esac
done
