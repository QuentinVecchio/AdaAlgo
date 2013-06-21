--******************************************************************************--
--	Code source Application AlgoAda Projet Universitaire IUT de Metz	--
--	Developpeur : Quentin Vecchio Date modif : 20 juin 2013			--
--	Code source p_menu.adb		gere le menu				--
--	Package									--
--******************************************************************************--

--Importations des packages
WITH Gtk.Menu_Bar;	USE Gtk.Menu_Bar;
WITH Gtk.Menu;		USE Gtk.Menu;
WITH Gtk.Menu_Item;	USE Gtk.Menu_Item;
WITH Gtk.Menu_Shell;	USE Gtk.Menu_Shell;
WITH Gtk.Enums ;        USE Gtk.Enums ;

--Déclaration du corp du package
PACKAGE BODY P_Menu IS
	
--Constructeur de la structure menu
	PROCEDURE Initialize(M : IN OUT T_Menu) IS
	BEGIN
	--Menu_Bar
		Gtk_New(M.barreMenu);
	--Menu
		Gtk_New(M.menuFichier);
		Gtk_New(M.menuEdition);
		Gtk_New(M.menuAffichage);
		Gtk_New(M.menuCompilation);
		Gtk_New(M.menuAPropos);	
	--Menu_Item
		Gtk_New(M.m_Fichier,"Fichier");
		Gtk_New(M.m_affich,"Affichage");
		Gtk_New_With_Mnemonic(M.m_modeNormal,"_Mode Normal");
		Gtk_New_With_Mnemonic(M.m_modeEcran,"Mode Plein _Ecran");
		Gtk_New_With_Mnemonic(M.m_Nouveau,"_Nouveau fichier");
		Gtk_New_With_Mnemonic(M.m_Ouvrir,"_Ouvrir fichier");
		Gtk_New_With_Mnemonic(M.m_Enregistrer,"Enregi_strer");
		Gtk_New_With_Mnemonic(M.m_EnregistrerSous,"_Enregistrer Sous");
		Gtk_New_With_Mnemonic(M.m_Quitter,"_Quitter");
		Gtk_New(M.m_Edition,"Edition");
		Gtk_New(M.m_Compilation,"Compilation");
		Gtk_New_With_Mnemonic(M.m_lecture,"_Lancer une compilation");
		Gtk_New(M.m_inter,"?");
		Gtk_New_With_Mnemonic(M.m_aPropos,"_A propos de");				
	--Création du menu fichier
		Append(M.menuFichier,M.m_Nouveau);
		Append(M.menuFichier,M.m_Ouvrir);
		Append(M.menuFichier,M.m_Enregistrer);
		Append(M.menuFichier,M.m_EnregistrerSous);
		Append(M.menuFichier,M.m_Quitter);
	--Création du menu Affichage
		Append(M.menuAffichage,M.m_modeNormal);
		Append(M.menuAffichage,M.m_modeEcran);	
	--Création du menu compilation
		Append(M.menuCompilation,M.m_lecture);
	--Création du menu ?
		Append(M.menuAPropos,M.m_aPropos);
	--Ajout dans la barre de menu
		Set_Submenu(M.m_Fichier,M.menuFichier);
		Set_Submenu(M.m_Edition,M.menuEdition);
		Set_Submenu(M.m_Compilation,M.menuCompilation);
		Set_Submenu(M.m_inter,M.menuAPropos);
		Set_Submenu(M.m_affich,M.menuAffichage);
		Append(M.barreMenu,M.m_Fichier);
		Append(M.barreMenu,M.m_Edition);
		Append(M.barreMenu,M.m_affich);		
		Append(M.barreMenu,M.m_Compilation);
		Append(M.barreMenu,M.m_inter);
	END Initialize;	
END P_Menu;
