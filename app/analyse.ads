with mstring, gestionbloc, definitions;
use mstring, gestionbloc, definitions;
--------------------------------------
-- SPÉCIFICATION DU PACKAGE ANALYSE --
--------------------------------------

Package analyse is

	procedure analyse(tab: in out T_tab_ligne; l_cour : in out natural; res: out T_Tab_Bloc);
	-- analyse une ligne du code et envoie les information aux differentes procedures
	
	--
	--	Fonction qui permet de déterminer le type d'une ligne
	--	Renvoit le type de la ligne
	--
	function GetType(ligne: chaine)return T_type_ligne;
	
	------------------------
	-- PROCEDURES D'AJOUT --
	------------------------	
	
	--
	--	Permet d'ajouter un commentaire
	--
	procedure Ajout_com(L: chaine; Res : in out T_Tab_Bloc);

	--
	--	Permet d'ajouter une ligne correspondant a une affectation
	--
	procedure Ajout_aff(L: chaine; res: T_Tab_Bloc);

	--
	--	Permet d'ajouter une ligne correspondant à un appel de module
	--
	procedure Ajout_Mod(L: chaine; res: T_Tab_Bloc);
	
	--
	--	Permet d'ajouter un bloc pour ou tq 
	--	C'est à dire de pour-> fpour et tq -> ftq
	--	Modifie l'indice de la ligne courant, pointe sur ftq ou fpour en fin de traitement
	--	Renvoit l'ensemble des blocs contenus dans le bloc courant
	--
	procedure Ajout_pour_tq (tab: T_tab_ligne ; l_cour: in out natural; Res: T_Tab_Bloc);

	
	--
	--	Permet d'ajouter un bloc repeter
	--	C'est à dire de repeter-> jusqu'a
	--	Modifie l'indice de la ligne courant, pointe sur  jusqu'a
	--	Renvoit l'ensemble des blocs contenus dans le bloc courant
	--
	procedure Ajout_rep (tab: T_tab_ligne ; l_cour: in out natural; Res: T_Tab_Bloc);
	
	--
	--	Permet d'ajouter un bloc conditionnel
	--	C'est à dire de si -> fsi
	--	Modifie l'indice de la ligne courant, pointe sur  fsi
	--	Renvoit l'ensemble des blocs contenus dans le bloc courant
	--
	procedure Ajout_cond (tab: T_tab_ligne ; l_cour: in out natural; Res: T_Tab_Bloc);
	
	
end analyse;
