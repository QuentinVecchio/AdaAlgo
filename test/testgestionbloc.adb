with simple_io, gestionbloc;
use simple_io, gestionbloc;

procedure testgestionbloc is

	maListe: T_Tab_Bloc;

	function testEstVide return boolean is
	
		aReussi: boolean := true;
	
		l1, l2 : T_Tab_Bloc;
		begin
			
			creerListe(l1);
			aReussi := estVide(l1);
			
			return aReussi;
			
			
	end testEstVide;
	
	
	begin
	
		Put_line("Début de test");
		creerListe(maListe);
		
		if(testEstVide)then
			put_line("testEstVide accomplit avec succes");
		end if;
		
end testgestionbloc;