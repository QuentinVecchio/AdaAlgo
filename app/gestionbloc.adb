package body gestionbloc is


	procedure creerListe(L: out T_Tab_Bloc) is
		begin
		
			L.courant := null;
			L.suivant := null;
		
	end creerListe;

	function estVide(L: T_Tab_Bloc)return boolean is
		begin
		
			return (L.suivant = null);
		
	end estVide;
	
	
	procedure ajoutElt(L: in out T_Tab_Bloc; elt: Bloc)is
		begin
		
		null;
		
	end ajoutElt;

end gestionbloc;