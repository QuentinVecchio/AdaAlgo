--******************************************************************************--
--	Code source Application AlgoAda Projet Universitaire IUT de Metz	--
--	Developpeur : Quentin Vecchio Date modif : 20 juin 2013			--
--	Code Source Application.adb	Lance toute l'application		--
--******************************************************************************--

--Importation des packages
--Packages ADA
WITH SIMPLE_IO;		USE SIMPLE_IO;
WITh GNAT.Calendar;	USE GNAT.Calendar;
WITH Ada.Calendar; 	USE Ada.Calendar;
--Packages GTK
WITH Gtk.Main ;      	USE Gtk.Main ;
WITH Gtk.Widget ;     	USE Gtk.Widget ; 
WITH Gtk.Window ;       USE Gtk.Window ;
WITH Gtk.Message_Dialog;USE Gtk.Message_Dialog;
WITH Gtk.Enums ;        USE Gtk.Enums ;
WITH Gtk.Image;		USE Gtk.Image;
WITH Gtk.Table;		USE Gtk.Table;
WITH Gtk.Button; 	USE Gtk.Button;
WITH Gtk.Box;		USE Gtk.Box;
WITH Gtk.Bin ;          USE Gtk.Bin ;
WITH Gtk.Text_View;	USE Gtk.Text_View;
WITH Gtk.Text_Buffer;	USE Gtk.Text_Buffer;
WITH Gtk.Text_Iter; 	USE Gtk.Text_Iter;
WITH Gtk.Widget ;     	USE Gtk.Widget ;
WITH Gdk.Color;		USE Gdk.Color;
WITH Gdk.Pixbuf;	USE Gdk.Pixbuf;
WITH Gdk.Visual;	USE Gdk.Visual;
WITh Glib.Error;	USE Glib.Error;
WITH Gdk.Screen;	USE Gdk.Screen;
WITH Gtk.File_Chooser_Dialog;	USE Gtk.File_Chooser_Dialog;
WITH Gtk.File_Chooser;	USE Gtk.File_Chooser;
WITH Gtk.Label;		USE Gtk.Label; 
WITH Gtk.Dialog;	USE Gtk.Dialog;
WITH Gtk.Notebook;	USE Gtk.Notebook;
WITH Glib;		USE Glib;
WITH Gtk.Progress_Bar;	USE Gtk.Progress_Bar;
WITH Gtk.Handlers;	USE Gtk.Handlers;
WITh Gtk.File_Filter;	USE Gtk.File_Filter;
WITH Gtk.About_Dialog;	USE Gtk.About_Dialog;
--Mes Packages
WITH P_Menu;		USE P_Menu;
WITH P_BarreOutil;	USE P_BarreOutil;
WITH P_Page;		USE P_Page;
WITH P_aideAlgo;	USE P_aideAlgo;	
--Packages autres développeur (Matthieu,Cindy,Nicolas)
with mstring;		use mstring;
with definitions; 	use definitions;
with gestionbloc; 	use gestionbloc;
with analyse; 		use analyse;
with conversion; 	use conversion;
with generateur;	use generateur;

PROCEDURE application IS
--*****************INITIALISATIONS DES VARIABLES*****************--
--VARIABLES
	--Fenetres
		fenetrePrincipale : Gtk_Window;
		fenetreDemarrage : Gtk_Window;
	--Tables	
		Table : Gtk_Table;
		TableDemarrage : Gtk_Table;	
	--Couleurs
		couleurFenetrePrincipal : Gdk_Color;	
	--Menus	
		Menu : T_Menu;
	--Barres Outils
		Outil : T_BarreOutil;
		OutilAlgo : T_BarreAideAlgo;
	--temps
		tps : Time;
	--Page
		page : T_page;
	--vartps
		n : Integer;
		t : Integer;
	--Image et icone
		image : Gtk_Image;
		icone : Boolean;
	--Barre de chargement
		chargement : Gtk_Progress_Bar;
	--Label
		nom1,nom2,nom3,nom4, nomProg : Gtk_Label;
--TYPES
		--Stocke quels onglets sont libre : TRUE = Libre
		type tab_bool is array(1..5) of Boolean; 
		--Structure Permettant	de stocker le nécessaire pour enregistrer un fichier	
		type T_EnregFic is record
			texte : String(1..100000);
			variable : String(1..100000);
			fonction : String(1..1000);
			iCode,iVariable, iFonction : integer;
			Chr : GTK_File_Chooser;
			page : T_Page;	
		end record;
		--Pointeur permettant de modifier le tableau des onglets ouvert
		Type T_Pointeur is access tab_bool;
		--Structure permettant de gerer les onglets dans les callback		
		type T_GestionOnglet is record
			page : T_Page;
			pointeur : T_Pointeur;
			pointeurSauv : T_Pointeur;
			btn : Gtk_Button;
		end record;
		--Structure permettant de stocker le nécessaire pour ouvrir un fichier dans un nouvel onglet
		type T_OuvrirFic is record
			page : T_Page;
			Chr : GTK_File_Chooser;
			GestionOnglet : T_GestionOnglet;	
		end record;
		--Structure Permettant	de stocker le nécessaire pour enregistrer un fichier Ada	
		type T_EnregFicAda is record
			texte : String(1..100000);
			Chr : GTK_File_Chooser; 	
		end record;
		--Structure Permettant	de stocker le nécessaire pour enregistrer un fichier et gerer les sauvegardes	
		type T_PageSauv is record
			page : T_Page;
			pointeurSauv : T_Pointeur;
			pointeurDejaSauv : T_Pointeur;		
		end record;
	--Variable utilisant les nouveau types
		ongletDispo : tab_bool;
		sauvegarde : tab_bool;
		pageSauv : T_PageSauv;
		GestionOnglet : T_GestionOnglet;
