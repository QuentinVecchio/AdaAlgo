with Ada.Unchecked_Deallocation;
generic

-- Le type des éléments de la liste
type T_elt is private;

-- La procédure d'affichage de l'élément
with procedure affiche(elt: T_elt);

package liste is

	-- Pointeur de liste
	type T_PTR_LISTE is private;
	
	--
	-- Retourne une liste vide
	--	@return T_PTR_LISTE, un pointeur sur la liste crée
	--
	function Creer_liste return T_PTR_LISTE;
	
	--
	--	Crée une liste avec un élément dedans
	--	@param L, le pointeur vers la nouvelle liste crée
	--	@param elt, l'élément a ajouter dans la liste
	--
	procedure Creer_liste(L: out T_PTR_LISTE; elt: T_elt);
	
	--
	--	Affiche tout les éléments de la liste (du dernier au premier ajouté)
	--	@param L, la liste a afficher
	--
	procedure Affiche_liste(L: T_PTR_LISTE);
	
	--
	--	Ajoute un élément en tête de liste
	--	@param L, la liste où l'on veut ajouter un élément
	--	@param elt, l'élément a ajouter en tête de liste
	--
	procedure Ajout_enTete(L: in out T_PTR_LISTE; elt: T_elt);
	
	
	--
	--	Ajoute un élément en queue de liste
	--	@param L, la liste a modifier
	--	@param elt, l'élément a ajouter en fin de liste
	--
	procedure Ajout_queue(L: in out T_PTR_LISTE; elt: T_elt);
	
	
	--
	--	Donne le premier élément de la liste (sans dépiler)
	--	@param L, la liste où se trouve l'élément
	--	@param elt, la variable qui contiendra l'élément en tête de liste
	--
	procedure donne_tete(L:T_PTR_LISTE; elt: out T_elt);
	
	--
	--	Identique à la procédure, sauf sous forme de fonction
	--	@param L, la liste où se trouve l'élément
	--	@return l'élément en tête de liste
	--
	function donne_tete(L: T_PTR_LISTE) return T_elt;
	
	--
	--	Enlève le premier élément de la liste (le dernier ajouté)
	--	@param L, la liste où se trouve l'élément a enlever
	--
	procedure enleve_enTete(L: in out T_PTR_LISTE);
	
	--
	--	Enlève le dernier élément de la liste (le premier ajouté)
	--	@param L, la liste où se trouve l'élément a enlever
	--
	procedure enleve_queue(L: in out T_PTR_LISTE);
	

	--
	--	Procédure qui détruit entièrement une liste
	--	@param L, la liste a détruire
	--
	procedure vide_liste(L: in out T_PTR_LISTE);


	--
	--	Fonction d'appartenance d'un élément:
	--	@param L, la liste où se trouve possible l'élément
	--	@param elt, l'élément a tester
	--	@return vrai, si l'élément est dans la liste
	--	@return faux, si l'élément n'est pas dans la liste
	--
	function appartient_liste(L: T_PTR_LISTE; elt: T_elt) return boolean;
	
	--
	--	Fonction qui teste si une liste est vide
	--	@param L, la liste a tester
	--	@return vrai, si la liste est vide
	--	@return faux, si la liste contient un ou plusieurs élément(s)
	--
	function estVide(L: T_PTR_LISTE) return boolean;

	--
	--	Procedure qui envoie la structure suivante
	--	/!\ il faut stocker le pointeur du début de la liste, autrement il est perdu!!
	--	@param L, La liste a manipuler
	--
	procedure donne_suivant(L: in out T_PTR_LISTE);

	function donne_suivant(L: T_PTR_LISTE) return T_PTR_LISTE;
	
	private
		type T_Liste;
	
		type T_PTR_LISTE is ACCESS T_Liste;
	
		type T_Liste is record
			courant : T_elt;
			suivant : T_PTR_LISTE;
		end record;

		procedure libere is new Ada.Unchecked_Deallocation(T_Liste, T_PTR_LISTE);
end liste;
