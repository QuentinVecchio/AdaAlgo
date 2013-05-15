with simple_io, gestionbloc, definitions, mstring;
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
		
		
end testgestionbloc;