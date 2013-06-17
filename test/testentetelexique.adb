with simple_io, mstring, definitions, liste, entetelexique, typeenum;
use simple_io, mstring, definitions, entetelexique;

procedure testentetelexique is
essai:string:=("nom(cste.type=189987976)");
-- lala:T_Tab_Chaine;
-- typeligne:T_typeline;
-- com:chaine;
typel:chaine;

-- 	package afficheTypeLigne is new typeenum(T_typeline);
-- 	use afficheTypeLigne;

	begin
--lala:= donneListeNom(createchaine(essai));
 --Affiche_liste(lala);
 --typeligne:=donneTypeLigne(createchaine(essai));
	--put_line(typeligne);
		--com:=donneCommentaire(createchaine(essai));
		typel:=donneValeurConstante(createchaine(essai));
		Put_Line(typel);
			
end testentetelexique;