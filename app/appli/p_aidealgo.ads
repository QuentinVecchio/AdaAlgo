--******************************************************************************--
--	Code source Application AlgoAda Projet Universitaire IUT de Metz	--
--	Developpeur : Quentin Vecchio Date modif : 20 juin 2013			--
--	Code Source p_aidealgo.adb	 Gere la barre d'outil	algo		--
--	Package									--
--******************************************************************************--

--Importations des packages
--Package Gtk
WITH Gtk.ToolBar;	USE Gtk.ToolBar;
WITH Gtk.Image;		USE Gtk.Image;
WITH Gtk.Button ;       USE Gtk.Button ;
WITH Gdk.Color;		USE Gdk.Color;
WITH Gtk.Enums ;        USE Gtk.Enums ;
WITH  Gtk.Tooltips;	USE  Gtk.Tooltips;
WITH Ada.Finalization ; USE Ada.Finalization ;

--Déclaration du package
PACKAGE P_aideAlgo IS

--Définition de la structure barreAideAlgo
	TYPE T_BarreAideAlgo IS NEW Controlled WITH RECORD
		--Barre Outils		
			barreOutil : Gtk_ToolBar;
		--Boutons		
			btnSi : Gtk_Button;
			btnSinonSi : Gtk_Button; 
			btnSinon : Gtk_Button;
			btnPour : Gtk_Button;
			btnTantQue : Gtk_Button;
			btnRepeter : Gtk_Button;
			btnEcrire : Gtk_Button;
			btnLire : Gtk_Button;
			btnEntier : Gtk_Button;
			btnReel : Gtk_Button;
			btnCaractere : Gtk_Button;
			btnChaine : Gtk_Button;
			btnBool : Gtk_Button;
		--Couleur
			couleurBarreOutil : Gdk_Color;
		--aide
			aide : Gtk_Tooltips;
	END RECORD;

--Constructeur de la structure
	PROCEDURE Initialize(B : IN OUT T_BarreAideAlgo);
END P_aideAlgo;
