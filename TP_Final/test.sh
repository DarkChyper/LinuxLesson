#!/bin/bash

wget -O test.html wget -U="Mozilla/5.0" "http://www.larousse.fr/dictionnaires/francais/elephant/" 1>>/dev/null 2>>/dev/null

nbre=`wc -l test.html`
echo nombre de lignes $nbre
debut=`grep -n '<h2 class="AdresseDefinition">' test.html`
echo ligne de debut $debut
fin=`grep -n '</article>' test.html`
echo ligne de fin $fin