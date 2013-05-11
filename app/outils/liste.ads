generic

-- Le type des éléments de la liste
type T_elt is private;

-- La procédure d'affichage de l'élément
with procedure affiche(elt: T_elt);

package liste is

	-- Pointeur de liste
	type T_PTR_LISTE is private;
	
	--
	--	Crée une liste avec un élément dedans
	--
	procedure Creer_liste(L: out T_PTR_LISTE; elt: T_elt);
	
	--
	--	Affiche tout les éléments de la liste (du dernier au premier ajouté)
	--
	procedure Affiche_liste(L: T_PTR_LISTE);
	
	--
	--	Ajoute un élément en tête de liste
	--
	procedure Ajout_enTete(L: in out T_PTR_LISTE; elt: T_elt);
	
	
	--
	--	Ajoute un élément en queue de liste
	--
	procedure Ajout_queue(L: in out T_PTR_LISTE; elt: T_elt);
	
	
	--
	--	Donne le premier élément de la liste (sans dépiler)
	--
	procedure donne_tete(L:T_PTR_LISTE; elt: out T_elt);
	
	--
	--	Identique à la procédure, sauf sous forme de fonction
	--
	function donne_tete(L: T_PTR_LISTE) return T_elt;
	
	--
	--	Enlève le premier élément de la liste (le dernier ajouté)
	--
	procedure enleve_enTete(L: in out T_PTR_LISTE);
	
	--
	--	Enlève le dernier élément de la liste (le premier ajouté)
	--
	procedure enleve_queue(L: in out T_PTR_LISTE);
	
	--
	--	Fonction d'appartenance d'un élément:
	--	Renvoit vrai si appartient
	--			faux sinon
	--
	function appartient_liste(L: T_PTR_LISTE; elt: T_elt) return boolean;
	
	function estVide(L: T_PTR_LISTE) return boolean;
	
	private
-- 	
		type T_Liste;
	
		type T_PTR_LISTE is ACCESS T_Liste;
	
		type T_Liste is record
			courant : T_elt;
			suivant : T_PTR_LISTE;
		end record;
		
end liste;