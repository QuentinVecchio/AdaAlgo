WITH SIMPLE_IO;		USE SIMPLE_IO; 
WITH Gtk.Main ;      	USE Gtk.Main ;
WITH Gtk.Widget ;     	USE Gtk.Widget ; 
WITH Gtk.Window ;       USE Gtk.Window ;
WITH Gtk.Enums ;        USE Gtk.Enums ;
WITH Gtk.Button ;       USE Gtk.Button ;
WITH Gtk.Table;		USE Gtk.Table;
WITH Gtk.Bin ;          USE Gtk.Bin ;
WITH Gtk.Text_View;	USE Gtk.Text_View;
WITH Gtk.Text_Buffer;	USE Gtk.Text_Buffer;
WITH Gtk.Text_Iter; 	USE Gtk.Text_Iter;
WITH Gtk.Label;		USE Gtk.Label;
WITh Gdk.Color;		USE Gdk.Color;
WITH Gdk.Visual;	USE Gdk.Visual;
WITH Gtk.Handlers ;


PROCEDURE MaFenetre IS
--*****************INITIALISATIONS DES VARIABLES ET SS-PGMES*****************--
--VARIABLES
	--Fenetre
		fenetrePrincipale : Gtk_Window;
	--Table	
		Table : Gtk_Table;
	--Zone de saisie
		zoneCode : Gtk_Text_View;
		zoneVariable : Gtk_Text_View;
	--label
		label1 : Gtk_Label;
		label2 : Gtk_Label;
	--Bouton de compilation
		 btnCompiler : Gtk_Button;
	--Couleur
		color : Gdk_Color;
--FONCTIONS

--SIGNALS
	--Quitter
		PACKAGE P_Callback IS NEW Gtk.Handlers.Callback(Gtk_Widget_Record) ;
		USE P_Callback ;
	
		PROCEDURE Stop_Program(Emetteur : access Gtk_Widget_Record'class) IS
   			PRAGMA Unreferenced (Emetteur);
		BEGIN
   			Main_Quit;
		END Stop_Program ;
	--Compiler
		PACKAGE P_CallbackCompiler IS NEW Gtk.Handlers.User_Callback(Gtk_Widget_Record,Gtk_Text_View) ;
		USE P_callbackCompiler ;
	
		PROCEDURE Compiler(Emetteur :  access Gtk_Widget_Record'class; Text : Gtk_text_View) IS
			PRAGMA Unreferenced (Emetteur);
			buffer : Gtk_Text_Buffer;
			start_iter : Gtk_Text_Iter;
			end_iter : Gtk_Text_Iter;
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(Text);
			Get_Start_Iter(buffer,start_iter);
			Get_End_Iter(buffer,end_iter); 
   			PUT_LINE(Get_Text(buffer,start_Iter,end_Iter,TRUE));
		END Compiler;
		
--*****************CODE SOURCE*****************--
BEGIN
   	Init ;
--Initialisation de la fenetre principale
   	Gtk_New(fenetrePrincipale,Window_Toplevel);
   	fenetrePrincipale.Set_Title("Fenetre");
   	fenetrePrincipale.set_default_size(500,400);
   	Connect(fenetrePrincipale, "destroy",Stop_Program'ACCESS);
--Initialisation de la table
	Gtk_New(Table,8,8,True);
	fenetrePrincipale.Add(table);
--Initialisation du box Label
	Gtk_New(label1,"Code Source"); Table.attach(label1,1,5,0,1);
	Gtk_New(label2,"Variables"); Table.attach(label2,6,7,0,1);
--Initialisation du box Central
	--Zone de Code
		Gtk_New(zoneCode); Table.attach(zoneCode,1,5,1,6);
		Set_Rgb(color,36864,36864,36864);
		modify_bg(fenetrePrincipale,State_Normal,color); 
	--Zone de variables
		Gtk_New(zoneVariable); Table.attach(zoneVariable,6,7,1,6);
--Initialisation du bas de page
	Gtk_New(btnCompiler,"Compiler"); Table.attach(btnCompiler,0,8,7,8);
	Connect(BtnCompiler, "clicked",Compiler'ACCESS, zoneCode) ;
--Affichage de la fenetre   	
	fenetrePrincipale.Show_all ;
   	Main ;
END MaFenetre ;

