#!/bin/bash

# ######################################################### #
#                 STATISTIQUES SUR LES MOTS                 #
#          TP FINAL DU COURS LINUX SUR OPENCLASSROOMS       #
# --------------------------------------------------------- #
#                                                           #
# Avec 1 argument, il indique les lettres de l'alphabet     #
# triées selon leur fréquence dans les mots francais du     #
# fichier $1                                                #
#                                                           #
# Avec 2 arguments :                                        #
#           $2: pseudo du joueur au jeu du pendu            #
# ######################################################### #

# On vérifie le fichier du dictionnaire
if [ -z $1 ] || [ ! -e $1 ];then
	echo "Vous devez indiquer un fichier de dictionnaire existant et lisible"
	exit 12
fi

dictionnaire=$1

# On gére la mission 1 : Les statistiques
if [ -z $2 ];then
	# On génére le fichier pointeuroraire
	echo '' >> pointeur
	# pour chaque lettre de l'alphabet, on compte son occurence dans le fichier
	for lettre in 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z'
		do
			compteur=`grep -c -E "([^$lettre]*$lettre){1}" $dictionnaire`
			#compteur=`grep -c $lettre $dictionnaire`
			echo "$compteur	- $lettre" >> pointeur
		done
	cat pointeur | sort -k1nr 
	rm pointeur
