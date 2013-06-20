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
WITH Gtk.Separator;	USE Gtk.Separator;
WITH Pango;		USE Pango;
WITH Ada.Finalization ; USE Ada.Finalization ;

--WITH Ada.Finalization ; USE Ada.Finalization ;

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
		Gtk_New(P.Table(i),16,12,True);
	--Box
		Gtk_New_HBox(P.Boite(i),false,2) ;
	--Barre de défilement
		Gtk_New(P.ajust,1.0,1.0,1.0,1.0,1.0,0.0);
		Gtk_New(P.barre1,null,P.ajust);
		Gtk_New(P.barre2,null,P.ajust);
		Gtk_New(P.barre3,null,P.ajust);
		Gtk_New(P.barre4,null,P.ajust);
	--Separateur
                Gtk_New_Vseparator(P.separateur(i));
	--Zone de saisie
		Gtk_New(P.zoneCode(i));
		Gtk_New(P.zoneVariable(i));
		Gtk_New(P.zoneAda(i));
		Gtk_New(P.zoneDebug(i));
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
		modify_bg(P.zoneCode(i),State_Normal,P.couleur);
		modify_bg(P.zoneVariable(i),State_Normal,P.couleur);
		modify_bg(P.zoneAda(i),State_Normal,P.couleur);
		modify_bg(P.zoneDebug(i),State_Normal,P.couleur);
		Set_Wrap_Mode(P.zoneCode(i),Wrap_Word);
		Set_Wrap_Mode(P.zoneVariable(i),Wrap_Word);
		Set_Wrap_Mode(P.zoneAda(i),Wrap_Word);
		Add_With_Viewport(P.barre1,P.zoneCode(i));
		Add_With_Viewport(P.barre2,P.zoneVariable(i));
		Add_With_Viewport(P.barre3,P.zoneAda(i));
		Add_With_Viewport(P.barre4,P.zoneDebug(i));
		Set_Editable(P.zoneAda(i),FALSE);
		Set_Editable(P.zoneDebug(i),FALSE);
		P.Table(i).attach(P.barre1,0,4,1,12);
		P.Table(i).attach(P.barre2,4,6,1,12);
		P.Table(i).attach(P.barre3,8,12,1,13);
		P.Table(i).attach(P.separateur(i),6,8,0,16);
		P.Table(i).attach(P.barre4,0,6,13,16);
	--label d'info
		Gtk_New(P.labelCode(i),"<span foreground = 'white'>Algorithme</span>");
		Gtk_New(P.labelVariable(i),"<span foreground = 'white'>Variables</span>");
		Gtk_New(P.labelAda(i),"<span foreground = 'white'>Conversion Ada</span>");
		Gtk_New(P.labelDebug(i),"<span foreground = 'white'>Deboggeur</span>");	
		Set_Use_Markup(P.labelCode(i),TRUE);
		Set_Use_Markup(P.labelVariable(i),TRUE);
		Set_Use_Markup(P.labelAda(i),TRUE);
		Set_Use_Markup(P.labelDebug(i),TRUE);
		P.Table(i).attach(P.labelCode(i),0,4,0,1);
		P.Table(i).attach(P.labelVariable(i),4,6,0,1);
		P.Table(i).attach(P.labelAda(i),8,12,0,1);
		P.Table(i).attach(P.labelDebug(i),0,2,12,13);		
	--Label
		Gtk_New(P.labelTitre(i),"<span foreground = 'black'>Nouveau"& Integer'Image(i) & ".alg</span>");
		Set_Use_Markup(P.labelTitre(i),TRUE);
	--Bouton
		Gtk_New(P.btnFermer(i));
		Gtk_New(P.imageFermer,"logo/croixFermer.png");
		Set_Image(P.btnFermer(i),P.imageFermer);
		Set_Size_Request(P.btnFermer(i),20,20);
		Set_Relief(P.btnFermer(i),Relief_None);
	--Bouton ada
		Gtk_New(P.btnAdaEnregistrer(i),"Enregistrer");
		P.Table(i).attach(P.btnAdaEnregistrer(i),9,11,14,15);
	--T_Label Onglet
		P.Boite(i).Pack_Start(P.labelTitre(i)) ;
   		P.Boite(i).Pack_Start(P.btnFermer(i)) ; 
		show_all(P.Boite(i));
	--Ajout des onglets
		Append_Page(P.onglet,P.Table(i),P.Boite(i));
		Set_No_Show_All(P.Table(i),TRUE);
		Set_No_Show_All(P.Boite(i),TRUE);		
		END LOOP;
		Set_No_Show_All(P.Table(1),FALSE);
		Set_No_Show_All(P.Boite(1),FALSE);
	END Initialize;
END P_Page;
