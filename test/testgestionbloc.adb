with simple_io, gestionbloc, definitions, mstring, typeEnum;
use simple_io, gestionbloc, definitions, mstring;

procedure testgestionbloc is

	maListe: T_Tab_Bloc;

	monBloc: Bloc(commentaire);
	monBloc2: Bloc(module);
	
	--
	--	Test si la fonction estVide renvoit vrai quand vide et faux sinon
	--
	function testEstVide return boolean is
	
		aReussi: boolean := true;
	
		l1, l2 : T_Tab_Bloc;
		begin
			
			creerListe(l1);
			creerListe(l2);
			ajoutElt(l1, monBloc);
			
			aReussi := estVide(l2) AND NOT estVide(l1);
			
			return aReussi;
	end testEstVide;
	
	
	function testCreerListe return boolean is
		aReussi: boolean := true;
		l1: T_Tab_Bloc;
		begin
		
			begin
				creerListe(l1);
				ajoutElt(l1, monBloc);
				creerListe(l1);
			
			exception
				when liste_deja_cree => null;				
				when others => Put_line("Une erreur est survenue lors du test de creerliste");
										aReussi := false;

			end;
		
		return aReussi;
	end testCreerListe;
	
	function testAfficheTypeElt return boolean is
		aReussi: boolean := true;
		l1: T_Tab_Bloc;
		type confirm is (y,o,n);
		package AfficheVerif is new typeEnum(confirm);
		use AfficheVerif;
		
		rep: confirm;
		
		begin
			creerListe(l1);
			ajoutElt(l1, monBloc);
			ajoutElt(l1, monBloc2);
			put_line("Affichage des éléments de la liste");
			afficheTypeelt(l1);
			put_line("Affiche bien commentaire puis module ? (o/n)");
			getSecure(rep);
			aReussi := rep in y..o;
			return aReussi;
	end testAfficheTypeElt;
	
	function testDonneTete return boolean is
		aReussi : boolean := true;
		l1: T_Tab_Bloc;
		res : bloc(commentaire);
		begin
			creerListe(l1);
			
			begin
				donneTete(l1, res);
			exception
				when liste_non_cree => null;
				when others => Put_line("Erreur inattendue !");
								aReussi := false;
			end;
			
			ajoutElt(l1, monBloc);
			donneTete(l1, res);
			if(res.forme /= commentaire)then
				Put_line("Type attendu: commentaire, type reçu: "&T_elmt'image(res.forme));
				aReussi := false;
			end if;
			ajoutElt(l1, monBloc2);
			donneTete(l1, res);			
			if(res.forme /= commentaire)then
				Put_line("Type attendu: module, type reçu: "&T_elmt'image(res.forme));
				aReussi := false;
			end if;
		return aReussi;
		
	end testDonneTete;
	
	begin
	
		if(testEstVide)then
			put_line("testEstVide accomplit avec succes");
		else
			put_line("Il reste encore des erreurs dans estVide");
		end if;
		
		if(testCreerListe)then
			put_line("testCreerListe accomplit avec succes");
		else
			put_line("Il reste encore des erreurs dans creerListe");
		end if;
		
		if(testAfficheTypeElt) then
			put_line("testAfficheTypeElt accomplit avec succes");
		else
			put_line("Il reste encore des erreurs dans testAfficheTypeElt");
		end if;
		
		if(testDonneTete) then
			put_line("testDonneTete accomplit avec succes");
		else
			put_line("Il reste encore des erreurs dans testDonneTete");
		end if;
		
		
end testgestionbloc;