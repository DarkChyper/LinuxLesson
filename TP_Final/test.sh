#!/bin/bash
# Programmeur : WW
# 25/05/08
# Jeu du pendu

# Fonction qui permet de savoir si la dernière lettre tapée par l'utilisateur est contenu dans le mot recherché
# La lettre et le mot sont passés en paramètre

contient() {
	lettreUtilisateur=$1 # Le tableau $* contient tout les paramètres, pour accéder à chacun d'eux on utilise $X où X représente un nombre entre 0 et 9
	mot=$2 # On renomme nos deux paramètres pour augmenter la lisibilité

	if [ ${#lettreUtilisateur} -gt 1 ]; then # Si on tape plus d'une lettre (un mot)
		if [ "$lettreUtilisateur" = "$mot" ]; then # Soit c'était le mot recherché et c'est gagné
			echo "Félicitation. Vous avez gagné."
		else
			echo "Vous avez perdu." # Soit c'est perdu
			echo "Le mot recherché était $mot."
		fi
		fin=11 # Dans les deux cas la partie s'arrête
	fi
	
	if [ $premiereFois -eq 0 ]; then # Quand ce n'est pas la première fois on récupère les lettres trouvées les fois précédentes
		longueur2=${#motTrouveAvant} # ${#CHAINE} permet de récupérer la longueur
		cpt2=0 # Initialisation
		liste=""
		while [ $cpt2 -lt $longueur2 ]; do # Tant que le mot n'est pas fini
			prochainMot2=${motTrouveAvant:1} # On récupère le mot sans sa première lettre
			lettreMot2=${motTrouveAvant%$prochainMot2} # Par soustraction on a la première lettre
			motTrouveAvant=$prochainMot2 # Le mot devient lui-même privé de sa première lettre (il faut bien avancer sur le mot)
			liste=$liste" "$lettreMot2 # On stocke les lettres, chacunes séparées par un espace afin de construire le tableau (tab)
			cpt2=$(($cpt2+1)) # Incrémentation du compteur
		done
		tab=($liste) # Ici, on a le tableau des lettres trouvées les coups précédents
	fi
	
	indice=0
	for l in $lettresDumotATrouver; do # Pour l dans la liste dénifit plus bas (dans le programme principal en dehors de fonction de la même manière que liste de la ligne 26)
		if [ "$l" = "$lettreUtilisateur" ]; then # Si la lettre entrée par l'utilisateur et l'une du mot
			motTrouve=$motTrouve"$l" # On l'écrit dans le mot trouvé par l'utilisateur afin de lui montrer (sinon il verra jamais qu'il a bon)
		else # Sinon
			if [ $premiereFois -eq 1 ]; then # La première fois, on rempli le reste de tirets
				motTrouve=$motTrouve"-"
			else
				motTrouve=$motTrouve${tab[$indice]} # Les fois suivantes, on reprend les caratères du mot trouvé juste avant, celui-ci contient déjà des tirets
			fi
		fi
		indice=$(($indice+1))
	done
	premiereFois=0 # Dès lors que la fonction contient a été appelé, ce n'est plus la première fois (on met à faux, pas de booléen en BASH donc 0)
	if [ "$motTrouve" = "$mot" ]; then # Si le mot trouvé est le mot à trouver
		echo "Bravo. Vous avez gagné."
		fin=11
	fi
	motTrouveAvant=$motTrouve # On stocke le motTrouve car celui ci va être réinitialisé pour être compléter par les coups suivants
}

# Fin de la fonction

if [ $# != 1 -o "$1" = "-h" -o "$1" = "--help" ]; then # Le tableau $* contient tout les arguments passés dans la ligne de commande, on vérifie sa taille si l'utilisateur c'est trompé, on lui affiche l'aide également si il l'a demande (ici via -h ou --help)
	echo "Usage : $0 <mot a trouver>" # L'élément 0 du tableau correspond au nom de la commande
	exit 0; # Puis on quitte
fi
motATrouver=$1 # On récupère l'argument
clear # On vide le terminal, on remarquera qu'un mauvais joueur peux très bien remonter dans le terminal et verra ainsi le mot à trouver
gagne=$motATrouver # On copie motATrouver car il va être modifier afin de récupérer ses lettres
longueur=${#motATrouver} # On nomme sa longueur
longueurmotATrouverEnTiret="" # On initialise la chaîne qui servira à montrer la longueur à l'utilisateur
cpt=0 # Initialisation
motTrouve=""
fin=0
premiereFois=1	# On traite la 1ere fois à part car il n'y a pas encore de mot trouvé avant, la variable est donc initialisée à vrai (ici 1)
lettresDumotATrouver=""

while [ $cpt -lt $longueur ]; do # Même parcours que dans la fonction
	prochainMot=${motATrouver:1}
	lettreMot=${motATrouver%$prochainMot}
	motATrouver=$prochainMot
	lettresDumotATrouver=$lettresDumotATrouver" "$lettreMot
			
	longueurmotATrouverEnTiret=$longueurmotATrouverEnTiret"-" # On a en plus ici, la construction du mot sous forme de tiret
	cpt=$(($cpt+1))
done
echo "A chaque demande de saisie de lettre" # Affichage
echo "vous pouvez saisir votre mot-réponse,"
echo "si ce n'est pas la bonne réponse vous perdez."
echo
echo "Le mot recherché contient $longueur lettres." # Les variables seront bien entendu remplacées par leurs valeurs
echo $longueurmotATrouverEnTiret
echo	# Saut de ligne
while [ $fin -lt 11 ]; do # Tant qu'on est pas au onzième coup
	echo "Entrer une lettre :" # L'utilisateur peux saisir des lettres
	read lettreCherche # La lettre est récupérer dans la variable $lettreCherche
	motTrouve="" # On vide motTrouve (on n'a pas encore trouver la preuve on cherche)
	contient $lettreCherche $gagne # Le mot contient-il la lettre de l'utilisateur
	echo $motTrouve # On affiche mot trouve que la fonction a rempli
	fin=$(($fin+1))
	if [ $fin = 11 ]; then # C'était le dernier coup
		echo "Vous avez perdu." # C'est perdu
		echo "Le mot recherché était $gagne."
	fi
done
exit 0; # On quitte proprement le script
