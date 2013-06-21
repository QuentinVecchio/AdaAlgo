WITH Gtk.ToolBar;	USE Gtk.ToolBar;
WITH Gtk.Image;		USE Gtk.Image;
WITH Gtk.Button ;       USE Gtk.Button ;
WITH Gdk.Color;		USE Gdk.Color;
WITH Gtk.Enums ;        USE Gtk.Enums ;
WITH Gtk.File_Chooser_Dialog;	USE Gtk.File_Chooser_Dialog;
WITH Gtk.File_Chooser;	USE Gtk.File_Chooser;
WITH Gtk.Progress_Bar;	USE Gtk.Progress_Bar;
WITH  Gtk.Tooltips;	USE  Gtk.Tooltips;
WITH Ada.Finalization ; USE Ada.Finalization ;

PACKAGE P_barreOutil IS
--Déclaration du type
	TYPE T_BarreOutil IS NEW Controlled WITH RECORD
		--Barre Outils		
			barreOutil : Gtk_ToolBar;
		--Images Boutons		
			imageNouveau : Gtk_Image;
			imageEnregistrer : Gtk_Image; 
			imageOuvrir : Gtk_Image;
			imageCompiler : Gtk_Image;
		--Boutons		
			btnNouveau : Gtk_Button;
			btnEnregistrer : Gtk_Button; 
			btnOuvrir : Gtk_Button;
			btnCompiler : Gtk_Button;
		--Chargement
			chargement : Gtk_Progress_Bar;
		--Couleur
			couleurBarreOutil : Gdk_Color;
		--aide
			aide : Gtk_Tooltips;
	END RECORD;
--Fonctions	
	PROCEDURE Initialize(B : IN OUT T_BarreOutil);	
END p_barreOutil;
