with mstring, gestionbloc, definitions;
use mstring, gestionbloc, definitions;
--------------------------------------
-- SPÉCIFICATION DU PACKAGE ANALYSE --
--------------------------------------

Package analyse is
	type T_Tab_Ligne is array (integer range 1..100) of chaine;

	procedure analyse(tab: in out T_tab_ligne; l_cour : in out natural; res: out T_Tab_Bloc);
	-- analyse une ligne du code et envoie les information aux differentes procedures
	
	
	function GetType(ligne: chaine)return T_type_ligne;
	
	------------------------
	-- PROCEDURES D'AJOUT --
	------------------------	
	procedure Ajout_com(L: chaine; Res : in out T_Tab_Bloc);

	procedure Ajout_aff(L: chaine; res: T_Tab_Bloc);

	procedure Ajout_Mod(L: chaine; res: T_Tab_Bloc);
	
	procedure Ajout_pour_tq (tab: T_tab_ligne ; l_cour: in out natural; Res: T_Tab_Bloc);

	procedure Ajout_rep (tab: T_tab_ligne ; l_cour: in out natural; Res: T_Tab_Bloc);
	
	procedure Ajout_cond (tab: T_tab_ligne ; l_cour: in out natural; Res: T_Tab_Bloc);
end analyse;
