#!/bin/sh

# Script qui renomme les des fichiers en ajoutant des -old à la fin
# Prend 1 parametre non obligatoire : 
# $1 : types de fichiers à renommer

param=$1

while [ -z $param ];do
	read -p 'Entrez les fichiers à renommer : ' param
done

echo $param

for fichier in `ls $param`
do 
	mv $fichier $fichier-old
done

