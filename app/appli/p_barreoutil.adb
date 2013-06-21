--******************************************************************************--
--	Code source Application AlgoAda Projet Universitaire IUT de Metz	--
--	Developpeur : Quentin Vecchio Date modif : 20 juin 2013			--
--	Spécification p_barreOutil.adb	 Gere la barre d'outil			--
--	Package									--
--******************************************************************************--

--Importations des packages
--Package Gtk
WITH Gtk.ToolBar;	USE Gtk.ToolBar;
WITH Gtk.Image;		USE Gtk.Image;
WITH Gtk.Button ;       USE Gtk.Button ;
WITH Gdk.Color;		USE Gdk.Color;
WITH Gtk.File_Chooser_Dialog;	USE Gtk.File_Chooser_Dialog;
WITH Gtk.File_Chooser;	USE Gtk.File_Chooser;
WITH Gtk.Progress_Bar;	USE Gtk.Progress_Bar;
WITH  Gtk.Tooltips;	USE  Gtk.Tooltips;
WITH Gtk.Handlers;

--Déclaration du paquetage
PACKAGE BODY P_barreOutil IS
	
--Constructeur de la structure
	PROCEDURE Initialize(B : IN OUT T_BarreOutil) IS
	BEGIN
	--aide
		Gtk_New(B.aide);
	--Création de la barre	
		Gtk_New(B.barreOutil);
		Set_Rgb(B.couleurBarreOutil,0,0,0);
		modify_bg(B.barreOutil,State_Normal,B.couleurBarreOutil);	 
	--Création du bouton Nouveau fichier
		Gtk_New(B.btnNouveau);
		Gtk_New(B.imageNouveau,"logo/nouveau_fichier.png");
		Set_Image(B.btnNouveau,B.imageNouveau);
		Set_Tip(B.aide,B.btnNouveau,"Nouveau Fichier");
		Set_Relief(B.btnNouveau,Relief_None);
		Append_Widget(B.barreOutil,B.btnNouveau);
		Append_Space(B.barreOutil);
	--Création du bouton Ouvrir
		Gtk_New(B.btnOuvrir);
		Gtk_New(B.imageOuvrir,"logo/ouvrir_fichier.png");
		Set_Image(B.btnOuvrir,B.imageOuvrir);
		Set_Tip(B.aide,B.btnOuvrir,"Ouvrir Fichier");
		Set_Relief(B.btnOuvrir,Relief_None);
		Append_Widget(B.barreOutil,B.btnOuvrir);
	--Création du bouton Enregistrer
		Gtk_New(B.btnEnregistrer);
		Gtk_New(B.imageEnregistrer,"logo/enregistrer.png");
		Set_Image(B.btnEnregistrer,B.imageEnregistrer);
		Set_Tip(B.aide,B.btnEnregistrer,"Enregistrer Fichier");
		Set_Relief(B.btnEnregistrer,Relief_None);
		Append_Widget(B.barreOutil,B.btnEnregistrer);	
	--Création du bouton Compiler
		Gtk_New(B.btnCompiler);
		Gtk_New(B.imageCompiler,"logo/compiler.png");
		Set_Image(B.btnCompiler,B.imageCompiler);
		Set_Tip(B.aide,B.btnCompiler,"Compiler");
		Set_Relief(B.btnCompiler,Relief_None);
		Append_Widget(B.barreOutil,B.btnCompiler);		
		Append_Space(B.barreOutil);
	--Création de la barre de chargement
		--Gtk_New(B.chargement);
		--Set_Text(B.chargement,"0%");
		--Set_Pulse_Step(B.chargement,10.0);
		--Set_Fraction(B.chargement,0.0);
		--Append_Widget(B.barreOutil,B.chargement);	
	END Initialize;
END P_barreOutil;
