package body debuglexique is

	function debugggageLexique(tab: T_Tab_ligne; descr : in out T_Tab_Ligne) return boolean is
		ok, ok2 : boolean := True;
		tmp : T_tab_ligne := tab;
		type_Ligne : T_typeLine;
		descrErrors : T_Tab_Ligne;
		
	begin
--put_line(CreateCHaine("ca passe par la"));
--Affiche_liste(tmp);
		While not estVide(tmp) loop
			type_ligne:=donneTypeLigne(donne_tete(tmp));
			if (type_ligne=fonction) then
				ok2:= debugFunction(donne_tete(tmp), descrErrors);
			elsif (type_ligne=variable) then
				ok2:=debugVariable(donne_tete(tmp), descrErrors);
			elsif (type_ligne=constante) then
				ok2:=debugConstante(donne_tete(tmp), descrErrors);
			elsif (type_ligne=structure) then
				ok2:=debugStructure(donne_tete(tmp), descrErrors);
			elsif (type_ligne=table) then
				ok2:=debugTable(donne_tete(tmp), descrErrors);
			elsif (type_ligne=module) then
				ok2:=debugmodule(donne_tete(tmp), descrErrors);
			end if;
			donne_suivant(tmp);
			ok := ok AND ok2;
		end loop;
		return ok;
	end debugggageLexique;


	function donneTypeLigne(ligneCourante: chaine) return T_typeline is
		typeLigne: T_typeline;
		i,j:integer;
		ligne:chaine:=ligneCourante;
		begin
			i:=strpos(ligne, '(');
			ligne:=substring(ligne,i+1,length(ligne)); --réduit tout la partie de la ligne située avant la parenthèse
			-- regarde le premier mot de la ligne et en fonction de ce mot, dis le type de la ligne
			if (startWith(ligne, "cste")) then
				typeLigne:=constante;
			elsif (startWith(ligne, "fonction")) then
				typeLigne:=fonction;
			elsif (startWith(ligne, "module")) then
				typeLigne:=module;
			elsif (startWith(ligne, "type")) then
				j:=strpos(ligne, '=');
				ligne:=substring(ligne,j+1,length(ligne));
				if (startWith(ligne, "table")) then
					typeLigne:=table;
				elsif (startWith(ligne, "structure")) then
					typeLigne:=structure;
				end if;
			else
				typeLigne:=variable;
			end if;
			return typeLigne;
	end donneTypeLigne;


	function debugFunction(L : in chaine; descr: in out T_Tab_Ligne) return boolean is
		ok : boolean := True;
		typeFonct : chaine;
		i, j: integer;
	begin
		i:= strpos(L, '(');
		put_line(CreateChaine("ca passe par la!!"));
		if i /= 0 then
			if NOT estUneVariable(donneNom(L)) then
				ok := ok AND False;
				Ajout_queue(descr, "Votre nom de variable n'est pas conforme : " + L);
			end if;

		
			j:= strpos(L, ')');
			if j = 0 OR j<i then
				ok := ok AND False;
				Ajout_queue(descr, "Erreur de pairage des parentheses : " + L);
--			else
--				
--				typeFonct := substring(L, i+1, j-1);
---				put_line(typeFonct);
--				typeFonct := substring(L, 9, length(typeFonct));
--				put_line(typeFonct);
--				if NOT(typeFonct in createChaine("entier") | createChaine("reel") | createChaine("caractere") | createChaine("chaine") | createChaine("booleen")) then
--					Ajout_queue(descr, "Type probablement non recunnu : " + L);
--				end if;
			end if;
		else
			Ajout_queue(descr, "Parenthese ouvrante manquante : " + L);
			ok := False;
		end if;
		return ok;
	end debugFunction;

	function debugVariable(L : in chaine; descr: in out T_Tab_Ligne) return boolean is
		ok : boolean := True;
		typeVar : chaine;
		i, j: integer;
	begin
		i:= strpos(L, '(');
		if i /= 0 then
			if NOT estUneVariable(donneNom(L)) then
				ok := ok AND False;
				Ajout_queue(descr, "Votre nom de variable n'est pas conforme : " + L);
			end if;

		
			j:= strpos(L, ')');
			if j = 0 OR j<i then
				ok := ok AND False;
				Ajout_queue(descr, "Erreur de pairage des parentheses : " + L);
			else
				typeVar := substring(L, i+1, j-1);
				typeVar := trimLeft(TypeVar); typeVar := trimRight(typeVar);
				if NOT(typeVar in createChaine("entier") | createChaine("reel") | createChaine("caractere") | createChaine("chaine") | createChaine("booleen")) then
					Ajout_queue(descr, "Type probablement non recunnu : " + L);
				end if;
			end if;
		else
			Ajout_queue(descr, "Parenthese ouvrante manquante : " + L);
			ok := False;
		end if;
		return ok;
	end debugVariable;

	function debugConstante(L : in chaine; descr: in out T_Tab_Ligne) return boolean is
	begin
		return True;
	end debugConstante;

	function debugStructure(L : in chaine; descr: in out T_Tab_Ligne) return boolean is
	begin
		return True;
	end debugStructure;

	function debugTable(L : in chaine; descr: in out T_Tab_Ligne) return boolean is
	begin
		return True;
	end debugTable;

	function debugmodule(L : in chaine; descr: in out T_Tab_Ligne) return boolean is
	ok : boolean := True;
	i, j: integer;
	begin
		i:= strpos(L, '(');
		if i /= 0 then
			if NOT estUneVariable(donneNom(L)) then
				ok := ok AND False;
				Ajout_queue(descr, "Votre nom de variable n'est pas conforme : " + L);
			end if;

		
			j:= strpos(L, ')');
			if j = 0 OR j<i then
				ok := ok AND False;
				Ajout_queue(descr, "Erreur de pairage des parentheses : " + L);
			end if;
		else
			Ajout_queue(descr, "Parenthese ouvrante manquante : " + L);
			ok := False;
		end if;
		return ok;
	end debugmodule;



end debuglexique;
