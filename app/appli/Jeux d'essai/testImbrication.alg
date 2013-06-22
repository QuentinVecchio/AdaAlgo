<entete>
module testImbrication()
</entete>
<var>
jesuisici(booleen): test
</var>
<algo>
si jesuisici alors
     valeur <- 2
    sinon si jesuisla alors
     valeur <- valeur +5
     tq valeur < 20 faire
      ecrire("bonjour", valeur)
  repeter
   ecrire(valeur)
   valeur <- valeur +1
  jqa valeur mod 2 = 0
     ftq
    sinon
     cas valeur parmi
      2: ecrire ("A demain !")
      3: si valeur = 0 alors
     pour i <- 1 a 150  faire
      ecrire ("oui")
     fpour
    fsi
     fcas
    fsi
</algo>
