--Packages ADA
WITH SIMPLE_IO;		USE SIMPLE_IO; 
--Packages GTK
WITH Gtk.Main ;      	USE Gtk.Main ;
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
--Mes Packages
WITH P_Menu;		USE P_Menu;
WITH P_BarreOutil;	USE P_BarreOutil;
WITH P_Page;		USE P_Page;
WITH P_aideAlgo;	USE P_aideAlgo;	
--Packages Compilation
with mstring;		use mstring;
with definitions; 	use definitions;
with gestionbloc; 	use gestionbloc;
with analyse; 		use analyse;
with conversion; 	use conversion;
with generateur;	use generateur;

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
	--TYPES
		type tab_dispo is array(1..5) of Boolean;
		type T_AjoutOnglet is record
			pag : T_Page;
			ong : Gtk_Notebook;		
		end record;
		paramPage : T_AjoutOnglet;
		type T_EnregFic is record
			texte : String(1..100000);
			variable : String(1..100000);
			iCode,iVariable : integer;
			Chr : GTK_File_Chooser; 		
		end record;
		ongletDispo : tab_dispo;
		Type T_Pointeur is access tab_dispo;
		type T_GestionOnglet is record
			page : T_Page;
			pointeur : T_Pointeur;
		end record;
		type T_OuvrirFic is record
			page : T_Page;
			Chr : GTK_File_Chooser;
			GestionOnglet : T_GestionOnglet;	
		end record;
		GestionOnglet : T_GestionOnglet;

--*****************INITIALISATIONS DES FONCTIONS*****************-- 
	--Procedure a Matthieu
	PROCEDURE labeltoStr(entree: in out chaine; sortie: out T_Tab_ligne) IS
		i: integer;	
		tmp: chaine := entree;	
	BEGIN
		sortie := Creer_liste;
		while(contains(entree, ASCII.LF&ASCII.LF)) loop
				entree := replaceStr(entree, createchaine(ASCII.LF&ASCII.LF), createChaine(ASCII.LF));
		end loop;
		while(strpos(entree, ASCII.HT) /=0) loop
				entree := replaceStr(entree, createchaine(ASCII.HT), createChaine(' '));
		end loop;
		loop
			i := strpos(tmp, ASCII.LF);
			if(i /= 0)then
				if(i = length(tmp) or else i = 1)then
					exit;
				end if;
				Ajout_queue(sortie,substring(tmp, 1, i-1));
				tmp := substring(tmp, i+1, length(tmp));
			else
				Ajout_queue(sortie,tmp);
				i := 0;
			end if;
			exit when (i = 0);
		end loop;
		END labeltoStr;

	--Procedure a Matthieu
		PROCEDURE strtolabel(entree: in out T_Tab_ligne; sortie: in out chaine) IS
			tmp : chaine;
			FUNCTION donneHT(nb: integer) return chaine IS
				tmp: chaine := createchaine(' ');				
			BEGIN
				if(nb > 0)then
					tmp := createchaine(ASCII.HT);
					for I in 2..nb loop
						tmp := tmp + ASCII.HT;
					end loop;
				end if;
				return tmp;
			END donneHT;
			nbTab : integer := 0;
		BEGIN
			donne_tete(entree, sortie);
			enleve_enTete(entree);
			while(NOT estVide(entree))loop
				donne_tete(entree, tmp);
				enleve_enTete(entree);
				if(startwith(tmp, "when") or else startwith(tmp, "end") or else startwith(tmp, "elsif") 
				or else startwith(tmp, "else"))then
					nbTab := nbTab -1;
				end if;
				sortie := sortie+ASCII.LF+donneHT(nbTab)+tmp;
				
				if(startwith(tmp, "switch") or else startwith(tmp, "when") or else startwith(tmp, "if") 
				or else startwith(tmp, "elsif") or else startwith(tmp, "else") or else startwith(tmp, "for") 
				or else startwith(tmp, "while") or else startwith(tmp, "loop")	or else startwith(tmp, "swith"))then
						nbTab := nbTab +1;
				end if;
			end loop;
		END strtolabel;
			
