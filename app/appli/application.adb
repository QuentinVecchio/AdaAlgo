--Packages ADA
WITH SIMPLE_IO;		USE SIMPLE_IO; 
--Packages GTK
WITH Gtk.Main ;      	USE Gtk.Main ;
WITH Gtk.Widget ;     	USE Gtk.Widget ; 
WITH Gtk.Window ;       USE Gtk.Window ;
WITH Gtk.Enums ;        USE Gtk.Enums ;
WITH Gtk.Table;		USE Gtk.Table;
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
WITH Gtk.Handlers;
--Mes Packages
WITH P_Menu;		USE P_Menu;
WITH P_BarreOutil;	USE P_BarreOutil;
WITH P_Page;		USE P_Page;
WITH P_aideAlgo;	USE P_aideAlgo;	


PROCEDURE application IS
--*****************INITIALISATIONS DES VARIABLES ET SS-PGMES*****************--
--VARIABLES
	--Fenetres
		fenetrePrincipale : Gtk_Window;
	--Tables	
		Table : Gtk_Table;	
	--Couleursc
		couleurFenetrePrincipal : Gdk_Color;	
	--Menus	
		Menu : T_Menu;
	--Barres Outils
		Outil : T_BarreOutil;
		OutilAlgo : T_BarreAideAlgo;
	--Page
		page : T_page;
	--TYPE
		type T_AjoutOnglet is record
			pag : T_Page;
			ong : Gtk_Notebook;		
		end record;
		paramPage : T_AjoutOnglet;
