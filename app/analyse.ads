with mstring, gestionbloc, definitions;
use mstring, gestionbloc, definitions;
--------------------------------------
-- SPÉCIFICATION DU PACKAGE ANALYSE --
--------------------------------------

Package analyse is

	procedure Analyse_Code(tab: in out T_tab_ligne; res: out T_Tab_Bloc);
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
	--	Permet d'ajouter un bloc 'pour', 'tq' et 'repeter' 
	--	C'est à dire de 'pour'-> 'fpour', 'tq' -> 'ftq' et 'repeter'->'jq'
	--	la procedure dispatche ensuite vers les fonction d'ajout qui corresponde au type de la boucle
	--

	
	procedure Ajout_Pour(tab: in out T_tab_ligne; Res: in out T_Tab_Bloc);

	procedure Ajout_tq(tab: in out T_tab_ligne; Res: in out T_Tab_Bloc);
	
	procedure Ajout_Repeter(tab: in out T_tab_ligne; Res: in out T_Tab_Bloc);
	
	
	
	--
	--	Permet d'ajouter un bloc conditionnel
	--	C'est à dire de si -> fsi
	--	Modifie l'indice de la ligne courant, pointe sur  fsi
	--	Renvoit l'ensemble des blocs contenus dans le bloc courant
	--
	procedure Ajout_cond (tab: T_tab_ligne ;  Res: T_Tab_Bloc);
	
	
end analyse;
