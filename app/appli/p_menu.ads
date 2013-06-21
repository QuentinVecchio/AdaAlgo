--******************************************************************************--
--	Code source Application AlgoAda Projet Universitaire IUT de Metz	--
--	Developpeur : Quentin Vecchio Date modif : 20 juin 2013			--
--	Spécification p_menu.adb	gere le menu				--
--	Package									--
--******************************************************************************--

--Importation des packages
WITH Gtk.Menu_Bar;	USE Gtk.Menu_Bar;
WITH Gtk.Menu;		USE Gtk.Menu;
WITH Gtk.Menu_Item;	USE Gtk.Menu_Item;
WITH Gtk.Menu_Shell;	USE Gtk.Menu_Shell;
WITH Ada.Finalization ; USE Ada.Finalization ;

--Déclaration du package
PACKAGE P_Menu IS

--Initialisation d'une structure menu
	TYPE T_Menu IS NEW Controlled WITH RECORD
		--Barre de menu		
		barreMenu : Gtk_Menu_Bar;
		--Categorie Menu
		menuFichier : Gtk_Menu;
		menuEdition : Gtk_Menu;
		menuAffichage : Gtk_Menu;
		menuCompilation : Gtk_Menu;
		menuAPropos : Gtk_Menu;
		--Choix menu
		m_affich : Gtk_Menu_Item;
		m_Fichier : Gtk_Menu_Item;
		m_Quitter : Gtk_Menu_Item;
		m_Nouveau : Gtk_Menu_Item;
		m_Ouvrir : Gtk_Menu_Item;
		m_Enregistrer : Gtk_Menu_Item;
		m_EnregistrerSous : Gtk_Menu_Item;	
		m_Edition : Gtk_Menu_Item;
		m_Compilation : Gtk_Menu_Item;
		m_lecture : Gtk_Menu_Item;
		m_modeNormal : Gtk_Menu_Item;
		m_modeEcran: Gtk_Menu_Item;
		m_aPropos : Gtk_Menu_Item;
		m_inter : Gtk_Menu_Item;
	END RECORD;

--Constructeur de la structure
	PROCEDURE Initialize(M : IN OUT T_Menu);
END P_Menu;
