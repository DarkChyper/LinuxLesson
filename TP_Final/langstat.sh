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
#           $2: 1 mot => vérifie si le mot existe dans le   #
#                fichier ./dico.txt et trouve sa definition #
#                sur www.wiktionnaire.fr sinon indique que  #
#                le mot n'est pas dans la liste.            #
#           $2: * => affiche tous les mots du fichier en 4  #
#                 colonnes                                  #
#           $2: *a => affiche tous les mots commanceant par #
#                 a. fonctionne avec toutes les lettres     #
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
fi
