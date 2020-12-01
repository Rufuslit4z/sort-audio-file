#!/bin/bash

<<<<<<< HEAD
# Le but de ce programme est de pouvoir trier ses propres musiques
=======
# Le but de ce programme est de pouvoir trier ces propres musiques
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca

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
<<<<<<< HEAD
# Insertion des extensions lisibles par VLC
=======
# Insertion des extension lisible par VLC
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
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
<<<<<<< HEAD
    # 38 étant le nombre de "#" présent dans le menu
=======
    # 38 étant le nomnbre de "#" présent dans le menu
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
    widthMENU=38
    # Récupérer le nombre de colonnes du terminal
    # Redimensionner le terminal modifie cette valeur
    columns=$(tput cols)
<<<<<<< HEAD
    # Connaître le nombre qu'il faut de caractère pour ajuster les "#"
=======
    # Connaître le nombre qu'il faut de caractère pour ajuter les "#"
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
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

<<<<<<< HEAD
    # Réinitialiser la variable afin que le positionnement du menu ne soit pas rompu
=======
    # Réinitialiser la variable afin que le positionnement du menu ne soit pas romput
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
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
<<<<<<< HEAD
    
    # ------------------- Partie 0.x ------------------- #
    # ------------------- 0.1
    # Récupérer les chemins absolus des fichiers audio via le répertoire indiqué
    # Enregistrer les données
    # exemple : /home/username/Musique/DISCO /home/username/Musique/ROCK
=======
       
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
    chargerFICHIER_chemin_absolu(){
        # Demander le(s) répertoire(s)
        read -p "Répertoire : " dir

        # Initialisation du tableau
        dirsABSOLUTE=()
        
        # On affiche le chemin absolu
        # --------- Expression régulière
        # --------- Remplacer " " par "\n"
        # --------- "\n" -> retour à la ligne
<<<<<<< HEAD
        # --------- "///g" -> toutes les occurrences
=======
        # --------- "/g" -> toutes les occurences
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
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

<<<<<<< HEAD
        # Enregistrer les noms des répertoires parents
=======
        # Enregistrer le nom des répertoires parents
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
        while read value; do
            dirsNAME+=("$value")
        done < tmp

        # Supprimer
        rm tmp

        # Créer OU écraser les données de path.txt
        > path.txt
        # Pour toutes les extensions lisibles par VLC
        for i in ${extensionVLC[@]}; do
<<<<<<< HEAD
            # Pour tous les chemins absolus
=======
            # Pour tout les chemin absolu
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
            for j in ${dirsABSOLUTE[@]}; do
                # Rechercher les fichiers lisibles
                find $j -name "*.$i" >> path.txt
                find $j -name "*.${i,,}" >> path.txt
            done
        done
        echo FOUND:
        # Lire le fichier trié dans l'ordre alphabétique
        while read value; do
<<<<<<< HEAD
            # Pour tous les répertoires parents
=======
            # Pour tout les répertoires parents
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
            for i in ${dirsNAME[@]}; do
                # Supprimer la partie de gauche du répertoire parent et garder la partie de droite
                # ----------- "." -> un caractère
                # ----------- "*" -> 0 ou plusieurs
                # ----------- \(valeur\) -> valeur à garder
<<<<<<< HEAD
                # ----------- "\1" -> remplacer par la valeur gardée
=======
                # ----------- "\1" -> remplacer par la valeur garder
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
                # ----------- Pour tout ce qui est avant "$i", on supprime puis on garde "$i" et le reste   
            echo $value | sed 's/.*\('$i'\)/\1/'    
            done
        # Boucler sur une sortie de commande
        done < <(sort path.txt)
        echo
        # Attendre avant de continuer le programme
        read -p "ENTRER pour continuer" skip
    }
<<<<<<< HEAD
    
    # ------------------- 0.2
    # Même principe, cependant à partir du répertoire courant
    # exemple : DISCO ROCK
=======

>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
    chargerFICHIER_repertoire_courant(){
        # Demander le répertoire        
        read -p "Répertoire : " dir
      
        # Initialiser tableau
        dirs=()
        
<<<<<<< HEAD
        # "$dir" dans le cas où la chaîne contient des espaces
        # ----------- Expression régulière
        # ----------- Supprimer les "
        # --------------------------- Remplacer les " " par "\n"
        echo "$dir" | sed 's/\"//g' | sed 's/ /\n/g' > tmp        
        while read value; do
            # Récupérer la liste de répertoire 
=======
              
        echo "$dir" | sed 's/\"//g' | sed 's/ /\n/g' > tmp        
        while read value; do
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
            dirs+=("$value")
        done < tmp
        rm tmp
        
        > path.txt
<<<<<<< HEAD
        # Pour tous les formats
        for i in ${extensionVLC[@]}; do
            # Pour tout les répertoires            
            for j in ${dirs[@]}; do
                # Sauvegarder le chemin des fichiers
=======
        for i in ${extensionVLC[@]}; do
            for j in ${dirs[@]}; do
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
                find $j -name "*.$i" >> path.txt
                find $j -name "*.${i,,}" >> path.txt
            done        
        done
        echo FOUND:
        sort path.txt
        echo
<<<<<<< HEAD
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
=======
        nombreFICHIER
        echo
        read -p "ENTRER pour continuer" skip
    }

    # -----

    createDirectory(){
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
        if [ ! -d "delete" ]  ; then mkdir -v delete;   fi
        if [ ! -d "favorite" ]; then mkdir -v favorite; fi
        if [ ! -d "later" ]   ; then mkdir -v later;    fi
    }
