#!/bin/sh

# ####################################################### #
# TP générateur de galerie d'image du site OpenClassRooms #
# ------------------------------------------------------- #

# à partir de n'importe quel dossier
#  _ trouve les images .jpg
#  _ crée une miniature de chacune des images dans le dossier ./.thumbs
#  _ génère une page HTML listant les miniatures
#    chaque miniature étant un lien vers l'originale

# prend 1 paramètre optionnel 
#  $1 : le nom du fichier html généré
# ####################################################### #

# On commence par récupérer le nom de la page s'il est précisé
ficOut=$1
if [ -z $ficOut ];then
	ficOut=galerie.html
fi

# definition des variables
repertoire=`pwd`
sousRep='thumbs'

# on génére le début de la page html
echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">' > $ficOut
echo '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" >' >> $ficOut
echo '   <head>' >> $ficOut
echo '       <title>Ma galerie</title>' >> $ficOut
echo '       <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />' >> $ficOut
echo '       <style type="text/css">' >> $ficOut
echo '      a img { border:0; }' >> $ficOut
echo '      </style>' >> $ficOut
echo ' </head>' >> $ficOut
echo '  <body>' >> $ficOut
echo '     <p>' >> $ficOut

for image in `ls *.png *.jpg *.jpeg *.gif 2>/dev/null`
do
        convert $image -thumbnail '10%' $sousRep/$image
        echo '<a href="'$image'"><img src="'$sousRep'/'$image'" alt="" /> </a> '>> $ficOut
done

# on génére la fin de la page html
echo '</p>
  </body>
</html>' >> $ficOut

