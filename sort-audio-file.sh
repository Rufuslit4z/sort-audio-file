#!/bin/bash

# Le but de ce programme est de pouvoir trier ces propres musiques


exit=false

extensionVLC=("3G2" "3GP" "A52" "AAC" "AC3" "ASF" "ASX" "AVI" "B4S" "BIN"
              "BUP" "CUE" "DAT" "DIVX" "DTS" "DV" "FLAC" "FLV" "GXF" "IFO"
              "M1V" "M2TS" "M2V" "M3U" "M4A" "M4P" "M4V" "MKA" "MKV" "MOD"
              "MOV" "MP1" "MP2" "MP3" "MP4" "MPEG" "MPEG1" "MPEG2" "MPEG4" "MPG"
              "MTS" "MXF" "OGG" "OGM" "OMA" "PART" "PLS" "SPX" "SRT" "TS"
              "VLC" "VOB" "WAV" "WMA" "WMV" "XM" "XSPF")

#printf "%s\n" ${extensionVLC[@]}

#for i in ${extensionVLC[@]}; do
#    echo $i
#done

while [ $exit == false ]; do
    
#    redimension(){
#        actualColumns=$(tput cols)
#        if [ columns != $actualColumns ];then
#            echo variable : $columns
#            echo colonne du terminal $actualColumns
#        fi
#    }
#
#    redimension &

    widthMenu=38
    columns=$(tput cols)

    let "centerMenu=($columns - $widthMenu)/2"

    for i in $(seq 0 $centerMenu)
    do
        space+="-"
    done

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


    space=""
    #echo "extension - Charger votre fichier contenant les extensions"
    echo "0 - Charger les fichiers audio"
    echo "  0.1 - A partir du répertoire courant"
    echo "  0.2 - Tout sur l'ordinateur"
    echo "  0.3 - Celui de votre choix"
    echo
    echo "1 - Gestion des répertoires delete/favorite/later"
    echo "  1.1 - Création"
    echo "  1.2 - Suppression"
    echo
    echo "2 - Lire les fichiers, trier dans les répertoires (d/f/l)"
    echo "  2.1 - Ordre alphabétique"
    echo "  2.2 - Aléatoire"
    echo
    echo "3 - Gestion pour un fichier compressé zip"
    echo "  3.1 - Création du fichier"
    echo "  3.2 - Extraction"
    echo "  3.3 - Suppression"
    echo
    echo "4 - Statistiques"
    echo "  4.1 - Nombre total"
    echo "  4.2 - Fichiers triées"
    echo "  4.3 - Rapport"
    echo
    echo "exit - Quitter le programme"   
    echo

    # METTRE SUR UNE MËME LIGNE
    read -p "Action : " action
   
    #Détecter et charger tout les fichiers audio à partir de ce répertoire courant
    #Enregistrer les chemins relatifs (ou absolue)
    #proposer de charger un endroit spécifique
    #afficher les extensions détectées
    #rendre discret ce qui n'est pas trouvé
    chargerFichierRepertoireCourant(){
        > path.txt
        for i in ${extensionVLC[@]}; do
            find . -name "*.$i" >> path.txt
            find . -name "*.${i,,}" >> path.txt
        done
        echo FOUND:
        sort path.txt
    }

    chargerToutFichier(){
        > path.txt
        for i in ${extensionVLC[@]}; do
            find ~ -name "*.$i" >> path.txt
            find ~ -name "*.${i,,}" >> path.txt
        done
        echo FOUND:
        sort path.txt
    }

    chargerFichierRepertoireDemande(){
        read -p "Répertoire : " dir
        
        > path.txt
        for i in ${extensionVLC[@]}; do
            find $dir -name "*.$i" >> path.txt
            find $dir -name "*.${i,,}" >> path.txt
        done
        echo FOUND:
        sort path.txt  
    }

    # -----

    createDirectory(){
        if [ ! -d "delete" ]; then
            mkdir -v delete;
        fi
        
        if [ ! -d "favorite" ]; then
            mkdir -v favorite;
        fi

        if [ ! -d "later" ]; then
            mkdir -v later;
        fi
    }

    deleteDirectory(){
        if [ -d "delete" ]; then
            rm -rv delete
        fi

        if [ -d "favorite" ]; then
            rm -rv favorite
        fi

        if [ -d "later" ]; then
            rm -rv later
        fi
    }

    # ----

    choix(){
        # remplacer par un switch case
        if [ $1 = "d" ]; then
            mv "$2" delete
        elif [ $1 = "f" ]; then
            mv "$2" favorite
        elif [ "$1" = "l" ]; then
            mv "$2" later
        elif [ $1 = "exit" ]; then
            echo exit 
        fi
    }

    lectureAlphabetique(){
        while read line; do
            vlc "$line"
            read -p "Votre décision d/f/l | exit : " decision </dev/tty
            if [ $(choix $decision "$line") = "exit" ]; then
                break
            fi
        done < <(sort path.txt)

        # AJOUTER DU CODE POUR DEPLACER LE FICHIER DANS LE REPERTOIRE VOULUT
    }

    lectureAleatoire(){
        while read line; do
            vlc "$line"
            read -p "Votre décision d/f/l | exit : " decision </dev/tty
            if [ $(choix $decision "$line") = "exit" ]; then
                break
            fi
        done < <(sort --random-sort path.txt)
        # AJOUTER DU CODE POUR DEPLACER LE FICHIER DANS LE REPERTOIRE VOULUT
    }


    # -----
    # PLUTOT FAIRE UN SWITCH CASE

    if [ $action == "0.1" ]; then
        chargerFichierRepertoireCourant
    elif [ $action == "0.2" ]; then
        chargerToutFichier
    elif [ $action == "0.3" ]; then
        chargerFichierRepertoireDemande
        #------------------------------------------------------
        #------------------------------------------------------        
    elif [ $action == "1.1" ]; then
        createDirectory
    elif [ $action == "1.2" ]; then
        deleteDirectory
        #------------------------------------------------------
        #------------------------------------------------------
    elif [ $action == "2.1" ]; then
        lectureAlphabetique
    elif [ $action == "2.2" ]; then
        lectureAleatoire
    fi   


    if [ $action == "exit" ]; then
        exit=true;
    fi

done
