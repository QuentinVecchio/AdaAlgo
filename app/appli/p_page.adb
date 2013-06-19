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
		Gtk_New(P.Table(i),20,32,True);
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
		P.Table(i).attach(P.barre1,1,15,1,15);
		P.Table(i).attach(P.barre2,16,20,1,15);
		P.Table(i).attach(P.separateur(i),20,22,1,19);
		P.Table(i).attach(P.barre3,22,31,1,15);
		P.Table(i).attach(P.barre4,1,20,16,19);
	--label d'info
		Gtk_New(P.labelCode(i),"<span foreground = 'white'>Algorithme</span>");
		Gtk_New(P.labelVariable(i),"<span foreground = 'white'>Variables</span>");
		Gtk_New(P.labelAda(i),"<span foreground = 'white'>Conversion Ada</span>");
		Gtk_New(P.labelDebug(i),"<span foreground = 'white'>Deboggeur</span>");	
		Set_Use_Markup(P.labelCode(i),TRUE);
		Set_Use_Markup(P.labelVariable(i),TRUE);
		Set_Use_Markup(P.labelAda(i),TRUE);
		Set_Use_Markup(P.labelDebug(i),TRUE);
		P.Table(i).attach(P.labelCode(i),1,15,15,16);
		P.Table(i).attach(P.labelVariable(i),16,20,15,16);
		P.Table(i).attach(P.labelAda(i),22,31,15,16);
		P.Table(i).attach(P.labelDebug(i),1,4,15,16);		
	--Label
		Gtk_New(P.labelTitre(i),"<span foreground = 'black'>Nouveau"& Integer'Image(i) & ".alg</span>");
		Set_Use_Markup(P.labelTitre(i),TRUE);
	--Bouton
		Gtk_New(P.btnFermer(i));
		Gtk_New(P.imageFermer,"logo/croixFermer.png");
		Set_Image(P.btnFermer(i),P.imageFermer);
		P.Table(i).attach(P.btnFermer(i),31,32,0,1);
		END LOOP;	
		Append_Page(P.onglet,P.Table(1),P.labelTitre(1));
		Append_Page(P.onglet,P.Table(2),P.labelTitre(2));
	END Initialize;	
END P_Page;