--SIGNAUX
	--Quitter
		PACKAGE P_Callback IS NEW Gtk.Handlers.Callback(Gtk_Widget_Record) ;
		USE P_Callback ;
	
		PROCEDURE Stop_Program(Emetteur : access Gtk_Widget_Record'class) IS
   			PRAGMA Unreferenced (Emetteur);
		BEGIN
   			Main_Quit;
		END Stop_Program ;
	PACKAGE P_CallbackAjout  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,T_AjoutOnglet) ;
	USE P_CallbackAjout;
	--Fonction Ajout Si
		PROCEDURE AjoutSi(Emetteur :  access Gtk_Widget_Record'class; pageParam : T_AjoutOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
			Insert_At_Cursor(buffer,Character'val(13) &"si  alors"& Character'val(13));
			Insert_At_Cursor(buffer,Character'val(13) & "fsi"& Character'val(13));
			Grab_Focus(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
		END AjoutSi;
	--Fonction Ajout Sinon Si
		PROCEDURE AjoutSinonSi(Emetteur :  access Gtk_Widget_Record'class; pageParam : T_AjoutOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
			Insert_At_Cursor(buffer,Character'val(13) &"sinon si  alors"& Character'val(13));
			Grab_Focus(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
		END AjoutSinonSi;
	--Fonction Ajout Sinon
		PROCEDURE AjoutSinon(Emetteur :  access Gtk_Widget_Record'class;pageParam : T_AjoutOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
			Insert_At_Cursor(buffer,Character'val(13) &"sinon");
			Grab_Focus(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
		END AjoutSinon;
	--Fonction Ajout Pour
		PROCEDURE AjoutPour(Emetteur :  access Gtk_Widget_Record'class; pageParam : T_AjoutOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
			Insert_At_Cursor(buffer,Character'val(13) &"pour  <-  a  faire"& Character'val(13));
			Insert_At_Cursor(buffer,Character'val(13) & "fpour"& Character'val(13));
			Grab_Focus(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
		END AjoutPour;
	--Fonction Ajout Tant Que
		PROCEDURE AjoutTantQue(Emetteur :  access Gtk_Widget_Record'class; pageParam : T_AjoutOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
			Insert_At_Cursor(buffer,Character'val(13) &"tq faire"& Character'val(13));
			Insert_At_Cursor(buffer,Character'val(13) & "ftq"& Character'val(13));
			Grab_Focus(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
		END AjoutTantQue;
	--Fonction Ajout Repeter
		PROCEDURE AjoutRepeter(Emetteur :  access Gtk_Widget_Record'class; pageParam : T_AjoutOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
			Insert_At_Cursor(buffer,Character'val(13) &"repeter"& Character'val(13));
			Insert_At_Cursor(buffer,Character'val(13) & "jqa "& Character'val(13));
			Grab_Focus(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
		END AjoutRepeter;
	--Fonction Ajout Ecrire
		PROCEDURE AjoutEcrire(Emetteur :  access Gtk_Widget_Record'class; pageParam : T_AjoutOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
			Insert_At_Cursor(buffer,Character'val(13) &"ecrire()"& Character'val(13));
			Grab_Focus(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
		END AjoutEcrire;
	--Fonction Ajout Lire
		PROCEDURE AjoutLire(Emetteur :  access Gtk_Widget_Record'class; pageParam : T_AjoutOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
			Insert_At_Cursor(buffer,Character'val(13) &"lire()"& Character'val(13));
			Grab_Focus(pageParam.pag.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
		END AjoutLire;
	--Fonction Ajout Entier
		PROCEDURE AjoutEntier(Emetteur :  access Gtk_Widget_Record'class; pageParam : T_AjoutOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(pageParam.pag.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
			Insert_At_Cursor(buffer," (entier) : "& Character'val(13));
			Grab_Focus(pageParam.pag.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
		END AjoutEntier;
	--Fonction Ajout Reel
		PROCEDURE AjoutReel(Emetteur :  access Gtk_Widget_Record'class; pageParam : T_AjoutOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(pageParam.pag.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
			Insert_At_Cursor(buffer," (entier) : "& Character'val(13));
			Grab_Focus(pageParam.pag.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
		END AjoutReel;
	--Fonction Ajout Caractere
		PROCEDURE AjoutCaractere(Emetteur :  access Gtk_Widget_Record'class; pageParam : T_AjoutOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(pageParam.pag.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
			Insert_At_Cursor(buffer," (Caractere) : "& Character'val(13));
			Grab_Focus(pageParam.pag.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
		END AjoutCaractere;
	--Fonction Ajout Chaine
		PROCEDURE AjoutChaine(Emetteur :  access Gtk_Widget_Record'class; pageParam : T_AjoutOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(pageParam.pag.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
			Insert_At_Cursor(buffer," (Chaine) : "& Character'val(13));
			Grab_Focus(pageParam.pag.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
		END AjoutChaine;
	--Fonction Ajout Bool
		PROCEDURE AjoutBool(Emetteur :  access Gtk_Widget_Record'class; pageParam : T_AjoutOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(pageParam.pag.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
			Insert_At_Cursor(buffer," (Bool) : "& Character'val(13));
			Grab_Focus(pageParam.pag.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1));
		END AjoutBool;
	--Nouveau Fichier
		PACKAGE P_CallbackPage IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,T_Page) ;
		USE P_CallbackPage;
		PROCEDURE NouveauFichier(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
		BEGIN	
			Insert_Page(page.onglet,page.Table(3),page.labelTitre(3),Get_Current_Page(page.onglet));
		END NouveauFichier;
	--Fermer Onglet
		PACKAGE P_CallbackNoteBook IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,Gtk_Notebook) ;
		USE P_CallbackNoteBook;
		PROCEDURE FermerFichier(Emetteur :  access Gtk_Widget_Record'class; oglt : Gtk_Notebook) IS
		PRAGMA Unreferenced (Emetteur);
		BEGIN
			Remove_Page(oglt,Get_Current_Page(oglt)); 
		END FermerFichier;
	--Enregistrer
		PACKAGE P_CallbackTV  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,Gtk_Text_View) ;
		USE P_CallbackTV;
		PROCEDURE Enregistrer(Emetteur :  access Gtk_Widget_Record'class; Text : Gtk_text_View) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
			start_iter : Gtk_Text_Iter;
			end_iter : Gtk_Text_Iter; 
			Dialog  : GTK_File_Chooser_Dialog ;
			win : Gtk_Window;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(Text);
			Get_Start_Iter(buffer,start_iter);
			Get_End_Iter(buffer,end_iter); 
   			PUT_LINE(Get_Text(buffer,start_Iter,end_Iter,TRUE));	
			Gtk_New(Win,Window_Toplevel);	 
			Gtk_new(dialog, "Sauvegarde du fichier", win,Action_Save);
			dialog.Show;
		END Enregistrer;
	---Compiler
		PROCEDURE Compiler(Emetteur :  access Gtk_Widget_Record'class; pageParam : T_AjoutOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
			start_iter : Gtk_Text_Iter;
			end_iter : Gtk_Text_Iter;
			i : Integer; 
		BEGIN
			i := Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1;
			Gtk_New(buffer);
			buffer := Get_Buffer(pageParam.pag.zoneCode(i));
			Get_Start_Iter(buffer,start_iter);
			Get_End_Iter(buffer,end_iter); 
   			PUT_LINE(Get_Text(buffer,start_Iter,end_Iter,TRUE));
		END Compiler;
				
--*****************CODE SOURCE*****************--
BEGIN 
Init ;
--Initialisation de la fenetre principale
   	Gtk_New(fenetrePrincipale,Window_Toplevel);
   	fenetrePrincipale.Set_Title("AlgoAda");
   	fenetrePrincipale.set_default_size(Get_Width(Get_Default),Get_Height(Get_Default));
   	Connect(fenetrePrincipale, "destroy",Stop_Program'ACCESS);
	Set_Rgb(couleurFenetrePrincipal,45796,45796,45796);
	modify_bg(fenetrePrincipale,State_Normal,couleurFenetrePrincipal); 
--Initialisation de la table
	Gtk_New(Table,25,40,True);
	fenetrePrincipale.Add(table);
--Initialisation du menu
	table.attach(Menu.barreMenu,0,40,0,1);
--Initialisation de la barre de tache
	table.attach(Outil.barreOutil,0,40,0,1);	
--Initialisation du box Central
	--Création de la barre Aide
		table.attach(OutilAlgo.barreOutil,1,3,3,24);
	--Zone central						
		Table.attach(page.onglet,4,39,1,24);
 	paramPage.pag := page;
	paramPage.ong := page.onglet;
--Initialisations des fonctions de boutons
	fenetrePrincipale.Show_all ;
	Connect(Outil.btnNouveau, "clicked",NouveauFichier'ACCESS, page);
	Connect(Outil.btnEnregistrer, "clicked",Enregistrer'ACCESS, page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
	FOR I in 1..5 LOOP	
		Connect(page.btnFermer(I), "clicked",FermerFichier'ACCESS,page.onglet);
	END LOOP;
	Connect(Outil.btnCompiler, "clicked",Compiler'ACCESS,paramPage);
	Connect(OutilAlgo.btnSi, "clicked",AjoutSi'ACCESS,paramPage);
	Connect(OutilAlgo.btnSinonSi, "clicked",AjoutSinonSi'ACCESS,paramPage);
	Connect(OutilAlgo.btnSinon, "clicked",AjoutSinon'ACCESS,paramPage);
	Connect(OutilAlgo.btnPour, "clicked",AjoutPour'ACCESS,paramPage);
	Connect(OutilAlgo.btnTantQue, "clicked",AjoutTantQue'ACCESS,paramPage);
	Connect(OutilAlgo.btnRepeter, "clicked",AjoutRepeter'ACCESS,paramPage);
	Connect(OutilAlgo.btnEcrire, "clicked",AjoutEcrire'ACCESS,paramPage);
	Connect(OutilAlgo.btnLire, "clicked",AjoutLire'ACCESS,paramPage);
	Connect(OutilAlgo.btnEntier, "clicked",AjoutEntier'ACCESS,paramPage);
	Connect(OutilAlgo.btnReel, "clicked",AjoutReel'ACCESS,paramPage);
	Connect(OutilAlgo.btnCaractere, "clicked",AjoutCaractere'ACCESS,paramPage);
	Connect(OutilAlgo.btnChaine, "clicked",AjoutChaine'ACCESS,paramPage);
	Connect(OutilAlgo.btnBool, "clicked",AjoutBool'ACCESS,paramPage);		
--Affichage de la fenetre  		
   	Main ;
END application ;

