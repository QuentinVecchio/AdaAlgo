generic

type T_elt is private;
with procedure affiche(elt: T_elt);

package liste is

	type T_PTR_LISTE is private;
	
	procedure Creer_liste(L: out T_PTR_LISTE; elt: T_elt);
	
	procedure Affiche_liste(L: T_PTR_LISTE);
	
	procedure Ajout_enTete(L: in out T_PTR_LISTE; elt: T_elt);
	
	procedure Ajout_queue(L: in out T_PTR_LISTE; elt: T_elt);
	
	procedure donne_tete(L:T_PTR_LISTE; elt: out T_elt);
	
	function donne_tete(L: T_PTR_LISTE) return T_elt;
	
	procedure enleve_enTete(L: in out T_PTR_LISTE);
	
	procedure enleve_queue(L: in out T_PTR_LISTE);
	
	function appartient_liste(L: T_PTR_LISTE; elt: T_elt) return boolean;
	
	private
	
		type T_Liste;
	
		type T_PTR_LISTE is ACCESS T_Liste;
	
		type T_Liste is record
			courant : T_elt;
			suivant : T_PTR_LISTE;
		end record;
		
end liste;