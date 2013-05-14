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
			if(L /= null)then
				affiche(L.all.courant);
				if(L.all.suivant /= null) then
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
			if(L /= null)then
				if(L.all.suivant /= null) then
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
			elt := L.all.courant;
	end donne_tete;
	
	function donne_tete(L: T_PTR_LISTE) return T_elt is
		tmp: T_elt;
		
		begin
			if(L /= null) then
				donne_tete(L, tmp);
			end if;
			return tmp;
	end donne_tete;
	
	procedure enleve_enTete(L: in out T_PTR_LISTE) is
		begin
			if(L /= null) then
				L := L.suivant;			
			end if;
	end enleve_enTete;
	
	procedure enleve_queue(L: in out T_PTR_LISTE) is
		begin
			if(L /= null) then
				if(L.all.suivant= null) then
					L := null;
				elsif(L.all.suivant.all.suivant = null) then
					L.all.suivant := null;
				else
					enleve_queue(L.all.suivant);
				end if;
			end if;
	end enleve_queue;
	
	function appartient_liste(L: T_PTR_LISTE; elt: T_elt) return boolean is
		begin
			if(L /= null) then
				if(L.all.courant = elt)then
					return true;
				elsif(L.all.suivant /= null)then
					return appartient_liste(L.all.suivant, elt);
				end if;
			end if;
			
			return false;
	end appartient_liste;
	
	function estVide(L: T_PTR_LISTE) return boolean is
		begin
		
			return (L = null);
		
	end estVide;
end liste;