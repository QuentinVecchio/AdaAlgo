WITH Gtk.ToolBar;	USE Gtk.ToolBar;
WITH Gtk.Image;		USE Gtk.Image;
WITH Gtk.Button ;       USE Gtk.Button ;
WITH  Gtk.Tooltips;	USE  Gtk.Tooltips;
WITH Gdk.Color;		USE Gdk.Color;

PACKAGE BODY P_aideAlgo IS
	
	PROCEDURE Initialize(B : IN OUT T_BarreAideAlgo) IS
	BEGIN
	--aide
		Gtk_New(B.aide);
	--Création de la barre	
		Gtk_New(B.barreOutil);
		Set_Rgb(B.couleurBarreOutil,3136,1681,2916);
		Set_Orientation(B.barreOutil,Orientation_Vertical);				 	
	--Création du bouton Si
		Gtk_New(B.btnSi,"Si");
		Set_Tip(B.aide,B.btnSi,"Ajouter Si");
		Append_Widget(B.barreOutil,B.btnSi);
	--Création du bouton Sinon Si
		Gtk_New(B.btnSinonSi,"Sinon si");
		Set_Tip(B.aide,B.btnSinonSi,"Ajouter Sinon Si");
		Append_Widget(B.barreOutil,B.btnSinonSi);
	--Création du bouton Sinon
		Gtk_New(B.btnSinon,"Sinon");
		Set_Tip(B.aide,B.btnSinon,"Ajouter Sinon");
		Append_Widget(B.barreOutil,B.btnSinon);
		Append_Space(B.barreOutil);
	--Création du bouton Pour
		Gtk_New(B.btnPour,"Pour");
		Set_Tip(B.aide,B.btnPour,"Ajouter Pour");
		Append_Widget(B.barreOutil,B.btnPour);	
	--Création du bouton Tant Que
		Gtk_New(B.btnTantQue,"Tant que");
		Set_Tip(B.aide,B.btnTantQue,"Ajouter Tant Que");
		Append_Widget(B.barreOutil,B.btnTantQue);
	--Création du bouton Repeter
		Gtk_New(B.btnRepeter,"Repeter");
		Set_Tip(B.aide,B.btnRepeter,"Ajouter Repeter");
		Append_Widget(B.barreOutil,B.btnRepeter);
		Append_Space(B.barreOutil);
	--Création du bouton Ecrire
		Gtk_New(B.btnEcrire,"Ecrire");
		Set_Tip(B.aide,B.btnEcrire,"Ajouter Ecrire");
		Append_Widget(B.barreOutil,B.btnEcrire);
		Append_Space(B.barreOutil);
	--Création du bouton Lire
		Gtk_New(B.btnLire,"Lire");
		Set_Tip(B.aide,B.btnLire,"Ajouter Lire");
		Append_Widget(B.barreOutil,B.btnLire);
		Append_Space(B.barreOutil);
	--Création du bouton Entier
		Gtk_New(B.btnEntier,"Entier");
		Set_Tip(B.aide,B.btnEntier,"Ajouter Entier");
		Append_Widget(B.barreOutil,B.btnEntier);
	--Création du bouton Reel
		Gtk_New(B.btnReel,"Reel");
		Set_Tip(B.aide,B.btnReel,"Ajouter Reel");
		Append_Widget(B.barreOutil,B.btnReel);
	--Création du bouton Caractere
		Gtk_New(B.btnCaractere,"Caractere");
		Set_Tip(B.aide,B.btnCaractere,"Ajouter Caractere");
		Append_Widget(B.barreOutil,B.btnCaractere);
	--Création du bouton Chaine
		Gtk_New(B.btnChaine,"Chaine");
		Set_Tip(B.aide,B.btnChaine,"Ajouter Chaine");
		Append_Widget(B.barreOutil,B.btnChaine);
	--Création du bouton Bool
		Gtk_New(B.btnBool,"Booleen");
		Set_Tip(B.aide,B.btnBool,"Ajouter Booleen");
		Append_Widget(B.barreOutil,B.btnBool);
	--Ajout de la barre de tache
		modify_bg(B.barreOutil,State_Normal,B.couleurBarreOutil);
	END Initialize;	
END P_aideAlgo;
