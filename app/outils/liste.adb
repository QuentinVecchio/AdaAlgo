
package body liste is

	function Creer_liste return T_PTR_LISTE is
		begin
			return null;
		
	end Creer_liste;

	procedure Creer_liste(L: out T_PTR_LISTE; elt: T_elt)is
	
		begin
			L := new T_Liste'(elt, null);
	end Creer_liste;
	
	procedure Affiche_liste(L: T_PTR_LISTE)is
		begin
			if(NOT estVide(L))then
				affiche(L.all.courant);
				if(NOT estVide(L.all.suivant)) then
					Affiche_liste(L.all.suivant);
				end if;
			end if;
	end Affiche_liste;
	
	procedure Ajout_enTete(L: in out T_PTR_LISTE; elt: T_elt)is
		tmp: T_Liste := (elt, L);
		
		begin
			L := new T_Liste'(tmp);
	end Ajout_enTete;
	
	procedure Ajout_queue(L: in out T_PTR_LISTE; elt: T_elt)is
		begin
			if(NOT estVide(L))then
				if(NOT estVide(L.all.suivant)) then
					Ajout_queue(L.all.suivant, elt);
				else
					L.all.suivant := new T_Liste'((elt, null));
				end if;
			else
				Creer_liste(L, elt);
			end if;
	end Ajout_queue;
	
	procedure donne_tete(L: T_PTR_LISTE; elt: out T_elt)is
		begin
			if NOT estVide(L) then
				elt := L.all.courant;
			end if;
	end donne_tete;

	function donne_tete(L: T_PTR_LISTE) return T_elt is
		tmp: T_elt;
		
		begin
			if(NOT estVide(L)) then
				donne_tete(L, tmp);
			end if;
			return tmp;
	end donne_tete;
	
	
	function donne_queue(L: T_PTR_LISTE) return T_elt is
	begin
		if( NOT estVide(L)) then
				if(NOT estVide(donne_suivant(L)))then
						return donne_queue(donne_suivant(L));
				else
						return L.courant;
				end if;
		end if;
	end donne_queue;

	procedure enleve_enTete(L: in out T_PTR_LISTE) is
			
		tmp: T_PTR_LISTE;
		begin
			if(NOT estVide(L)) then
				tmp := L;
				L := L.suivant;			
				libere(tmp);
			end if;
	end enleve_enTete;
	
	procedure enleve_queue(L: in out T_PTR_LISTE) is

		tmp: T_PTR_LISTE;
		begin
			if(NOT estVide(L)) then
				if(estVide(L.all.suivant)) then
					tmp := L;
					L := null;
					libere(tmp);
				elsif(estVide(L.all.suivant.all.suivant)) then
					tmp := L;
					L.all.suivant := null;
					libere(tmp);
				else
					enleve_queue(L.all.suivant);
				end if;
			end if;
	end enleve_queue;
	
	procedure vide_liste(L: in out T_PTR_LISTE)is
		begin
			while (not estVide(L))loop
					enleve_enTete(L);
			end loop;

	end vide_liste;

	function appartient_liste(L: T_PTR_LISTE; elt: T_elt) return boolean is
		begin
			if(NOT estVide(L)) then
				if(L.all.courant = elt)then
					return true;
				elsif(NOT estVide(L.all.suivant))then
					return appartient_liste(L.all.suivant, elt);
				end if;
			end if;
			
			return false;
	end appartient_liste;
	
	function estVide(L: T_PTR_LISTE) return boolean is
		begin
		
			return (L = null);
		
	end estVide;

	procedure donne_suivant(L: in out T_PTR_LISTE) is
	begin
		if NOT estVide(L) then
			L := L.all.suivant;
		else
			L:= NULL;
		end if;
	end donne_suivant;

	function donne_suivant(L: T_PTR_LISTE) return T_PTR_LISTE is 
		tmp : T_PTR_LISTE := L;
	begin
		donne_suivant(tmp);
		return tmp;
	end donne_suivant;
end liste;
