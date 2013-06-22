lien=$1
echo $lien
lR1=$(echo $lien | cut -d / -f2)
lR2=$(echo $lien | cut -d / -f3)
lR3=$(echo $lien | cut -d / -f4)
lR= echo 
lC1=$(echo $lien | cut -d . -f1)
#recupere le nom du fichier
lC=$(echo $lC1 | cut -d  / -f5)
echo $lR
echo $lC
cd $lR
gnatmake '/'$lR1'/'$lR2'/'$lR3'/'$lC".adb"
cd '/'$lR1'/'$lR2'/'$lR3'/'
ls
./$lC > ~/Bureau/editeur-et-traducteur-dalgorithme/app/appli/resultat.txt
rm $lC
