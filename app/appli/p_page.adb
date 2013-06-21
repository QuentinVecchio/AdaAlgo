--******************************************************************************--
--	Code source Application AlgoAda Projet Universitaire IUT de Metz	--
--	Developpeur : Quentin Vecchio Date modif : 20 juin 2013			--
--	Code Source p_page.adb	gere la page de l'application			--
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
WITH Ada.Finalization ; USE Ada.Finalization ;

--Déclaration du corp du package
PACKAGE BODY P_Page IS
	PROCEDURE Initialize(P : IN OUT T_Page) IS	
	BEGIN
	--Couleur
		Set_Rgb(P.couleur,0,0,0);
		Set_Rgb(P.couleur2,15129,15376,19600);
	--Onglet
		Gtk_New(P.onglet);
		modify_bg(P.onglet,State_Normal,P.couleur2);	
		FOR I in 1..5 LOOP
		--table Principale
			Gtk_New(P.Table(i),10,12,True);
		--Table Bouton
			Gtk_New(P.TableBouton(i),1,2,True);
		--Box
			Gtk_New_HBox(P.Boite(i),false,2) ;
		--Barre de défilement
			Gtk_New(P.ajust1,1.0,1.0,1.0,1.0,1.0,0.0);
			Gtk_New(P.ajust2,1.0,1.0,1.0,1.0,1.0,0.0);
			Gtk_New(P.ajust3,1.0,1.0,1.0,1.0,1.0,0.0);
			Gtk_New(P.ajust4,1.0,1.0,1.0,1.0,1.0,0.0);
			Gtk_New(P.ajust5,1.0,1.0,1.0,1.0,1.0,0.0);
			Gtk_New(P.barre1,null,P.ajust1);
			Gtk_New(P.barre2,null,P.ajust2);
			Gtk_New(P.barre3,null,P.ajust3);
			Gtk_New(P.barre4,null,P.ajust4);
			Gtk_New(P.barre5,null,P.ajust5);
		--Separateur
        	        Gtk_New_Vseparator(P.separateur(i));
		--Zone de saisie
			--Création des zones
			Gtk_New(P.zoneCode(i));
			Gtk_New(P.zoneVariable(i));
			Gtk_New(P.zoneAda(i));
			Gtk_New(P.zoneDebug(i));
			Gtk_New(P.zoneFct(i));
			--Modification des bordures
			Set_Border_Window_Size(P.zoneCode(i),Text_Window_Right,1);
			Set_Border_Window_Size(P.zoneCode(i),Text_Window_Left,1);
			Set_Border_Window_Size(P.zoneCode(i),Text_Window_Top,1);
			Set_Border_Window_Size(P.zoneCode(i),Text_Window_Bottom,1);
			Set_Border_Window_Size(P.zoneVariable(i),Text_Window_Right,1);
			Set_Border_Window_Size(P.zoneVariable(i),Text_Window_Left,1);
			Set_Border_Window_Size(P.zoneVariable(i),Text_Window_Top,1);
			Set_Border_Window_Size(P.zoneVariable(i),Text_Window_Bottom,1);
			Set_Border_Window_Size(P.zoneAda(i),Text_Window_Right,1);
			Set_Border_Window_Size(P.zoneAda(i),Text_Window_Left,1);
			Set_Border_Window_Size(P.zoneAda(i),Text_Window_Top,1);
			Set_Border_Window_Size(P.zoneAda(i),Text_Window_Bottom,1);
			Set_Border_Window_Size(P.zoneDebug(i),Text_Window_Right,1);
			Set_Border_Window_Size(P.zoneDebug(i),Text_Window_Left,1);
			Set_Border_Window_Size(P.zoneDebug(i),Text_Window_Top,1);
			Set_Border_Window_Size(P.zoneDebug(i),Text_Window_Bottom,1);
			Set_Border_Window_Size(P.zoneFct(i),Text_Window_Right,1);
			Set_Border_Window_Size(P.zoneFct(i),Text_Window_Left,1);
			Set_Border_Window_Size(P.zoneFct(i),Text_Window_Top,1);
			Set_Border_Window_Size(P.zoneFct(i),Text_Window_Bottom,1);
			--Modification de la couleurs des bordures
			modify_bg(P.zoneCode(i),State_Normal,P.couleur);
			modify_bg(P.zoneVariable(i),State_Normal,P.couleur);
			modify_bg(P.zoneAda(i),State_Normal,P.couleur);
			modify_bg(P.zoneDebug(i),State_Normal,P.couleur);
			modify_bg(P.zoneFct(i),State_Normal,P.couleur);
			--Permet le retour à la ligne quand le texte est trop long
			Set_Wrap_Mode(P.zoneCode(i),Wrap_Word);
			Set_Wrap_Mode(P.zoneVariable(i),Wrap_Word);
			Set_Wrap_Mode(P.zoneAda(i),Wrap_Word);
			Set_Wrap_Mode(P.zoneFct(i),Wrap_Word);
			--Ajout de barre de défilement aux zones de saisies
			Add_With_Viewport(P.barre1,P.zoneCode(i));
			Add_With_Viewport(P.barre2,P.zoneVariable(i));
			Add_With_Viewport(P.barre3,P.zoneAda(i));
			Add_With_Viewport(P.barre4,P.zoneDebug(i));
			Add_With_Viewport(P.barre5,P.zoneFct(i));
			--Ajout de la non-modification aux zone d'ada et deboggage
			Set_Editable(P.zoneAda(i),FALSE);
			Set_Editable(P.zoneDebug(i),FALSE);
			--Ajout des éléments dans la table
			P.Table(i).attach(P.barre5,0,5,0,1);
			P.Table(i).attach(P.barre1,0,4,1,7);
			P.Table(i).attach(P.barre2,4,6,1,7);
			P.Table(i).attach(P.barre3,8,11,1,8);
			P.Table(i).attach(P.separateur(i),6,8,0,10);
			P.Table(i).attach(P.barre4,0,6,8,10);
		--label d'info
			Gtk_New(P.labelAda(i),"<span foreground = 'white'>Conversion Ada</span>");
			Gtk_New(P.labelDebug(i),"<span foreground = 'white'>Deboggeur</span>");	
			Set_Use_Markup(P.labelAda(i),TRUE);
			Set_Use_Markup(P.labelDebug(i),TRUE);
			P.Table(i).attach(P.labelAda(i),8,11,0,1);
			P.Table(i).attach(P.labelDebug(i),0,2,7,8);		
		--Label
			Gtk_New(P.labelTitre(i),"<span foreground = 'black'>Nouveau"& Integer'Image(i) & ".alg</span>");
			Set_Use_Markup(P.labelTitre(i),TRUE);
		--Label ligne
			Gtk_New(P.labelNbLigne(i),"<span foreground = 'white'>Lignes 0</span>");
			Set_Use_Markup(P.labelNbLigne(i),TRUE);
			P.Table(i).attach(P.labelNbLigne(i),3,4,7,8);
		--Bouton IN OUT
			Gtk_New(P.btnIn(i),"↓");
			Gtk_New(P.btnOut(i),"↑");
			P.TableBouton(i).attach(P.btnIn(i),0,1,0,1);
			P.TableBouton(i).attach(P.btnOut(i),0,1,1,2);
			P.Table(i).attach(P.TableBouton(i),5,6,0,1);
		--Bouton Fermer
			Gtk_New(P.btnFermer(i));
			Gtk_New(P.imageFermer,"logo/croixFermer.png");
			Set_Image(P.btnFermer(i),P.imageFermer);
			Set_Size_Request(P.btnFermer(i),20,20);
			Set_Relief(P.btnFermer(i),Relief_None);
		--Bouton ada Enregistrer
			Gtk_New(P.btnAdaEnregistrer(i),"Enregistrer");
			P.Table(i).attach(P.btnAdaEnregistrer(i),10,11,8,9);
		--Bouton ada compiler
			Gtk_New(P.btnCompilerAda(i),"Compiler");
			P.Table(i).attach(P.btnCompilerAda(i),8,10,8,9);	
		--T_Label Onglet
			P.Boite(i).Pack_Start(P.labelTitre(i)) ;
   			P.Boite(i).Pack_Start(P.btnFermer(i)) ; 
			show_all(P.Boite(i));
		--Ajout des onglets et on les rends invisible
			Append_Page(P.onglet,P.Table(i),P.Boite(i));
			Set_No_Show_All(P.Table(i),TRUE);
			Set_No_Show_All(P.Boite(i),TRUE);
			Connect(P.zoneCode(i), "insert_at_cursor",ColorationSyntaxique'ACCESS,P.zoneCode(i));--Connection d'un signal permettant la coloration syntaxique		
		END LOOP;
		--On rend visible l'onglet 1
			Set_No_Show_All(P.Table(1),FALSE);
			Set_No_Show_All(P.Boite(1),FALSE);
	END Initialize;

--Fonction qui colore le texte
	PROCEDURE ColorationSyntaxique(Emetteur :  access Gtk_Widget_Record'class; Texte : Gtk_Text_View) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
			start_iter : Gtk_Text_Iter;
			end_iter : Gtk_Text_Iter;
	BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(Texte);
			Get_Start_Iter(buffer,start_iter);
			Get_End_Iter(buffer,end_iter);
			PUT_LINE("test");
			PUT_LINE(Get_Text(buffer,start_iter,end_iter));
	END ColorationSyntaxique;
END P_Page;