--***************Déclaration package pour les signaux**************************-
	--Package pour la fonction Quitter	
	PACKAGE P_Callback IS NEW Gtk.Handlers.Callback(Gtk_Widget_Record) ;
	USE P_Callback ;
	
	--Package pour les fonction travaillant sur la variable page
	PACKAGE P_CallbackPage IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,T_Page) ;
	USE P_CallbackPage;
	
	PACKAGE P_CallbackNoteBook IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,Gtk_Notebook) ;	
	USE P_CallbackNoteBook;
	
	--Package pour les fonctions travaillant sur des text_view	
	PACKAGE P_CallbackTV  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,Gtk_Text_View) ;
	USE P_CallbackTV;

	--Package pour les fonctions travaillant sur les onglets
	PACKAGE P_CallbackGestionOnglet  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,T_GestionOnglet) ;
	USE P_CallbackGestionOnglet;

	--Package pour les fonctions permettant d'enregistrer
	PACKAGE P_CallbackEnreg  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,T_EnregFic) ;
	USE P_CallbackEnreg;

	--Package pour fermer une boite de dialog
	PACKAGE P_CallbackFermerDialog  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,GTK_File_Chooser_Dialog) ;
	USE P_CallbackFermerDialog;

	--Package pour les fonctions permettant d'ouvrir
	PACKAGE P_CallbackOuvrir  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,T_OuvrirFic) ;
	USE P_CallbackOuvrir;

	--Package pour les fonctions permettant d'enregistrer un fichier Ada
	PACKAGE P_CallbackEnregAda  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,T_EnregFicAda) ;
	USE P_CallbackEnregAda;

	--Package pour les fonctions permettant d'enregistrer un fichier et gérer les sauvegardes
	PACKAGE P_CallbackSauv  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,T_PageSauv) ;
	USE P_CallbackSauv;

	--Package pour les fonctions sur les fenetres
	PACKAGE P_CallbackWin  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,Gtk_window) ;
	USE P_CallbackWin;

--************************Création des signaux, fonction executer par les boutons***********************--
	
