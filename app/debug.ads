-----------------------------------------------------------------------------------------
--
--	Paquetage debug:
--
--		Paquetage regroupant les fonctions et procédures nécessaire pour debugguer un algo
--		La procédure principale debuggage permet de debugguer tout un algorithme
--		Toutes les autres functions permettent de debugger un élément précis
--		
--
--		@author Nicolas Weissenbach
--		@version 1.0.0.0
--		@date 22-06-2013
--
-----------------------------------------------------------------------------------------

with mstring, gestionbloc, definitions, liste, typeenum;
use mstring, gestionbloc, definitions;


Package debug is

	type_ligne : T_type_ligne;
	package P_type_ligne is new typeEnum (T_type_ligne);
	package P_Pile is new liste(T_type_ligne, P_type_ligne.put_line);
	use P_Pile;
	type Pile is new P_Pile.T_PTR_LISTE;



	--
	--	procedure principale qui commence le debbuggage d'un algo en appelant des fonctions de debbuggage
	--	@param tab, l'ensemble des lignes de l'algo
	--	@param descrErrors, ensembles des descriptions d'erreurs de l'algo
	--	@return boolean, vrai si la fonction est sans bug, faux sinon
	--
	function debuggage(tab: in T_tab_ligne; descrErrors : in out T_Tab_Ligne)return boolean;

	--
	--	Fonction qui permet de déterminer le type d'une ligne
	--	Renvoit le type de la ligne
	--	@param ligne, la chaine dont on doit déterminer le type
	--	@return T_type_ligne, le type de la ligne (voir definitions.ads)
	--
	function GetType(ligne: chaine)return T_type_ligne;



	--
	--	Function qui debug une affection
	--	@param L, l'affection a tester
	--	@param descr, la descrition des erreurs rencontrés
	--	@return boolean, vrai si l'affectation est sans bug, faux sinon
	--
	function debug_aff(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	--
	--	Fonction qui debug un module
	--	@param L, le module a tester
	--	@param descr, la descrition des erreurs rencontrés
	--	@return boolean, vrai si le modul est sans bug, faux sinon
	--
	function debug_Mod(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	--
	--
	--	Function qui debug un pour
	--	@param L, le pour a tester
	--	@param descr, la descrition des erreurs rencontrés
	--	@return boolean, vrai si le pour est sans bug, faux sinon
	--
	function debug_Pour(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	--
	--
	--	Function qui debug un tq
	--	@param L, le tq a tester
	--	@param descr, la descrition des erreurs rencontrés
	--	@return boolean, vrai si le tq est sans bug, faux sinon
	--
	function debug_tq(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	--
	--
	--	Function qui debug un repeter
	--	@param L, le repeter a tester
	--	@param descr, la descrition des erreurs rencontrés
	--	@return boolean, vrai si le repeter est sans bug, faux sinon
	--
	function debug_repeter(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	--
	--
	--	Function qui debug une condition
	--	@param L, la condition a tester
	--	@param descr, la descrition des erreurs rencontrés
	--	@return boolean, vrai si la condition est sans bug, faux sinon
	--
	function debug_cond(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	--
	--
	--	Function qui debug un cas parmi
	--	@param L, le cas parmi a tester
	--	@param descr, la descrition des erreurs rencontrés
	--	@return boolean, vrai si le cas parmi est sans bug, faux sinon
	--
	function debug_case(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	--
	--
	--	Function qui verifie que chaque bloc ouvert a bien une fin (ex: un 'si' a un 'fsi' plus tard)
	--	@param L, l'algo a verifier
	--	@param descr, la descrition des erreurs rencontrés
	--	@return boolean, vrai si le repeter est sans bug, faux sinon
	--
	function analyseInclusionBloc(L : in T_Tab_ligne; descr: in out T_Tab_Ligne) return boolean;



	--
	--	Fonction qui verifie qu'un variable est bien une chaine de caractere composé de Majuscule, minuscules, et '_'
	--	@param ch, variable a tester
	--	@return boolean, vrai si c'est une variables, faux sinon
	--
	function estUneVariable(ch: chaine) return boolean;

	--
	--	Fonction qui affiche toutes les erreurs dans le terminal!
	--	@param descr, liste des erreurs
	--
	procedure afficheErrors(descr : T_Tab_ligne);

	--
	--	fonction qui coupe une chaine en une liste de chaine, la séparation est fixé sur des ' '
	--	@param c, chaine a spliter
	--	@param chaineSplit, liste des mots composant la chaine
	--
	procedure SplitChaine(c : in out Chaine; chaineSplit : in out T_Tab_Ligne);


end debug;
