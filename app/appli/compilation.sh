lien=$1
echo $lien
lR1=$(echo $lien | cut -d / -f2)
lR2=$(echo $lien | cut -d / -f3)
lR3=$(echo $lien | cut -d / -f4)
lR= echo '~/'$lR1'/'$lR2'/'$lR3'/'
lC1=$(echo $lien | cut -d . -f1)
lC=$(echo $lC1 | cut -d  / -f5)
echo $lR
echo $lC
cd $lR
gnatmake $lien
./$lC > ~/Bureau/editeur-et-traducteur-dalgorithme/app/appli/resultat.txt
rm $lC
