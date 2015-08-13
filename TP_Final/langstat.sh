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
	# On génére le fichier temporaire
	echo '' >> TEMP
	# pour chaque lettre de l'alphabet, on compte son occurence dans le fichier
	for lettre in 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z'
		do
			compteur=`grep -c -E "([^$lettre]*$lettre){1}" $dictionnaire`
			#compteur=`grep -c $lettre $dictionnaire`
			echo "$compteur	- $lettre" >> TEMP
		done
	cat TEMP | sort -k1nr 
	rm TEMP
else
	# mission 2 : un pendu :-)
	echo '# ############################## #'
	echo '# BIENVENUE DANS LE JEU DE PENDU #'
	echo '# ------------------------------ #'
	echo '#  chargement du mot a trouver   #'
	
	# définition des variables
	# On récupère le pseudonyme du joueur
	pseudo=$2

	# On choisit au hasard un mot dans le dictionnaire
	#mot=`sort -R $dictionnaire | head -1`
	mot="testa"
	longueur=${#mot}
	let "longueur -= 1"

	# on prépare le mot à trouver
	motATrouver=""
	temp=0
	while [ $temp -lt $longueur ];do
		if [ ${mot:$temp:1} == "-" ];then
			motATrouver=${motATrouver}${mot:$temp:1}
		else
			motATrouver=${motATrouver}"_"
		fi
		let "temp += 1"
	done

	# on définit les variables du jeu
	finDePartie=0
	nbEssais=7
	texte="Tu as le droit de te tromper 7 fois"

	# Debut de la partie !!!
	echo $pseudo la partie commence !

	while [ $finDePartie -ne  1 ];do
		# ETAPE 0
		# On affiche l'état de la partie
		# affichage du pendu

		# affichage du texte
		echo ${texte}
		
		# affichage du mot à trouver
		echo "Le mot à trouver : ${motATrouver}"
		
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
		motAAfficher="" # le mot a afficher sera construit dedans
		essaiOK=0 # passera a 1 si le joueur a trouvé une lettre du mot, sinon il perdra 1 au $nbEssais
		temp=0 # on initialise la position du curseur
		while [ $temp -lt $longueur ];do
			if [ "${motATrouver:$temp:1}" == "_" ];then
				# si on a bien une lettre a trouver, on vérifie que la lettre saisie correspond
				if [ "${motATrouver:$temp:1}" == "$lettre"];then
					# si la lettre où se trouve le curseur correspont à l'essai du joueur, on l'affiche
					motAAfficher=${motAAfficher}${lettre}
					essaiOK=1 # on indique que la lettre est apparu au moins une fois
				else
					# sinon on affiche un "_"
					motAAfficher=${motAAfficher}"_"
				fi 
			else
				# Sinon on affiche la lettre ou le tiret qui était déja affiché
				motAAfficher=${motAAfficher}${motATrouver:$temp:1}
				if [ "${motATrouver:$temp:1}" == "${lettre}"];then
					essaiOK=1 # on ne perd pas un essai pour une lettre que l'on avait déjà
				fi
			fi
		done
		# din de l'étape 2

		motATrouver=$motAAfficher
		# ETAPE 3 
		# On résoud le coup du joueur
		if [ $essaiOK -ne 1 ];then # la lettre n'est pas dans le mot à découvrir
			let "nbEssais -= 1"
			texte="La lettre $lettre n'est pas dans le mot à découvrir"
			if [ $nbEssais -eq 0 ];then # déclenche la fin de partie en échec
				echo "${texte}\nVous n'avez plus d'essai $pseudonyme. Vous avez perdu.\nLe mot à découvrir était ${mot}."
				finDePartie=1
			else
				teste=${texte}"\nIl vous reste $nbEssais essais.\n" 
			fi
		else
			# le joueur a trouver une lettre
			if [ "${motATrouver}" == "${mot}" ];then # déclenche la fin de partie avec succès
				finDePartie=1
				echo "Bravo $pseudonyme, tu as trouvé le mot avant d'être pendu !\n le mot était bien ${mot}."
			else 
				texte="La lettre ${lettre} fait bien partie du mot à trouver.\n"
		fi


	done
	echo "FIN DE PARTIE\nAU REVOIR"
fi