else
	# mission 2 : un pendu :-)
	clear
	echo '# ######################################### #'
	echo '#      BIENVENUE DANS LE JEU DE PENDU       #'
	echo '# ----------------------------------------- #'
	echo '#       chargement du mot a trouver         #'
	echo '# ######################################### #'
	# définition des variables
	# On récupère le pseudonyme du joueur
	pseudonyme=$2

	# On choisit au hasard un mot dans le dictionnaire
	mot=`sort -R $dictionnaire | head -1`
	# le mot contient un retour à la ligne qu'il faut supprimer
	longueur=${#mot}
	let "longueur -= 1"

	# on prépare le mot à trouver en supprimant en même temps le retour à la ligne
	motDevoile=""
	motTemporaire=""
	pointeur=0
	while [ $pointeur -lt $longueur ];do
		if [ ${mot:$pointeur:1} == "-" ];then
			motDevoile=${motDevoile}${mot:$pointeur:1}
			motTemporaire=${motTemporaire}${mot:$pointeur:1}
		else
			motDevoile=${motDevoile}"_"
			motTemporaire=${motTemporaire}${mot:$pointeur:1}
		fi
		let "pointeur += 1"
	done
	mot=$motTemporaire

	tableau=()
	tableau[0]="    _______ \n   //   | \n  ||    0 \n  ||   /|\ \n  ||   / \ \n_/||__"
	tableau[1]="    _______ \n   //   | \n  ||    0 \n  ||   /|\ \n  ||   /  \n_/||__"
	tableau[2]="    _______ \n   //   | \n  ||    0 \n  ||   /|\ \n  ||  \n_/||__"
	tableau[3]="    _______ \n   //   | \n  ||    0 \n  ||   /| \n  ||  \n_/||__"
	tableau[4]="    _______ \n   //   | \n  ||    0 \n  ||   | \n  ||  \n_/||__"
	tableau[5]="    _______ \n   //   | \n  ||    0 \n  ||    \n  ||  \n_/||__"
	tableau[6]="    _______ \n   //   | \n  ||     \n  ||    \n  ||  \n_/||__"
	tableau[7]="    _______ \n   // \n  || \n  ||   | \n  ||  \n_/||__"


	# on définit les variables du jeu
	finDePartie=0
	nbEssais=7
	texte="Tu as le droit de te tromper $nbEssais fois"

	# Debut de la partie !!!
	echo "${pseudonyme} la partie commence !"

	while [ ${finDePartie} -ne  1 ];do
		# ETAPE 0
		# On affiche l'état de la partie
		# affichage du pendu
		nbEssaisCorrige=0
		let "nbEssaisCorrige = nbEssais + 1"
		# on décale de 1 le nombre d'essais infructueux autorisé pour 
		# ne pas être totalement pendu lorsqu'il nous reste 0 erreur possible
		case $nbEssaisCorrige in
			0)
				echo -e "   _______ \n  //    | \n  ||    0 \n  ||   /|\ \n  ||   / \ \n_/||_______"
				;;
			1)	
				echo -e "   _______ \n  //    | \n  ||    0 \n  ||   /|\ \n  ||   /   \n_/||_______"
				;;
			2)
				echo -e "   _______ \n  //    | \n  ||    0 \n  ||   /|\ \n  ||       \n_/||_______"
				;;
			3)
				echo -e "   _______ \n  //    | \n  ||    0 \n  ||   /|  \n  ||       \n_/||_______"
				;;
			4)
				echo -e "   _______ \n  //    | \n  ||    0 \n  ||    |  \n  ||       \n_/||_______"
				;;
			5)
				echo -e "   _______ \n  //    | \n  ||    0 \n  ||       \n  ||       \n_/||_______"
				;;
			6)
				echo -e "   _______ \n  //    | \n  ||      \n  ||       \n  ||       \n_/||_______"
				;;
			7)
				echo -e "   _______ \n  //      \n  ||      \n  ||       \n  ||       \n_/||_______"
				;;
			8)
				echo -e "           \n  //      \n  ||      \n  ||       \n  ||       \n_/||_______"
				;;
		esac

		# affichage du texte
		echo -e "${texte}"
		
		# affichage du mot à trouver
		echo "Le mot à trouver : ${motDevoile}"
		
		# ETAPE 1
		# Le joueur choisit une lettre a tester, 
		# 1 seul caractère alphabétique sans accent, 
		# ignore la casse
		lettre=""
		while [ -z $lettre ];do
			
			read -p "Quelle lettre voulez-vous tenter ? " essai

			# on test si le joueur n'a entré qu'un seul caractère
			if [ ${#essai} -lt 1 ] || [ ${#essai} -gt 1 ];then
				lettre=""
				echo "Il faut teste 1 seul caractère alphabétique sans accent à la fois."
			else
				essai=`echo "$essai" | tr '[:lower:]' '[:upper:]'`
				# on vérifie que l'unique caractère est l'une des lettre de l'alphabet
				for lettreATester in 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z'
					do
					if [ "$lettreATester" == "$essai" ];then
						lettre=$essai
					fi
					done
			fi	
		done
		# fin de l'étape 1, la lettre est choisie

		# ETAPE 2
		# On vérifie si la lettre apparait dans le mot.
		# Si la lettre apparait on ne décompte pas d'essai
		# Si la lettre etait déjà découverte, on ne perd pas un essai
		motTemporaire="" # le mot a afficher sera construit dedans
		essaiOK=0 # passera a 1 si le joueur a trouvé une lettre du mot, sinon il perdra 1 au $nbEssais
		pointeur=0 # on initialise la position du curseur qui va se déplaccer lettre à lettre dans le mot 
		while [ $pointeur -lt $longueur ];do

			if [ "${motDevoile:${pointeur}:1}" = "_" ];then 
			#### on est dans le cas où le pointeur pointe une lettre non trouvée

				if [ "${mot:$pointeur:1}" = "$lettre" ];then
					# si la lettre où se trouve le curseur correspond à l'essai du joueur, on l'affiche
					motTemporaire=${motTemporaire}${lettre}
					essaiOK=1 # on indique que la lettre est apparu au moins une fois
				else
					# sinon on affiche un "_"
					motTemporaire=${motTemporaire}"_"
				fi 
			else
			#### Sinon on affiche la lettre ou le tiret qui était déja affiché
				motTemporaire=${motTemporaire}${mot:$pointeur:1}
				if [ "${motDevoile:$pointeur:1}" = "${lettre}" ];then
					essaiOK=1 # on ne perd pas un essai pour une lettre que l'on avait déjà
				fi

			fi
			let "pointeur += 1"
		done
		# fin de l'étape 2

		motDevoile=$motTemporaire
		# ETAPE 3 
		# On résoud le coup du joueur
		if [ $essaiOK -ne 1 ];then # la lettre n'est pas dans le mot à découvrir
			let "nbEssais -= 1"
			texte="La lettre $lettre n'est pas dans le mot à découvrir\nTu as le droit de te tromper $nbEssais fois."

			if [ $nbEssais -lt 0 ];then # déclenche la fin de partie en échec
				clear 
				echo -e "   _______ \n  //    | \n  ||    0 \n  ||   /|\ \n  ||   / \ \n_/||_______"
				echo -e "${texte}\nVous n'avez plus d'essai $pseudonyme. Vous avez perdu.\nLe mot à découvrir était ${mot}."
				finDePartie=1
			else
				clear # on clean l'écran pour passer à l'essai suivant
			fi
		else
			# le joueur a trouver une lettre
			if [ "${motDevoile}" == "${mot}" ];then # déclenche la fin de partie avec succès
				finDePartie=1
				echo -e "Bravo $pseudonyme, tu as trouvé le mot avant d'être pendu !\n le mot était bien ${mot}."
			else 
				texte="La lettre ${lettre} fait bien partie du mot à trouver.\nTu as le droit de te tromper $nbEssais fois"
				clear # on clean l'écran pour passer à l'essai suivant
			fi
		fi
	done
	
	echo -e "FIN DE PARTIE\nAU REVOIR"

fi
