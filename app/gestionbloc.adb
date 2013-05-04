package body gestionbloc is


	procedure creerListe(L: out T_Tab_Bloc) is
		begin
			if(NOT estFinListe(L) and NOT estVide(L))then
				raise liste_deja_cree;
			end if;
			L.courant := null;
			L.suivant := null;
		
	end creerListe;

	function estVide(L: T_Tab_Bloc)return boolean is
		begin
			return (L.courant = null);
	end estVide;
	
	function estFinListe(L: T_Tab_Bloc) return boolean is
		begin
			return (L.suivant = null);
	end estFinListe;
	
	procedure ajoutElt(L: in out T_Tab_Bloc; elt: Bloc)is
		begin
		
		if(NOT estVide(L))then
			ajoutElt(L.suivant.all, elt);
		else
			L.courant := new Bloc'(elt);
			declare
				newL: T_Tab_Bloc;
				begin
				creerListe(newL);
				L.suivant:= new T_Tab_Bloc'(newL);
			end;
		end if;
	end ajoutElt;

	procedure afficheTypeElt(L: in T_Tab_Bloc)is
		begin
			if(NOT estVide(L)) then
				put_line(L.courant.all.forme);
				if(NOT estFinListe(L))then
					afficheTypeElt(L.suivant.all);
				end if;
			end if;
		
	end afficheTypeElt;
	
	
	procedure donneTete(L: T_Tab_Bloc; elt: in out Bloc)is
		begin
			if(NOT estVide(L))then
				elt := L.courant.all;
			end if;
	end donneTete;
	
	procedure enleveTete(L: in out T_Tab_Bloc)is
		begin
			if(NOT estFinListe(L) or estVide(L))then
				L.suivant := null;
				L.courant := null;
			else
				L.courant := new Bloc'(L.suivant.all.courant.all);
				L.suivant.all := L.suivant.all.suivant.all;
			end if;
	end enleveTete;
	
	procedure ajoutCommentaire(L: in out T_Tab_Bloc; com: chaine)is
		b:Bloc(commentaire);
		
		begin
			b.MonCom := com;
			ajoutElt(L, b);
		
			
	end ajoutCommentaire;
	
	
end gestionbloc;