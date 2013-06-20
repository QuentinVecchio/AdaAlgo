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
 resultat:T_tab_lexique;
 resultat_conv:T_Tab_Ligne;

	begin
	
	Creer_liste(testlexique, CreateChaine("nom,prenom(reel)"));
	Ajout_queue(testlexique, CreateChaine("existe(booleen):dis si la personne existe ou non"));
	Ajout_queue(testlexique, CreateChaine("departement(cste/reel=57.8)"));
	--Ajout_queue(testlexique, CreateChaine("Moyenne(module):calcul la moyenne d'une personne"));
	Ajout_queue(testlexique, CreateChaine("total_eleve(type)=table[1..100]reel"));
	--Ajout_queue(testlexique, CreateChaine("Coefficient(fonction/integer):calcul le coefficient d'une matière"));
	Ajout_queue(testlexique, CreateChaine("carte_identite(type)=structure(nom:integer;date_naissance:reel;fille:booleen)"));

	Affiche_liste(testlexique);
	analyseLexique(testlexique,resultat);
	--New_Line;
	Put("------------------------------------");
	New_Line;
	--Affiche_liste(resultat);
	conversionLexique(resultat,resultat_conv);
	Affiche_liste(resultat_conv);
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