--Fonction qui agit sur l'application
	--Fonction Quitter
	--Ne prend pas de parametre
	--Fermer l'application
		PROCEDURE Stop_Program(Emetteur : access Gtk_Widget_Record'class) IS
   			PRAGMA Unreferenced (Emetteur);
		BEGIN
			Main_Quit;
		END Stop_Program ;

	--Fonction A propos de
	--Ne prend pas de parametre
	--fenetre dialog about
		PROCEDURE AProposDE(Emetteur : access Gtk_Widget_Record'class) IS
   			PRAGMA Unreferenced (Emetteur);
			dialog : Gtk_About_Dialog;
			Image :  Gdk_Pixbuf ;
			erreur : GError;
		BEGIN
   			Gtk_New(dialog);
			Set_Comments(dialog,"Logiciel de conversion Algorithme vers Ada");
			Set_Version(dialog,"v1.0");
			Set_Program_Name(dialog,"AlgoAda");
			Set_Copyright(dialog,"BCVW");
			Gdk_New_From_File(Image,"logo/logo.png",erreur) ;
   			dialog.set_logo(Image) ;
			IF dialog.Run = Gtk_Response_Cancel THEN
				Destroy(dialog);   			
			END IF ;
		END AProposDE ;

	--Fonction mode normal
	--prend la fenetre en parametre
	--met la fenetre en unfullscreen
		PROCEDURE modeNormal(Emetteur : access Gtk_Widget_Record'class;win : Gtk_window ) IS
   			PRAGMA Unreferenced (Emetteur);
		BEGIN
   			win.unfullscreen;
		END modeNormal;

	--Fonction mode plein ecran
	--prend la fenetre en parametre
	--met la fenetre en fullscreen
		PROCEDURE modeEcran(Emetteur : access Gtk_Widget_Record'class;win : Gtk_window ) IS
   			PRAGMA Unreferenced (Emetteur);
		BEGIN
   			win.fullscreen;
		END modeEcran;

--Fonctions qui agit sur les zones d'algo
	--Fonction Ajout Si
	--Prend en parametre la page
	--Ajoute "Si" où il y a le curseur
		PROCEDURE AjoutSi(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
			Insert_At_Cursor(buffer,ASCII.LF &"si  alors"& ASCII.LF);
			Insert_At_Cursor(buffer,ASCII.LF & "fsi"& ASCII.LF);
			Grab_Focus(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
		END AjoutSi;

	--Fonction Ajout Sinon Si
	--Prend en parametre la page
	--Ajoute "Sinon Si" où il y a le curseur
		PROCEDURE AjoutSinonSi(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
			Insert_At_Cursor(buffer,ASCII.LF &"sinon si  alors"& ASCII.LF);
			Grab_Focus(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
		END AjoutSinonSi;

	--Fonction Ajout Sinon
	--Prend en parametre la page
	--Ajoute "Sinon" où il y a le curseur
		PROCEDURE AjoutSinon(Emetteur :  access Gtk_Widget_Record'class;page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
			Insert_At_Cursor(buffer,ASCII.LF &"sinon");
			Grab_Focus(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
		END AjoutSinon;

	--Fonction Ajout Pour
	--Prend en parametre la page
	--Ajoute "Pour" où il y a le curseur
		PROCEDURE AjoutPour(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
			Insert_At_Cursor(buffer,ASCII.LF &"pour  <-  a  faire"& ASCII.LF);
			Insert_At_Cursor(buffer,ASCII.LF & "fpour"& ASCII.LF);
			Grab_Focus(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
		END AjoutPour;

	--Fonction Ajout Tant Que
	--Prend en parametre la page
	--Ajoute "Tant que" où il y a le curseur
		PROCEDURE AjoutTantQue(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
			Insert_At_Cursor(buffer,ASCII.LF &"tq faire"& ASCII.LF);
			Insert_At_Cursor(buffer,ASCII.LF & "ftq"& ASCII.LF);
			Grab_Focus(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
		END AjoutTantQue;

	--Fonction Ajout Repeter
	--Prend en parametre la page
	--Ajoute "Repeter" où il y a le curseur
		PROCEDURE AjoutRepeter(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
			Insert_At_Cursor(buffer,ASCII.LF &"repeter"& ASCII.LF);
			Insert_At_Cursor(buffer,ASCII.LF & "jqa "& ASCII.LF);
			Grab_Focus(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
		END AjoutRepeter;

	--Fonction Ajout Ecrire
	--Prend en parametre la page
	--Ajoute "Ecrire" où il y a le curseur
		PROCEDURE AjoutEcrire(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
			Insert_At_Cursor(buffer,ASCII.LF &"ecrire()"& ASCII.LF);
			Grab_Focus(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
		END AjoutEcrire;

	--Fonction Ajout Lire
	--Prend en parametre la page
	--Ajoute "Lire" où il y a le curseur
		PROCEDURE AjoutLire(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
			Insert_At_Cursor(buffer,ASCII.LF &"lire()"& ASCII.LF);
			Grab_Focus(page.zoneCode(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
		END AjoutLire;

--Fonctions qui agit sur les zones de variables
	--Fonction Ajout Entier
	--Prend en parametre la page
	--Ajoute un Entier où il y a le curseur
		PROCEDURE AjoutEntier(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
			Insert_At_Cursor(buffer," (entier) : "& ASCII.LF);
			Grab_Focus(page.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
		END AjoutEntier;

	--Fonction Ajout Reel
	--Prend en parametre la page
	--Ajoute un Reel où il y a le curseur
		PROCEDURE AjoutReel(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
			Insert_At_Cursor(buffer," (Reel) : "& ASCII.LF);
			Grab_Focus(page.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
		END AjoutReel;

	--Fonction Ajout Caractere
	--Prend en parametre la page
	--Ajoute un caractere où il y a le curseur
		PROCEDURE AjoutCaractere(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
			Insert_At_Cursor(buffer," (Caractere) : "& ASCII.LF);
			Grab_Focus(page.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
		END AjoutCaractere;

	--Fonction Ajout Chaine
	--Prend en parametre la page
	--Ajoute un Chaine où il y a le curseur
		PROCEDURE AjoutChaine(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
			Insert_At_Cursor(buffer," (Chaine) : "& ASCII.LF);
			Grab_Focus(page.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
		END AjoutChaine;

	--Fonction Ajout Booleen
	--Prend en parametre la page
	--Ajoute un Booleen où il y a le curseur
		PROCEDURE AjoutBool(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
			Insert_At_Cursor(buffer," (Booleen) : "& ASCII.LF);
			Grab_Focus(page.zoneVariable(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
		END AjoutBool;

--Fonctions qui agit sur les zones de Fonctions
	--Fonction Ajout IN
	--Prend en parametre la page
	--Ajoute un ↓ où il y a le curseur
		PROCEDURE AjoutIn(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneFct(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
			Insert_At_Cursor(buffer," ↓");
			Grab_Focus(page.zoneFct(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
		END AjoutIn;

	--Fonction Ajout OUT
	--Prend en parametre la page
	--Ajoute un ↑ où il y a le curseur
		PROCEDURE AjoutOut(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneFct(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
			Insert_At_Cursor(buffer," ↑");
			Grab_Focus(page.zoneFct(Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1));
		END AjoutOut;

--Fonctions logiciels qui agit sur l'application et/ou sur l'ordinateur
	--Nouveau Fichier
	--Prend en parametre une structure T_GestionOnglet
	--Ajoute un onglet à la page
		PROCEDURE NouveauFichier(Emetteur :  access Gtk_Widget_Record'class; GestionOnglet : T_GestionOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			n : Integer := 0;		
		BEGIN	
			FOR I in 1..5 LOOP
				if(GestionOnglet.pointeur(i) = TRUE AND n = 0) then
					n := I;
				end if;
			END LOOP;
			if n /= 0 then
				Set_No_Show_All(GestionOnglet.page.Table(n),FALSE);
				Set_No_Show_All(GestionOnglet.page.Boite(n),FALSE);
				Show_All(GestionOnglet.page.Table(n));
				Show_all(GestionOnglet.page.Boite(n));
				GestionOnglet.pointeur(n) := NOT GestionOnglet.pointeur(n);
				Grab_Focus(GestionOnglet.page.zoneFct(n));
			end if;
		END NouveauFichier;


	--Fermer Onglet
	--Prend en parametre une structure T_GestionOnglet
	--Enleve un onglet à la page
		PROCEDURE FermerFichier(Emetteur :  access Gtk_Widget_Record'class; GestionOnglet :  T_GestionOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			n : Integer;
			bufferCode : Gtk_Text_Buffer;
			bufferAda : Gtk_Text_Buffer;
			bufferVariable : Gtk_Text_Buffer;
			bufferDebug : Gtk_Text_Buffer;
			start_iter : Gtk_Text_Iter;
			end_iter : Gtk_Text_Iter;
			start_iterVariable : Gtk_Text_Iter;
			end_iterVariable : Gtk_Text_Iter; 
			dialog : Gtk_Message_Dialog;
			win : Gtk_Window; 
			bool : Boolean := TRUE;
		BEGIN
			n := Integer'Value(Gint'Image(Get_Current_Page(GestionOnglet.page.onglet)))+1;
			Gtk_New(Win,Window_Toplevel);
			Gtk_New(bufferCode);
			Gtk_New(bufferAda);
			Gtk_New(bufferVariable);
			Gtk_New(bufferDebug);
			bufferCode := Get_Buffer(GestionOnglet.page.zoneCode(n));
			bufferAda := Get_Buffer(GestionOnglet.page.zoneAda(n));
			bufferVariable := Get_Buffer(GestionOnglet.page.zoneVariable(n));
			bufferDebug := Get_Buffer(GestionOnglet.page.zoneDebug(n));
			Get_Start_Iter(bufferCode,start_iter);
			Get_End_Iter(bufferCode,end_iter);
			Get_Start_Iter(bufferVariable,start_iterVariable);
			Get_End_Iter(bufferVariable,end_iterVariable);
			if GestionOnglet.pointeurSauv(n) = FALSE AND (Get_Text(bufferCode,start_iter,end_iter) /= "" OR Get_Text(bufferVariable,start_iterVariable,end_iterVariable) /= "") then 
				Gtk_new(dialog,Win,0,Message_Warning,Buttons_Yes_No,"Fichier non enregistrer, voulez vous le faire maintenant ?");
				if dialog.run = Gtk_Response_Yes then
					Clicked(GestionOnglet.btn);
					bool := FALSE;
				end if;
				Destroy(dialog);
			end if;
			if bool then
				Set_Text(bufferCode,"");
				Set_Text(bufferAda,"");
				Set_Text(bufferVariable,"");
				Set_Text(bufferDebug,"");			
				GestionOnglet.pointeur(n) := NOT GestionOnglet.pointeur(n);
				Set_No_Show_All(GestionOnglet.page.Table(n),TRUE);
				Set_No_Show_All(GestionOnglet.page.Boite(n),TRUE);
				Hide(GestionOnglet.page.Table(n));
				Hide(GestionOnglet.page.Boite(n));
			end if;		
		END FermerFichier;

	--Enregistrer fichier
	--Prend en parametre une structure T_EnregFic
	--Enregistre le fichier sur le disque
			PROCEDURE EnregistrerFichier(Emetteur :  access Gtk_Widget_Record'class; Enreg : T_EnregFic) IS
				PRAGMA Unreferenced (Emetteur);
				code: T_Tab_ligne;
				variable : T_Tab_ligne;
				ch1 : chaine;
				ch2 : chaine;
				ch3 :chaine;
				l : Integer;
				s : String(1..100);
			BEGIN
				if Enreg.iCode /= 0 and Enreg.iVariable /= 0 then
					ch1 := createChaine(Enreg.texte(1..Enreg.iCode));
					ch2 := createChaine(Enreg.variable(1..Enreg.iVariable));
					Put_line(ch1);
					put_line(ch2);
					labeltoStr(ch1, code);
					labeltoStr(ch2, variable);
					enregistrer(Get_Filename(Enreg.Chr),Enreg.fonction(1..Enreg.iFonction),code,variable);
					ch3 := CreateChaine(Get_Filename(Enreg.Chr));
					toString(subString(ch3,strlastpos(ch3,'/')+1,length(ch3)),s,l);
					Set_Label(Enreg.page.labelTitre(Integer'Value(Gint'Image(Get_Current_Page(Enreg.page.onglet)))+1),"<span foreground = 'black'>" & s(1..l) & "</span>");
					Set_Use_Markup(Enreg.page.labelTitre(Integer'Value(Gint'Image(Get_Current_Page(Enreg.page.onglet)))+1),TRUE);
				end if;
			END EnregistrerFichier;

	--Fermer Dialog
	--Prend en parametre une dialog_Box
	--Ferme une dialog Box
			PROCEDURE FermerDialog(Emetteur :  access Gtk_Widget_Record'class; dialog : GTK_File_Chooser_Dialog) IS
				PRAGMA Unreferenced (Emetteur);
			BEGIN
				dialog.destroy;
			END FermerDialog;
	
	--Enregistrer
	--Prend en parametre une page
	--Invite l'utilisateur à choisir un emplacement de sauvegarde
		PROCEDURE Enregistrer(Emetteur :  access Gtk_Widget_Record'class; pageSauv : T_PageSauv) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
			bufferVariable : Gtk_Text_Buffer;
			bufferFonction : Gtk_Text_Buffer;
			start_iter : Gtk_Text_Iter;
			end_iter : Gtk_Text_Iter;
			start_iterVariable : Gtk_Text_Iter;
			end_iterVariable : Gtk_Text_Iter;
			start_iterFonction : Gtk_Text_Iter;
			end_iterFonction : Gtk_Text_Iter; 
			dialog  : GTK_File_Chooser_Dialog;
			Chooser : GTK_File_Chooser; 
			win : Gtk_Window;
			btnEnregistrer : Gtk_Button;
			EnregFic : T_EnregFic;
			n : Integer;
			bool : Boolean;
		BEGIN
			n := Integer'Value(Gint'Image(Get_Current_Page(pageSauv.page.onglet)))+1;
			--Recuperation du code
				Gtk_New(buffer);
				buffer := Get_Buffer(pageSauv.page.zoneCode(n));
				Get_Start_Iter(buffer,start_iter);
				Get_End_Iter(buffer,end_iter);
			--Recuperation des variables
				Gtk_New(bufferVariable);
				bufferVariable := Get_Buffer(pageSauv.page.zoneVariable(n));
				Get_Start_Iter(bufferVariable,start_iterVariable);
				Get_End_Iter(bufferVariable,end_iterVariable);
			--Recuperation des fonctions
				Gtk_New(bufferFonction);
				bufferFonction := Get_Buffer(pageSauv.page.zoneFct(n));
				Get_Start_Iter(bufferFonction,start_iterFonction);
				Get_End_Iter(bufferFonction,end_iterFonction);
			--Initialisation de la structure
				EnregFic.iCode := Integer'Value(Gint'Image(Get_Char_Count(buffer)));
				EnregFic.texte(1..EnregFic.iCode) := Get_Text(buffer,start_Iter,end_Iter,TRUE);		
				EnregFic.iVariable := Integer'Value(Gint'Image(Get_Char_Count(bufferVariable)));
				EnregFic.variable(1..EnregFic.iVariable) := Get_Text(bufferVariable,start_IterVariable,end_IterVariable,TRUE);
				EnregFic.iFonction := Integer'Value(Gint'Image(Get_Char_Count(bufferFonction)));
				EnregFic.fonction(1..EnregFic.iFonction) := Get_Text(bufferFonction,start_IterFonction,end_IterFonction,TRUE);
			--Initialisation de la boite de dialogue
				Gtk_New(btnEnregistrer,"Enregistrer"); 						
				Gtk_New(Win,Window_Toplevel);
				Gtk_new(dialog, "Sauvegarde du fichier", win,Action_Save);
				Chooser:=+dialog; 
				EnregFic.Chr := Chooser;
				EnregFic.page :=  pageSauv.page;
				Set_Current_Name(Chooser,"MonFichier.alg");
				Set_Extra_Widget(Chooser,btnEnregistrer);
				bool := Set_Current_Folder(Chooser,lienFichierDefaut);
			--Fonction Bouton
				Connect(btnEnregistrer,"clicked",EnregistrerFichier'ACCESS,EnregFic);
				Connect(btnEnregistrer,"clicked",FermerDialog'ACCESS,dialog);
				pageSauv.pointeurSauv(n) := TRUE;
			--Affichage					 
				dialog.Show;
		END Enregistrer;

	--Enregistrer fichier Ada
	--Prend en parametre une structure T_EnregFic
	--Enregistre le fichier sur le disque
			PROCEDURE EnregistrerFichierAda(Emetteur :  access Gtk_Widget_Record'class; Enreg : T_EnregFicAda) IS
				PRAGMA Unreferenced (Emetteur);
			BEGIN
				--if Enreg.iCode /= 0 and Enreg.iVariable /= 0 then
				NULL;	
				--end if;
			END EnregistrerFichierAda;

	--Enregistrer ada
	--Prend en parametre une page
	--Invite l'utilisateur à choisir un emplacement de sauvegarde
		PROCEDURE EnregistrerAda(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
			start_iter : Gtk_Text_Iter;
			end_iter : Gtk_Text_Iter;
			dialog  : GTK_File_Chooser_Dialog;
			Chooser : GTK_File_Chooser; 
			win : Gtk_Window;
			btnEnregistrer : Gtk_Button;
			EnregFicAda : T_EnregFicAda;
			n : Integer;
		BEGIN
			n := Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1;
			--Recuperation du code ada
				Gtk_New(buffer);
				buffer := Get_Buffer(page.zoneAda(n));
				Get_Start_Iter(buffer,start_iter);
				Get_End_Iter(buffer,end_iter);
			--Initialisation de la structure
				EnregFicAda.texte(1..Integer'Value(Gint'Image(Get_Char_Count(buffer)))) := Get_Text(buffer,start_Iter,end_Iter,TRUE);
			--Initialisation de la boite de dialogue
				Gtk_New(btnEnregistrer,"Enregistrer"); 						
				Gtk_New(Win,Window_Toplevel);
				Gtk_new(dialog, "Sauvegarde du fichier", win,Action_Save);
				Chooser:=+dialog; 
				EnregFicAda.Chr := Chooser;
				Set_Current_Name(Chooser,"MonFichier.adb");
				Set_Extra_Widget(Chooser,btnEnregistrer);
			--Fonction Bouton
				Connect(btnEnregistrer,"clicked",EnregistrerFichierAda'ACCESS,EnregFicAda);
				Connect(btnEnregistrer,"clicked",FermerDialog'ACCESS,dialog);	
			--Affichage					 
				dialog.Show;
		END EnregistrerAda;

	--Ouvrir fichier
	--Prend en parametre une structure T_OuvrirFic
	--Ouvre un onglet et l'initialise avec un fichier
			PROCEDURE OuvrirFichier(Emetteur :  access Gtk_Widget_Record'class; Ouvrir : T_OuvrirFic) IS
				PRAGMA Unreferenced (Emetteur);
				n : Integer := 2;
				bufferCode : Gtk_Text_Buffer;
				bufferVariable : Gtk_Text_Buffer;
				bufferFonction : Gtk_Text_Buffer;
				code : T_Tab_ligne;
				variable : T_Tab_ligne;
				ch1,ch2,ch4 : chaine;
				s1,s2 : string(1..100000);
				n1,n2 : Integer;
				ch3 :chaine;	
				l : Integer;
				s : String(1..100);
				fct : String(1..1000);
				lS : Integer;
			BEGIN
				--Recuperation d'un onglet libre
				FOR I in 1..5 LOOP
					if(Ouvrir.GestionOnglet.pointeur(i) = TRUE AND n = 0) then
						n := I;
					end if;
				END LOOP;
				
				--Recuperation du code et des variables
					generateur.ouvrir(Get_Filename(Ouvrir.Chr),ch4,code,variable);	
				--Affichage code
					Gtk_New(bufferCode);
					bufferCode := Get_Buffer(Ouvrir.page.zoneCode(n));
					strtolabel(code,ch1);
					toString(ch1,s1,n1);
					Set_Text(bufferCode,s1(1..n1));
				--Affichage variable
					Gtk_New(bufferVariable);
					bufferVariable := Get_Buffer(Ouvrir.page.zoneVariable(n));
					strtolabel(variable,ch2);
					toString(ch2,s2,n2);
					Set_Text(bufferVariable,s2(1..n2));
				--Affichage fonction
					Gtk_New(bufferFonction);
					bufferFonction := Get_Buffer(Ouvrir.page.zoneFct(n));
					toString(ch4,fct,lS);
					Set_Text(bufferFonction,fct(1..lS));			
				--Gestion Onglets
					Grab_Focus(Ouvrir.page.zoneFct(n));
					Set_No_Show_All(page.Table(n),FALSE);
					Set_No_Show_All(page.Boite(n),FALSE);
					Show_All(page.Table(n));
					Show_all(page.Boite(n));
					Ouvrir.GestionOnglet.pointeur(n) := TRUE;
				--Gestion des labels
					ch3 := CreateChaine(Get_Filename(Ouvrir.Chr));	
					toString(subString(ch3,strlastpos(ch3,'/')+1,length(ch3)),s,l);
					Set_Label(Ouvrir.page.labelTitre(n),"<span foreground = 'black'>" & s(1..l) & "</span>");
					Set_Use_Markup(Ouvrir.page.labelTitre(n),TRUE);
					Grab_Focus(Ouvrir.page.labelTitre(n));			
			END OuvrirFichier;

	--Ouvrir
	--Prend en parametre une structure T_GestionOnglet
	--Invite l'utilisateur à choisir un fichier .alg
		PROCEDURE Ouvrir(Emetteur :  access Gtk_Widget_Record'class; GestionOnglet : T_GestionOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			dialog  : GTK_File_Chooser_Dialog;
			Chooser : GTK_File_Chooser; 
			win : Gtk_Window;
			btnValider : Gtk_Button;
			OuvrirFic : T_OuvrirFic;
			filtre : Gtk_File_Filter;
			bool : Boolean;
		BEGIN
			--Initialisation de la boite de dialogue
				Gtk_New(filtre);
				Gtk_New(btnValider,"Ouvrir"); 						
				Gtk_New(Win,Window_Toplevel);
				Gtk_new(dialog, "Ouverture du fichier", win,Action_Open);
				Chooser:=+dialog;
			--Initialisation de la structure
				OuvrirFic.page := GestionOnglet.page;
				OuvrirFic.Chr := Chooser;
				OuvrirFic.GestionOnglet := GestionOnglet;
				Set_Name(filtre,"Fichier algo");
				filtre.Add_Pattern("*.alg");
				Set_Extra_Widget(Chooser,btnValider);
				bool := Set_Current_Folder(Chooser,lienFichierDefaut);
				Add_Filter(Chooser,filtre);
				Connect(btnValider,"clicked",OuvrirFichier'ACCESS,OuvrirFic);
				Connect(btnValider,"clicked",FermerDialog'ACCESS,dialog);		
			--Affichage					 
				dialog.Show;
		END Ouvrir;
	
	--Compiler
	--Prend en parametre une page
	--Permet de compiler, faire la conversion
		PROCEDURE Compiler(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
			bufferAda, bufferLexique, bufferErreur : Gtk_Text_Buffer;
			start_iter, start_iterLexique , startDebug: Gtk_Text_Iter;
			start_iterAda : Gtk_Text_Iter;
			end_IterAda , end_iterLexique, endDebug: Gtk_Text_Iter;
			end_iter : Gtk_Text_Iter;
			i : Integer;
			result : chaine;
			resultString : string(1..100000);
			l_result : integer;
			resBloc: T_Tab_Bloc;
			listeLigne : T_TAB_LIGNE;
			code :chaine;			
			monCode: T_Tab_ligne;

			aReussi : boolean;
			resultat:chaine;
		BEGIN
			i := Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1;
			Gtk_New(buffer);
			buffer := Get_Buffer(page.zoneCode(i));
			bufferAda := Get_Buffer(page.zoneAda(i));
			bufferLexique := Get_Buffer(page.zoneVariable(i));
			bufferErreur:= Get_Buffer(page.zoneDebug(i));


			Get_Start_Iter(bufferLexique,start_iterLexique);
			Get_End_Iter(bufferLexique,end_iterLexique);

			Get_Start_Iter(buffer,startDebug);
			Get_End_Iter(buffer,endDebug);

			Get_Start_Iter(buffer,start_iter);
			Get_End_Iter(buffer,end_iter);
			Get_Start_Iter(bufferAda,start_iterAda);
			Get_End_Iter(bufferada,end_iterAda);

			generer("Juste un test(", Get_Text(bufferLexique,start_iterLexique,end_iterLexique,TRUE),Get_Text(buffer,start_iter,end_iter,TRUE),resultat, aReussi);

		toString(resultat, resultString, l_result);

			Set_Text(bufferErreur," ");
			Set_Text(bufferAda," ");
			if (aReussi) then
				Set_Text(bufferAda,resultString(1..l_result));
			else
				Set_Text(bufferErreur,resultString(1..l_result));
			end if;
		END Compiler;
	
	
--*****************CODE SOURCE DU PROGRAMME*****************--
BEGIN 
Init ; -- Initialisation de la gtk
--Initialisation de tab sauvegarde
	for I in 1..5  loop
		sauvegarde(i) := FALSE;
	end loop;
	pageSauv.page := page;
	pageSauv.pointeurSauv := new tab_bool'(sauvegarde);--Pointeur sur la tab sauvegarde
--Initialisation structure pour gestion onglet
	GestionOnglet.page := page;
	for I in 1..5  loop
		ongletDispo(i) := TRUE;
	end loop;
	ongletDispo(1) := FALSE;
	GestionOnglet.pointeur := new tab_bool'(ongletDispo);--Pointeur sur GestionOnglet
	GestionOnglet.btn := Outil.btnEnregistrer;
	GestionOnglet.pointeurSauv := new tab_bool'(sauvegarde);--Pointeur sur la tab sauvegarde
--Initialisation de la fenetre demarrage
	--Fenetre demarrage
   	Gtk_New(fenetreDemarrage,Window_Popup);
	fenetreDemarrage.set_default_size(500,250);
	fenetreDemarrage.set_position(Win_Pos_Center);
	--Table de stockage de démarrage des différentes parties
	Gtk_New(TableDemarrage,9,11,True);
	fenetreDemarrage.Add(TableDemarrage);
	--Labels
	Gtk_new(nom1,"Cindy binder");
	Gtk_new(nom2,"Matthieu Clin");
	Gtk_new(nom3,"Quentin vecchio");
	Gtk_new(nom4,"Nicolas Weissenbach");
	Gtk_new(nomProg,"AlgoAda 2013");
	TableDemarrage.attach(nomProg,1,10,1,2);
	TableDemarrage.attach(nom1,6,10,2,3);
	TableDemarrage.attach(nom2,6,10,3,4);
	TableDemarrage.attach(nom3,6,10,4,5);
	TableDemarrage.attach(nom4,6,10,5,6);
	--Image
	Gtk_New(image,"logo/logo.png");
	TableDemarrage.attach(image,1,5,2,5);
	--Barre chargement
	--Gtk_New(btnPasser,"Lancer le programme");
	--Affichage de la fenetre demarrage		
	tps := Clock;
	n := Second(tps);
	t := -1;
	--Lancement du programme 		
 	--while Get_Fraction(chargement) /= 0.2 loop		
		--if Second(tps) /= n+5 then
			--tps := Clock;
			--if t /= Second(tps) then
				--t:= Second(tps);
				--Set_Text(chargement,Integer'Image((Second(tps)-n+1)*20) & "%");		
				--Set_Fraction(chargement,Get_Fraction(chargement) + 0.2);				
			--end if;
		--end if;
	--end loop;
	--fenetreDemarrage.Show_all;
--Initialisation de la fenetre principale
	--Initialisation de la structure pour fermer l'appli
   	Gtk_New(fenetrePrincipale,Window_Toplevel);
   	fenetrePrincipale.Set_Title("AlgoAda");
	icone := fenetrePrincipale.Set_Icon_From_File("logo/logo.png");
   	fenetrePrincipale.set_default_size(Get_Width(Get_Default),Get_Height(Get_Default));--Taille adapter à l'écran
   	Connect(fenetrePrincipale, "destroy",Stop_Program'ACCESS);--Fonction quitter
	Set_Rgb(couleurFenetrePrincipal,45796,45796,45796);--Couleur principal de la fenetre
	modify_bg(fenetrePrincipale,State_Normal,couleurFenetrePrincipal); 
--Initialisation de la table
	Gtk_New(Table,18,16,True);--Table de stockage des différentes parties
	fenetrePrincipale.Add(table);

--Ajout du menu
	table.attach(Menu.barreMenu,0,16,0,1);

--Ajout de la barre de tache
	table.attach(Outil.barreOutil,0,16,0,1);
	
--Ajout du box Central
	--Création de la barre Aide
		table.attach(OutilAlgo.barreOutil,0,1,2,18);
	--Zone central						
		Table.attach(page.onglet,1,16,1,17);
--Initialisations des fonctions de boutons	
	--Bouton de la barre d'outil
	Connect(Outil.btnNouveau, "clicked",NouveauFichier'ACCESS, GestionOnglet);
	Connect(Outil.btnEnregistrer, "clicked",Enregistrer'ACCESS, pageSauv);
	Connect(Outil.btnOuvrir, "clicked",Ouvrir'ACCESS,GestionOnglet);

	--bouton page
	FOR I in 1..5 LOOP	
		Connect(page.btnFermer(I), "clicked",FermerFichier'ACCESS,GestionOnglet);
		Connect(page.btnIn(I), "clicked",AjoutIn'ACCESS,page);
		Connect(page.btnOut(I), "clicked",AjoutOut'ACCESS,page);
		Connect(page.btnAdaEnregistrer(I), "clicked",EnregistrerAda'ACCESS,page);
	END LOOP;

	--Bouton de la barre d'aide algo
	Connect(Outil.btnCompiler, "clicked",Compiler'ACCESS,page);
	Connect(OutilAlgo.btnSi, "clicked",AjoutSi'ACCESS,page);
	Connect(OutilAlgo.btnSinonSi, "clicked",AjoutSinonSi'ACCESS,page);
	Connect(OutilAlgo.btnSinon, "clicked",AjoutSinon'ACCESS,page);
	Connect(OutilAlgo.btnPour, "clicked",AjoutPour'ACCESS,page);
	Connect(OutilAlgo.btnTantQue, "clicked",AjoutTantQue'ACCESS,page);
	Connect(OutilAlgo.btnRepeter, "clicked",AjoutRepeter'ACCESS,page);
	Connect(OutilAlgo.btnEcrire, "clicked",AjoutEcrire'ACCESS,page);
	Connect(OutilAlgo.btnLire, "clicked",AjoutLire'ACCESS,page);
	Connect(OutilAlgo.btnEntier, "clicked",AjoutEntier'ACCESS,page);
	Connect(OutilAlgo.btnReel, "clicked",AjoutReel'ACCESS,page);
	Connect(OutilAlgo.btnCaractere, "clicked",AjoutCaractere'ACCESS,page);
	Connect(OutilAlgo.btnChaine, "clicked",AjoutChaine'ACCESS,page);
	Connect(OutilAlgo.btnBool, "clicked",AjoutBool'ACCESS,page);	
	--bouton menu
	Connect(menu.m_Nouveau, "activate",NouveauFichier'ACCESS,GestionOnglet);
	Connect(menu.m_Ouvrir, "activate",Ouvrir'ACCESS,GestionOnglet);
	Connect(menu.m_Enregistrer, "activate",Enregistrer'ACCESS,pageSauv);
	--Connect(menu.m_EnregistrerSous, "activate",NouveauFichier'ACCESS,GestionOnglet);
	Connect(menu.m_lecture, "activate",Compiler'ACCESS,page);
	Connect(menu.m_Quitter, "activate",Stop_Program'ACCESS);
	Connect(menu.m_aPropos, "activate",AProposDE'ACCESS);
	Connect(menu.m_modeNormal, "activate",modeNormal'ACCESS,fenetrePrincipale);
	Connect(menu.m_modeEcran, "activate",modeEcran'ACCESS,fenetrePrincipale);
--Affichage de la fenetre principale
	fenetrePrincipale.Show_All;
	Main;
	

END application ;

