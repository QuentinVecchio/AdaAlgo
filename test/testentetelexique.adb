with simple_io, mstring, definitions, liste, entetelexique, typeenum;
use simple_io, mstring, definitions, entetelexique;

procedure testentetelexique is
-- essai:string:=("nom(cste.type=189987976)");
-- lala:T_Tab_Chaine;
-- typeligne:T_typeline;
-- -- com:chaine;
-- typel:chaine;
-- 	nom:string:="eleve";
-- 	commentaire:string:="kiohuihuih";
-- 	--ensElement:string:="nom:chaine,age:integer";
-- 	resultat:ligne(fonction);
-- 	typeretour:string:="integer";
-- 	package afficheTypeLigne is new typeenum(T_typeline);
-- 	use afficheTypeLigne;
  testlexique: T_Tab_Ligne;
  resultat:T_tab_Lexique;
  resultat_conv:T_Tab_Ligne;
		exemple1:string:="Fonction RempliTab( ↓N:entier; ↓ ↑T:reel; ↓a:booleen; ↑b:chaine):entier";
--  chaine1:chaine;
--  chaine2:chaine;
--  exemple2:string:="dents";
--  existe:boolean;
--  type_variable:chaine;
--  exemple_fonction:string:="fonction PosMin (↓N:entier;↓T:T_Tabcar;↑imax,imin:entier)";
 	exemple:chaine;
 	resultat_exemple:chaine;
	begin
	
 	exemple:=createchaine(exemple1);
-- 	resultat_exemple:=ChangementdeType(exemple);
-- 	Put(resultat_exemple);
 	conversionEntete(exemple,resultat_exemple);
 	Put(resultat_exemple);
	
-- 	Creer_liste(testlexique, CreateChaine("nom,prenom(T_tab_Lexique)"));
-- 	Ajout_queue(testlexique, CreateChaine("existe(caractere):dis si la personne existe ou non"));
-- 	Ajout_queue(testlexique, CreateChaine("departement(cste/reel=57.8)"));
-- 	Ajout_queue(testlexique, CreateChaine("Moyenne(module):calcul la moyenne d'une personne"));
-- 	Ajout_queue(testlexique, CreateChaine("total_eleve(type)=table[1..100]reel"));
-- 	Ajout_queue(testlexique, CreateChaine("Coefficient(fonction/integer):calcul le coefficient d'une matière"));
-- 	Ajout_queue(testlexique, CreateChaine("carte_identite(type)=structure(nom:entier;date_naissance:reel;fille:booleen)"));
-- 
-- -- 	--Affiche_liste(testlexique);
--  	analyseLexique(testlexique,resultat);
-- -- 	New_Line;
--  	Put("------------------------------------");
--  	New_Line;
-- -- -- 	chaine1:=CreateChaine(exemple1);
-- -- -- 	chaine2:=CreateChaine(exemple2);
--   	Affiche_liste(resultat);
-- -- -- 	Put("oooooooooooooooooooooooooooooooooooooooo");
-- -- -- 	New_Line;
--  	conversionLexique(resultat,resultat_conv);
--  	Affiche_liste(resultat_conv);
-- 	variableExiste(resultat,chaine1,existe,type_variable);
-- 	--Put_line(existe);
-- 	if (existe) then
-- 		Put("La variable existe, son type est: ");
-- 		Put_Line(type_variable);
-- 	else
-- 		Put("La variable n'existe pas dans cette liste");
-- 	end if;
--lala:= donneListeNom(createchaine(essai));
 --Affiche_liste(lala);
 --typeligne:=donneTypeLigne(createchaine(essai));
	--put_line(typeligne);
		--com:=donneCommentaire(createchaine(essai));
-- 		typel:=donneValeurConstante(createchaine(essai));
-- 		Put_Line(typel);
-- 		resultat:=donnerFonction(createchaine(nom),createchaine(commentaire),createchaine(typeretour));
-- 		affiche(resultat);
end testentetelexique;