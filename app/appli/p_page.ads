--******************************************************************************--
--	Code source Application AlgoAda Projet Universitaire IUT de Metz	--
--	Developpeur : Quentin Vecchio Date modif : 20 juin 2013			--
--	fichier spécification p_page.adb	Gére la partie page		--
--	Package									--
--******************************************************************************--

--Importation des packages

--Packages ADA
WITH SIMPLE_IO;		USE SIMPLE_IO; 
WITH Gtk.Image;		USE Gtk.Image;
WITH Gtk.Notebook;	USE Gtk.Notebook;
WITH Gtk.Scrolled_Window;	USE Gtk.Scrolled_Window;
WITH Gtk.Adjustment;	USE Gtk.Adjustment;
WITH Gtk.Separator;     USE Gtk.Separator;
WITH Gtk.Widget ;     	USE Gtk.Widget ; 
WITH Gtk.Window ;       USE Gtk.Window ;
WITH Gtk.Enums ;        USE Gtk.Enums ;
WITH Gtk.Table;		USE Gtk.Table;
WITH Gtk.Button; 	USE Gtk.Button;
WITH Gtk.Box;		USE Gtk.Box;
WITH Gtk.Bin ;          USE Gtk.Bin ;
WITH Gtk.Text_View;	USE Gtk.Text_View;
WITH Gtk.Text_Buffer;	USE Gtk.Text_Buffer;
WITH Gtk.Text_Iter; 	USE Gtk.Text_Iter;
WITH Gtk.Widget ;     	USE Gtk.Widget ;
WITH Gdk.Color;		USE Gdk.Color;
WITH Gdk.Visual;	USE Gdk.Visual;
WITH Gdk.Screen;	USE Gdk.Screen;
WITH Gtk.File_Chooser_Dialog;	USE Gtk.File_Chooser_Dialog;
WITH Gtk.File_Chooser;	USE Gtk.File_Chooser;
WITH Gtk.Label;		USE Gtk.Label; 
WITH Gtk.Dialog;	USE Gtk.Dialog;
WITH Gtk.Notebook;	USE Gtk.Notebook;
WITH Glib;		USE Glib;
WITH Gtk.Handlers;	USE Gtk.Handlers;
WITh Gtk.File_Filter;	USE Gtk.File_Filter;
WITH Ada.Finalization; 	USE Ada.Finalization;
WITH Gtk.Handlers;	USE Gtk.Handlers;
WITH Gtk.Widget ;     	USE Gtk.Widget ; 


--Déclaration du package
PACKAGE P_Page IS

--Création de tableau tout à 5 éléements car l'application ne peut géré que à 5 onglets (peut etre redéfini)
	type tab_code is array(1..5) of Gtk_Text_View;
	type tab_ada is array(1..5) of Gtk_Text_View;
	type tab_var is array(1..5) of Gtk_Text_View;
	type tab_debug is array(1..5) of Gtk_Text_View;
	type tab_fct is array(1..5) of Gtk_Text_View;
	type tab_label is array(1..5) of Gtk_Label;
	type tab_btn is array(1..5) of Gtk_Button;
	type tab_Table is array(1..5) of Gtk_Table;
	type tab_Boite is array(1..5) of Gtk_HBox;
	type tab_Sepatateur is array(1..5) of Gtk_Vseparator;

--Création d'un package pour la coloration syntaxique	
	PACKAGE P_CallbackTVKey IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,Gtk_Text_View) ;
	USE P_CallbackTVKey ;

--Création de la strcture page
	TYPE T_Page IS NEW Controlled WITH RECORD
		--Zones de saisie			
			zoneCode : tab_code;			
			zoneVariable : tab_var;
			zoneAda : tab_ada;
			zoneDebug : tab_debug;
			zoneFct : tab_fct;
		--label			
			labelTitre : tab_label;
			labelAda,labelDebug: tab_label;
		--bouton 
			btnFermer : tab_btn;
			btnAdaEnregistrer : tab_btn;	
			btnIn : tab_btn;
			btnOut : tab_btn;
		--Barre de défilement
			barre1,barre2,barre3,barre4, barre5 : Gtk_Scrolled_Window;
		--Ajustement
			ajust1,ajust2,ajust3,ajust4,ajust5 : Gtk_Adjustment;		
		--table & Boite	
			Table : tab_Table;
			TableBouton : tab_Table;
			Boite : tab_Boite;
		--couleur
			couleur : Gdk_Color;
			couleur2 : Gdk_Color;
		--image
			imageFermer : Gtk_Image;
		--NoteBook
			onglet : Gtk_Notebook;
		--separateur
                        separateur : tab_Sepatateur;
	END RECORD;

--Constructeur de la structure
	PROCEDURE Initialize(P : IN OUT T_Page);

--Fonction permettant la coloration syntaxique
	PROCEDURE ColorationSyntaxique(Emetteur :  access Gtk_Widget_Record'class; Texte : Gtk_Text_View);
END P_Page;