--********************INIT SIGNAUX*************************************--
	--Nouveau package pour les signaux perso	
	PACKAGE P_Callback IS NEW Gtk.Handlers.Callback(Gtk_Widget_Record) ;
	USE P_Callback ;

	PACKAGE P_CallbackAjout  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,T_AjoutOnglet) ;
	USE P_CallbackAjout;
	
	PACKAGE P_CallbackPage IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,T_Page) ;
	USE P_CallbackPage;
	
	PACKAGE P_CallbackNoteBook IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,Gtk_Notebook) ;	
	USE P_CallbackNoteBook;
		
	PACKAGE P_CallbackTV  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,Gtk_Text_View) ;
	USE P_CallbackTV;

	PACKAGE P_CallbackGestionOnglet  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,T_GestionOnglet) ;
	USE P_CallbackGestionOnglet;

	PACKAGE P_CallbackEnreg  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,T_EnregFic) ;
	USE P_CallbackEnreg;

	PACKAGE P_CallbackFermerDialog  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,GTK_File_Chooser_Dialog) ;
	USE P_CallbackFermerDialog;

	PACKAGE P_CallbackOuvrir  IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,T_OuvrirFic) ;
	USE P_CallbackOuvrir;

	--Quitter
		PROCEDURE Stop_Program(Emetteur : access Gtk_Widget_Record'class) IS
   			PRAGMA Unreferenced (Emetteur);
		BEGIN
   			Main_Quit;
		END Stop_Program ;

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
				Grab_Focus(GestionOnglet.page.zoneCode(n));
			end if;
		END NouveauFichier;


	--Fermer Onglet
		PROCEDURE FermerFichier(Emetteur :  access Gtk_Widget_Record'class; GestionOnglet :  T_GestionOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			n : Integer;
			bufferCode : Gtk_Text_Buffer;
			bufferAda : Gtk_Text_Buffer;
			bufferVariable : Gtk_Text_Buffer;
			bufferDebug : Gtk_Text_Buffer;
		BEGIN
			n := Integer'Value(Gint'Image(Get_Current_Page(GestionOnglet.page.onglet)))+1;
			Gtk_New(bufferCode);
			Gtk_New(bufferAda);
			Gtk_New(bufferVariable);
			Gtk_New(bufferDebug);
			bufferCode := Get_Buffer(GestionOnglet.page.zoneCode(n));
			bufferAda := Get_Buffer(GestionOnglet.page.zoneAda(n));
			bufferVariable := Get_Buffer(GestionOnglet.page.zoneVariable(n));
			bufferDebug := Get_Buffer(GestionOnglet.page.zoneDebug(n));
			Set_Text(bufferCode,"");
			Set_Text(bufferAda,"");
			Set_Text(bufferVariable,"");
			Set_Text(bufferDebug,"");			
			GestionOnglet.pointeur(n) := NOT GestionOnglet.pointeur(n);
			Set_No_Show_All(GestionOnglet.page.Table(n),TRUE);
			Set_No_Show_All(GestionOnglet.page.Boite(n),TRUE);
			Show_All(GestionOnglet.page.Table(n));
			Show_all(GestionOnglet.page.Boite(n));				
		END FermerFichier;
	--Enregistrer fichier
			PROCEDURE EnregistrerFichier(Emetteur :  access Gtk_Widget_Record'class; Enreg : T_EnregFic) IS
				PRAGMA Unreferenced (Emetteur);
				code: T_Tab_ligne;
				variable : T_Tab_ligne;
				ch1 : chaine;
				ch2 : chaine;
			BEGIN
				if Enreg.iCode /= 0 and Enreg.iVariable /= 0 then
					ch1 := createChaine(Enreg.texte(1..Enreg.iCode));
					ch2 := createChaine(Enreg.variable(1..Enreg.iVariable));
					labeltoStr(ch1, code);
					labeltoStr(ch2, variable);
					enregistrer(Get_Filename(Enreg.Chr),code,variable);
				end if;
			END EnregistrerFichier;

	--Fermer Dialog
			PROCEDURE FermerDialog(Emetteur :  access Gtk_Widget_Record'class; dialog : GTK_File_Chooser_Dialog) IS
				PRAGMA Unreferenced (Emetteur);
			BEGIN
				dialog.destroy;
			END FermerDialog;
	--Enregistrer
		PROCEDURE Enregistrer(Emetteur :  access Gtk_Widget_Record'class; page : T_Page) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
			bufferVariable : Gtk_Text_Buffer;
			start_iter : Gtk_Text_Iter;
			end_iter : Gtk_Text_Iter;
			start_iterVariable : Gtk_Text_Iter;
			end_iterVariable : Gtk_Text_Iter; 
			dialog  : GTK_File_Chooser_Dialog;
			Chooser : GTK_File_Chooser; 
			win : Gtk_Window;
			btnEnregistrer : Gtk_Button;
			EnregFic : T_EnregFic;
			n : Integer;
		BEGIN
			n := Integer'Value(Gint'Image(Get_Current_Page(page.onglet)))+1;
			
			--Recuperation du code
				Gtk_New(buffer);
				buffer := Get_Buffer(page.zoneCode(n));
				Get_Start_Iter(buffer,start_iter);
				Get_End_Iter(buffer,end_iter);
			--Recuperation des variables
				Gtk_New(bufferVariable);
				bufferVariable := Get_Buffer(page.zoneVariable(n));
				Get_Start_Iter(bufferVariable,start_iterVariable);
				Get_End_Iter(bufferVariable,end_iterVariable);
			--Initialisation de la structure
				EnregFic.texte(1..Integer'Value(Gint'Image(Get_Char_Count(buffer)))) := Get_Text(buffer,start_Iter,end_Iter,TRUE);
				EnregFic.iCode := Integer'Value(Gint'Image(Get_Char_Count(buffer)));
				EnregFic.iVariable := Integer'Value(Gint'Image(Get_Char_Count(bufferVariable)));
				EnregFic.variable(1..Integer'Value(Gint'Image(Get_Char_Count(bufferVariable)))) := Get_Text(bufferVariable,start_IterVariable,end_IterVariable,TRUE);
			--Initialisation de la boite de dialogue
				Gtk_New(btnEnregistrer,"Enregistrer"); 						
				Gtk_New(Win,Window_Toplevel);
				Gtk_new(dialog, "Sauvegarde du fichier", win,Action_Save);
				Chooser:=+dialog; 
				EnregFic.Chr := Chooser;
				Set_Current_Name(Chooser,"MonFichier.alg");
				Set_Extra_Widget(Chooser,btnEnregistrer);
			--Fonction Bouton
				Connect(btnEnregistrer,"clicked",EnregistrerFichier'ACCESS,EnregFic);
				Connect(btnEnregistrer,"clicked",FermerDialog'ACCESS,dialog);	
			--Affichage					 
				dialog.Show;
		END Enregistrer;

	--Ouvrir fichier
			PROCEDURE OuvrirFichier(Emetteur :  access Gtk_Widget_Record'class; Ouvrir : T_OuvrirFic) IS
				PRAGMA Unreferenced (Emetteur);
				n : Integer := 2;
				bufferCode : Gtk_Text_Buffer;
				bufferVariable : Gtk_Text_Buffer;
				code : T_Tab_ligne;
				variable : T_Tab_ligne;
				ch1,ch2 : chaine;
				s1,s2 : string(1..100000);
				n1,n2 : Integer;
			BEGIN
				--Recuperation d'un onglet libre
				FOR I in 1..5 LOOP
					if(Ouvrir.GestionOnglet.pointeur(i) = TRUE AND n = 0) then
						n := I;
					end if;
				END LOOP;
				
				--Recuperation du code et des variables
					generateur.ouvrir(Get_Filename(Ouvrir.Chr),code,variable);
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
				--Gestion Onglets	
					Set_No_Show_All(page.Table(n),FALSE);
					Set_No_Show_All(page.Boite(n),FALSE);
					Show_All(page.Table(n));
					Show_all(page.Boite(n));
					Ouvrir.GestionOnglet.pointeur(n) := NOT Ouvrir.GestionOnglet.pointeur(n);
					Grab_Focus(page.zoneCode(n));			
			END OuvrirFichier;

	--Ouvrir
		PROCEDURE Ouvrir(Emetteur :  access Gtk_Widget_Record'class; GestionOnglet : T_GestionOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			dialog  : GTK_File_Chooser_Dialog;
			Chooser : GTK_File_Chooser; 
			win : Gtk_Window;
			btnValider : Gtk_Button;
			OuvrirFic : T_OuvrirFic;
			filtre : Gtk_File_Filter;
		BEGIN
			--Initialisation de la boite de dialogue
				Gtk_New(filtre);
				Gtk_New(btnValider,"Ouvrir"); 						
				Gtk_New(Win,Window_Toplevel);
				Gtk_new(dialog, "Ouvertur du fichier", win,Action_Open);
				Chooser:=+dialog;
			--Initialisation de la structure
				OuvrirFic.page := GestionOnglet.page;
				OuvrirFic.Chr := Chooser;
				OuvrirFic.GestionOnglet := GestionOnglet;
				Set_Name(filtre,"Fichier algo");
				filtre.Add_Pattern("*.alg");
				Set_Extra_Widget(Chooser,btnValider);
				Add_Filter(Chooser,filtre);
				Connect(btnValider,"clicked",OuvrirFichier'ACCESS,OuvrirFic);
				Connect(btnValider,"clicked",FermerDialog'ACCESS,dialog);		
			--Affichage					 
				dialog.Show;
		END Ouvrir;
	--Compiler
		PROCEDURE Compiler(Emetteur :  access Gtk_Widget_Record'class; pageParam : T_AjoutOnglet) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
			bufferAda : Gtk_Text_Buffer;
			start_iter : Gtk_Text_Iter;
			start_iterAda : Gtk_Text_Iter;
			end_IterAda : Gtk_Text_Iter;
			end_iter : Gtk_Text_Iter;
			i : Integer;
			result : chaine;
			resultString : string(1..100000);
			l_result : integer;
			resBloc: T_Tab_Bloc;
			listeLigne : T_TAB_LIGNE;
			code :chaine;			
			monCode: T_Tab_ligne;
		BEGIN
			i := Integer'Value(Gint'Image(Get_Current_Page(pageParam.ong)))+1;
			Gtk_New(buffer);
			buffer := Get_Buffer(pageParam.pag.zoneCode(i));
			bufferAda := Get_Buffer(pageParam.pag.zoneAda(i));
			Get_Start_Iter(buffer,start_iter);
			Get_End_Iter(buffer,end_iter);
			Get_Start_Iter(bufferAda,start_iterAda);
			Get_End_Iter(bufferada,end_iterAda);
			code := createChaine(Get_Text(buffer,start_Iter,end_Iter,TRUE));
			labeltoStr(code, monCode);
			Analyse_Code(monCode, resBloc);
			conversionAda(resBloc, listeLigne);
			strtolabel(listeLigne, result);
			toString(result, resultString, l_result);
			Set_Text(bufferAda,resultString(1..l_result));
		END Compiler;
	
	
--*****************CODE SOURCE*****************--
BEGIN 
Init ;
--Initialisation structure pour gestion onglet
	GestionOnglet.page := page;
	for I in 1..5  loop
		ongletDispo(i) := TRUE;
	end loop;
	ongletDispo(1) := FALSE;
	GestionOnglet.pointeur := new tab_dispo'(ongletDispo);
--Initialisation de la fenetre principale
   	Gtk_New(fenetrePrincipale,Window_Toplevel);
   	fenetrePrincipale.Set_Title("AlgoAda");
   	fenetrePrincipale.set_default_size(Get_Width(Get_Default),Get_Height(Get_Default));
   	Connect(fenetrePrincipale, "destroy",Stop_Program'ACCESS);
	Set_Rgb(couleurFenetrePrincipal,45796,45796,45796);
	modify_bg(fenetrePrincipale,State_Normal,couleurFenetrePrincipal); 
--Initialisation de la table
	Gtk_New(Table,19,16,True);
	fenetrePrincipale.Add(table);
--Initialisation du menu
	table.attach(Menu.barreMenu,0,16,0,1);
--Initialisation de la barre de tache
	table.attach(Outil.barreOutil,0,16,0,1);	
--Initialisation du box Central
	--Création de la barre Aide
		table.attach(OutilAlgo.barreOutil,0,1,2,18);
	--Zone central						
		Table.attach(page.onglet,1,15,1,18);
 	paramPage.pag := page;
	paramPage.ong := page.onglet;
--Initialisations des fonctions de boutons
	fenetrePrincipale.Show_all ;
	--Bouton de la barre d'outil
	Connect(Outil.btnNouveau, "clicked",NouveauFichier'ACCESS, GestionOnglet);
	Connect(Outil.btnEnregistrer, "clicked",Enregistrer'ACCESS, page);
	Connect(Outil.btnOuvrir, "clicked",Ouvrir'ACCESS,GestionOnglet);
	--bouton fermer de page
	FOR I in 1..5 LOOP	
		Connect(page.btnFermer(I), "clicked",FermerFichier'ACCESS,GestionOnglet);
		
	END LOOP;
	--Bouton de la barre d'aide algo
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

