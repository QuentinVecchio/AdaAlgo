WITH Gtk.ToolBar;	USE Gtk.ToolBar;
WITH Gtk.Image;		USE Gtk.Image;
WITH Gtk.Button ;       USE Gtk.Button ;
WITH Gdk.Color;		USE Gdk.Color;
WITH Gtk.File_Chooser_Dialog;	USE Gtk.File_Chooser_Dialog;
WITH Gtk.File_Chooser;	USE Gtk.File_Chooser;
WITH Gtk.Progress_Bar;	USE Gtk.Progress_Bar;
WITH Gtk.Handlers;

PACKAGE BODY P_barreOutil IS
	
	PROCEDURE Initialize(B : IN OUT T_BarreOutil) IS
	BEGIN
	--Création de la barre	
		Gtk_New(B.barreOutil);
		Set_Rgb(B.couleurBarreOutil,0,0,0);
		modify_bg(B.barreOutil,State_Normal,B.couleurBarreOutil);	 
	--Création du bouton Nouveau fichier
		Gtk_New(B.btnNouveau);
		Gtk_New(B.imageNouveau,"logo/nouveau_fichier.png");
		Set_Image(B.btnNouveau,B.imageNouveau);
		Append_Widget(B.barreOutil,B.btnNouveau);
		Append_Space(B.barreOutil);
	--Création du bouton Enregistrer
		Gtk_New(B.btnEnregistrer);
		Gtk_New(B.imageEnregistrer,"logo/enregistrer.png");
		Set_Image(B.btnEnregistrer,B.imageEnregistrer);
		Append_Widget(B.barreOutil,B.btnEnregistrer);
	--Création du bouton Enregistrer tout
		Gtk_New(B.btnEnregistrerTout);
		Gtk_New(B.imageEnregistrerTout,"logo/tout_enregistrer.png");
		Set_Image(B.btnEnregistrerTout,B.imageEnregistrerTout);
		Append_Widget(B.barreOutil,B.btnEnregistrerTout);
	--Création du bouton Enregistrer sous
		Gtk_New(B.btnEnregistrerSous);
		Gtk_New(B.imageEnregistrerSous,"logo/enregistrer_sous.png");
		Set_Image(B.btnEnregistrerSous,B.imageEnregistrerSous);
		Append_Widget(B.barreOutil,B.btnEnregistrerSous);
		Append_Space(B.barreOutil);
	--Création du bouton Compiler
		Gtk_New(B.btnCompiler);
		Gtk_New(B.imageCompiler,"logo/compiler.png");
		Set_Image(B.btnCompiler,B.imageCompiler);
		Append_Widget(B.barreOutil,B.btnCompiler);
	--Création du bouton Pause
		Gtk_New(B.btnPause);
		Gtk_New(B.imagePause,"logo/pause.png");
		Set_Image(B.btnPause,B.imagePause);
		Append_Widget(B.barreOutil,B.btnPause);
	--Création du bouton Arreter
		Gtk_New(B.btnArreter);
		Gtk_New(B.imageArreter,"logo/arreter.png");
		Set_Image(B.btnArreter,B.imageArreter);
		Append_Widget(B.barreOutil,B.btnArreter);
		Append_Space(B.barreOutil);
	--Création de la barre de chargement
		--Gtk_New(B.chargement);
		--Set_Text(B.chargement,"0%");
		--Set_Pulse_Step(B.chargement,10.0);
		--Set_Fraction(B.chargement,0.0);
		--Append_Widget(B.barreOutil,B.chargement);	
	--Couleur
	END Initialize;

	
END P_barreOutil;
