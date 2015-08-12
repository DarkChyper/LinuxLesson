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
	
	# définition des variables
	# On récupère le pseudonyme du joueur
	pseudo=$2
	nbreEssai=7
	finPartie=0
	mot=`sort -R $dictionnaire | head -1`
	lMot=${#mot}
	lettresMot={}
	temp=0
	while [ $temps -lt $lmot ];do
		echo ${mot:$temp:1}
		let "temp += 1"
	done
	while [ $finPartie -ne 1 ];do
		echo $mot
		for lettre in $mot;do
			echo $lettre
		done
		finPartie=1

	done
		
	
fi
