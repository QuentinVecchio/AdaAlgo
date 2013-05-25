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
	--	@param L, ligne contenant le commentaire
	--	@param res, liste de bloc
	--
	procedure Ajout_com(L: chaine; Res : in out T_Tab_Bloc);

	--
	--	Permet d'ajouter une ligne correspondant a une affectation
	--	@param L, ligne contenant l'affectation
	--	@param res, liste de bloc
	--
	procedure Ajout_aff(L: chaine; res: T_Tab_Bloc);

	--
	--	Permet d'ajouter une ligne correspondant à un appel de module
	--	@param L, ligne contenant le module
	--	@pram res, liste de bloc
	--
	procedure Ajout_Mod(L: chaine; res: T_Tab_Bloc);
	
	--
	--	met en forme la condition pour etre implementé en mémoire
	--	appel la procedure 'Analyse_Code' sur l'interrieur de la boucle
	--	ajoute la condition, et l'anayle du bloc dans la liste de bloc
	--	@param tab, le tableau de ligne
	--	@param Res, liste de bloc 
	--
	procedure Ajout_Pour(tab: in out T_tab_ligne; Res: in out T_Tab_Bloc);

	--
	--	met en forme la condition pour etre implementé en mémoire
	--	appel la procedure 'Analyse_Code' sur l'interrieur de la boucle
	--	ajoute la condition, et l'anayle du bloc dans la liste de bloc
	--	@param tab, le tableau de ligne
	--	@param Res, liste de bloc 
	--
	procedure Ajout_tq(tab: in out T_tab_ligne; Res: in out T_Tab_Bloc);
	
	--
	--	met en forme la condition pour etre implementé en mémoire
	--	appel la procedure 'Analyse_Code' sur l'interrieur de la boucle
	--	ajoute la condition, et l'anayle du bloc dans la liste de bloc
	--	@param tab, le tableau de ligne
	--	@param Res, liste de bloc 
	--
	procedure Ajout_Repeter(tab: in out T_tab_ligne; Res: in out T_Tab_Bloc);
	
	
	
	--
	--	Permet d'ajouter un bloc conditionnel
	--	C'est à dire de si -> fsi
	--	Modifie l'indice de la ligne courant, pointe sur  fsi
	--	Renvoit l'ensemble des blocs contenus dans le bloc courant
	--	@param tab, liste de ligne a partire du début de la condition
	--	@param res, liste de bloc
	--
	procedure Ajout_cond (tab: T_tab_ligne ;  Res: T_Tab_Bloc);
	
	
end analyse;