<<<<<<< HEAD
    
    # ------------------- 1.2
    # Suppression des répertoires
=======

>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
    deleteDirectory(){
        if [ -d "delete" ]  ; then rm -rv delete;   fi
        if [ -d "favorite" ]; then rm -rv favorite; fi
        if [ -d "later" ]   ; then rm -rv later;    fi
    }

<<<<<<< HEAD
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
                        pathFILE=$(cat path.txt | grep "$2" | sed 's/.*\('$i'\)/\1/')
                        echo > /dev/tty
                        # ------------------------------------- renvoyer vers le terminal
                        # ------------------------------------- il me semble que un echo dans une function
                        # ------------------------------------- permet de retourner une valeur
                        # ------------------------------------- alors /dev/tty est une alternative
                        echo $pathFILE " ENVOYE VERS delete/"> /dev/tty
                        # Faire sauter une ligne dans le terminal
                        echo > /dev/tty
                        # Copier le fichier ET son arborescence vers le répertoire destinataire
                        cp -r --parent "$pathFILE" delete/
                        # Supprimer le fichier à l'emplacement d'origine
                        rm "$pathFILE"
                    done
                # Si c'est le choix "0.2"
                else
                    # ----------------------- Récupérer le chemin à lire
                    pathFILE=$(cat path.txt | grep "$2")
                    echo > /dev/tty
                    echo $pathFILE " ENVOYE VERS delete/"> /dev/tty
                    echo > /dev/tty
                    # Copy
                    cp -r --parent "$pathFILE" delete/
                    # Suppression                    
=======
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
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
                    rm "$pathFILE"
                fi
                ;;
            f)
<<<<<<< HEAD
                # " . . . . . . . "
                if [ $choix_01 = true ]; then
                    for i in ${dirsNAME[@]}; do
                        pathFILE=$(cat path.txt | grep "$2" | sed 's/.*\('$i'\)/\1/')
                        echo > /dev/tty         
                        echo $pathFILE " ENVOYE VERS favorite/"> /dev/tty
                        echo > /dev/tty                       
=======
                if [ $choix_01 = true ]; then
                    for i in ${dirsNAME[@]}; do
                        pathFILE=$(cat path.txt | grep "$2" | sed 's/.*\('$i'\)/\1/')
                        echo                    
                        echo "EN COURS DE LECTURE : "$pathFILE 1>&2
                        echo                        
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
                        cp -r --parent "$pathFILE" favorite/
                        rm "$pathFILE"
                    done
                else
                    pathFILE=$(cat path.txt | grep "$2")
<<<<<<< HEAD
                    echo > /dev/tty               
                    echo $pathFILE " ENVOYE VERS favorite/"> /dev/tty
                    echo > /dev/tty
=======
                    echo                    
                    echo "EN COURS DE LECTURE : "$pathFILE 1>&2
                    echo
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
                    cp -r --parent "$pathFILE" favorite/
                    rm "$pathFILE"
                fi
                ;;
            l)
<<<<<<< HEAD
                # " . . . . . . . "
                if [ $choix_01 = true ]; then
                    for i in ${dirsNAME[@]}; do
                        pathFILE=$(cat path.txt | grep "$2" | sed 's/.*\('$i'\)/\1/')
                        echo > /dev/tty                    
                        echo $pathFILE " ENVOYE VERS later/"> /dev/tty
                        echo > /dev/tty                       
=======
                if [ $choix_01 = true ]; then
                    for i in ${dirsNAME[@]}; do
                        pathFILE=$(cat path.txt | grep "$2" | sed 's/.*\('$i'\)/\1/')
                        echo                    
                        echo "EN COURS DE LECTURE : "$pathFILE 1>&2
                        echo                        
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
                        cp -r --parent "$pathFILE" later/
                        rm "$pathFILE"
                    done
                else
                    pathFILE=$(cat path.txt | grep "$2")
<<<<<<< HEAD
                    echo > /dev/tty               
                    echo $pathFILE " ENVOYE VERS later"> /dev/tty
                    echo > /dev/tty
=======
                    echo                    
                    echo "EN COURS DE LECTURE : "$pathFILE 1>&2
                    echo
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
                    cp -r --parent "$pathFILE" later/
                    rm "$pathFILE"
                fi
                ;;           
            exit)
                echo exit
                ;; 
        esac
    }

<<<<<<< HEAD
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
            if [ $(choix $decision "$line") = "exit" ] ; then break ; fi
=======
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
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
        done < <(sort -R path.txt)
    }


<<<<<<< HEAD
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

        # AJUSTER
        # Le nombre de fichiers triés peut être supérieur au total à trier
        # Tout simplement parce que l'on regarde le fichier path.txt
        # Pour connaître le nombre de fichier à trier
        # Par conséquent il faut aussi vérifier uniquement les fichiers présents
        # Dans les répertoires destinataires
        # Et non pas compter TOUT les fichiers

        # Initialisations
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
=======
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

>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
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
<<<<<<< HEAD
            # Quitter le programme
=======
>>>>>>> c814e2e917809de88b1f1b3d0d60bbdc303ec9ca
            exit=true ;;
    esac
done
