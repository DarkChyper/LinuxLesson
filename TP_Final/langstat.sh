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
	mot=`sort -R $dictionnaire | head -1`
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
	essais=7
	

	# Debut de la partie !!!
	echo $pseudo la partie commence !

	while [ $finDePartie -ne  1 ];do
		# le joueur peut choisir une lettre
		while [ -z $lettre ];do
			lettre=""
			read -p "Quelle lettre voulez-vous tenter ? " essai

			# on test si le joueur n'a entré qu'un seul caractère
			if [ ${#lettre} -lt 1 ] || [ ${#lettre} -gt 1 ];then
				lettre=""
			else
				essai=${essai^^}
				# on vérifie que l'unique caractère est l'une des lettre de l'alphabet
				for lettre in 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z'
				do
					if [ "$lettre" == "$essai" ];then
						lettre=$essai
					fi
				done
			fi
		echo $lettre
		# fin du choix de la lettre
		# on résoud l'essai
		done

	done
	
fi
