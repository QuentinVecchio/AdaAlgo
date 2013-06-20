with mstring, gestionbloc, definitions, liste, typeenum;
use mstring, gestionbloc, definitions;


Package debug is

	type_ligne : T_type_ligne;
	package P_type_ligne is new typeEnum (T_type_ligne);
	package P_Pile is new liste(T_type_ligne, P_type_ligne.put_line);
	use P_Pile;

	type Pile is new P_Pile.T_PTR_LISTE;

	function debuggage(tab: in T_tab_ligne; descrErrors : in out T_Tab_Ligne)return boolean;

	function GetType(ligne: chaine)return T_type_ligne;





	function debug_aff(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	function debug_Mod(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	function debug_Pour(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	function debug_tq(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	function debug_repeter(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	function debug_cond(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	function debug_case(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	function analyseInclusionBloc(L : in T_Tab_ligne; descr: in out T_Tab_Ligne) return boolean;




	function estUneVariable(ch: chaine) return boolean;

	procedure afficheErrors(descr : T_Tab_ligne);

	procedure SplitChaine(c : in out Chaine; chaineSplit : in out T_Tab_Ligne);


end debug;
