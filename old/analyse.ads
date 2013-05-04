with mstring; use mstring;
with tableau; use tableau;
--------------------------------------
-- SPÉCIFICATION DU PACKAGE ANALYSE --
--------------------------------------

Package analyse is
	type T_Tab_Ligne is array (integer range 1..100) of chaine;

	procedure analyse(tab: in out T_tab_ligne; l_cour : natural; res: out T_Tab_Bloc);
	-- analyse une ligne du code et envoie les information aux differentes procedures
	
	
	
	
	------------------------
	-- PROCEDURES D'AJOUT --
	------------------------	
	procedure Ajout_com(L: chaine; Res : in out T_Tab_Bloc);





end analyse;