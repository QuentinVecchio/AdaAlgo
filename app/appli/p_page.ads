WITH Gtk.Button; 	USE Gtk.Button;
WITH Gtk.Text_View;	USE Gtk.Text_View;
WITH Gtk.label;		USE Gtk.Label;
WITH Gdk.Color;		USE Gdk.Color;
WITH Gtk.Enums ;        USE Gtk.Enums ;
WITH Gtk.Table;		USE Gtk.Table;
WITH Gtk.Image;		USE Gtk.Image;
WITH Gtk.Box ;          USE Gtk.Box ;
WITH Gtk.Notebook;	USE Gtk.Notebook;
WITH Gtk.Scrolled_Window;	USE Gtk.Scrolled_Window;
WITH Gtk.Adjustment;	USE Gtk.Adjustment;
WITH Glib;		USE Glib;
WITH Gtk.Separator;     USE Gtk.Separator;
WITH Ada.Finalization; 	USE Ada.Finalization;

PACKAGE P_Page IS
type tab_code is array(1..5) of Gtk_Text_View;
type tab_ada is array(1..5) of Gtk_Text_View;
type tab_var is array(1..5) of Gtk_Text_View;
type tab_debug is array(1..5) of Gtk_Text_View;
type tab_label is array(1..5) of Gtk_Label;
type tab_btn is array(1..5) of Gtk_Button;
type tab_Table is array(1..5) of Gtk_Table;
type tab_Boite is array(1..5) of Gtk_HBox;
type tab_Sepatateur is array(1..5) of Gtk_Vseparator;
type tab_dispo is array(1..5) of Boolean;	
	TYPE T_Page IS NEW Controlled WITH RECORD
		--Zones de saisie			
			zoneCode : tab_code;			
			zoneVariable : tab_var;
		--label			
			labelTitre : tab_label;
			labelCode, labelVariable, labelAda,labelDebug: tab_label;
		--button
			btnFermer : tab_btn;
			btnAdaEnregistrer : tab_btn;
		--Zone ada
			zoneAda : tab_ada;
		--Debug
			zoneDebug : tab_debug;
		--Barre de défilement
			barre1,barre2,barre3,barre4 : Gtk_Scrolled_Window;
		--Ajustement
			ajust : Gtk_Adjustment;		
		--table & Boite	
			Table : tab_Table;
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
		--Onglet dispo
			ongletDispo : tab_dispo;
		--i
			i : Integer;
	END RECORD;

	PROCEDURE Initialize(P : IN OUT T_Page);
END P_Page;
