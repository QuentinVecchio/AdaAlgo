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
WITH Ada.Finalization ; USE Ada.Finalization ;

--WITH Ada.Finalization ; USE Ada.Finalization ;

PACKAGE BODY P_Page IS
	PROCEDURE Initialize(P : IN OUT T_Page) IS
		test : Gdk_Color;
	BEGIN	
		Set_Rgb(test,0,0,0);
		FOR I in 1..5 LOOP
	--table Principale
		Gtk_New(P.Table(i),20,32,True);
	--Barre de défilement
		Gtk_New(P.ajust,1.0,1.0,1.0,1.0,1.0,0.0);
		Gtk_New(P.barre,null,P.ajust);
		
	--Zone de saisie
		Gtk_New(P.zoneCode(i));
		Gtk_New(P.zoneVariable(i));
		Set_Border_Window_Size(P.zoneCode(i),Text_Window_Right,1);
		Set_Border_Window_Size(P.zoneCode(i),Text_Window_Left,1);
		Set_Border_Window_Size(P.zoneCode(i),Text_Window_Top,1);
		Set_Border_Window_Size(P.zoneCode(i),Text_Window_Bottom,1);
		Set_Border_Window_Size(P.zoneVariable(i),Text_Window_Right,1);
		Set_Border_Window_Size(P.zoneVariable(i),Text_Window_Left,1);
		Set_Border_Window_Size(P.zoneVariable(i),Text_Window_Top,1);
		Set_Border_Window_Size(P.zoneVariable(i),Text_Window_Bottom,1);
		modify_bg(P.zoneCode(i),State_Normal,test);
		modify_bg(P.zoneVariable(i),State_Normal,test);
		Set_Wrap_Mode(P.zoneCode(i),Wrap_Word);
		Set_Wrap_Mode(P.zoneVariable(i),Wrap_Word);
		Add_With_Viewport(P.barre,P.zoneCode(i));
		Add_With_Viewport(P.barre,P.zoneVariable(i));
		P.Table(i).attach(P.barre,1,25,1,19);
		P.Table(i).attach(P.zoneVariable(i),26,30,1,19);
	--Label
		Gtk_New(P.labelTitre(i),"Nouveau"& Integer'Image(i) & ".alg");
	--Bouton
		Gtk_New(P.btnFermer(i));
		Gtk_New(P.imageFermer,"logo/croixFermer.png");
		Set_Image(P.btnFermer(i),P.imageFermer);
		P.Table(i).attach(P.btnFermer(i),31,32,0,1);
		END LOOP;
	--Onglet
		Gtk_New(P.onglet);
		Append_Page(P.onglet,P.Table(1),P.labelTitre(1));
		Append_Page(P.onglet,P.Table(2),P.labelTitre(2));		
	END Initialize;	
END P_Page;
