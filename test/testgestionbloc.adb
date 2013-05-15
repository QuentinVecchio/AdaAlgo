with simple_io, gestionbloc, definitions, mstring;
use simple_io, gestionbloc, definitions, mstring;

procedure testgestionbloc is

	maListe: T_Tab_Bloc;

	monBloc: Bloc(commentaire);
	monBloc2: Bloc(module);
	
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
	
	begin
	
		Put_line("Début de test");
		creerListe(maListe);
		ajoutElt(maListe, monBloc);
		ajoutElt(maListe, monBloc2);
		ajoutElt(maListe, monBloc2);
		ajoutElt(maListe, monBloc);
		
		ajoutCommentaire(maListe, "coucou"+ " comment vas");
		afficheTypeElt(maListe);
		put_line("enleve");
		enleveTete(maListe);
		enleveTete(maListe);

		enleveTete(maListe);
		enleveTete(maListe);
		afficheTypeElt(maListe);
		if(testEstVide)then
			put_line("testEstVide accomplit avec succes");
		end if;
		
end testgestionbloc;