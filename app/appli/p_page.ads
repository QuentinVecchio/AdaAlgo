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
WITH Ada.Finalization; 	USE Ada.Finalization;

PACKAGE P_Page IS
type tab_code is array(1..5) of Gtk_Text_View;
type tab_var is array(1..5) of Gtk_Text_View;
type tab_label is array(1..5) of Gtk_Label;
type tab_btn is array(1..5) of Gtk_Button;
type tab_Table is array(1..5) of Gtk_Table;

	TYPE T_Page IS NEW Controlled WITH RECORD
		--Zones de saisie
			
			zoneCode : tab_code;
			
			zoneVariable : tab_var;
		--label			
			labelTitre : tab_label;
		--button
			btnFermer : tab_btn;
		--Barre de défilement
			barre : Gtk_Scrolled_Window;
		--Ajustement
			ajust : Gtk_Adjustment;		
		--table & Boite	
			Table : tab_Table;
		--image
			imageFermer : Gtk_Image;
		--NoteBook
			onglet : Gtk_Notebook;
	END RECORD;

	PROCEDURE Initialize(P : IN OUT T_Page);
END P_Page;
