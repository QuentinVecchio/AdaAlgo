WITH Gtk.Menu_Bar;	USE Gtk.Menu_Bar;
WITH Gtk.Menu;		USE Gtk.Menu;
WITH Gtk.Menu_Item;	USE Gtk.Menu_Item;
WITH Gtk.Menu_Shell;	USE Gtk.Menu_Shell;
WITH Gtk.Enums ;        USE Gtk.Enums ;

PACKAGE BODY P_Menu IS
	PROCEDURE Initialize(M : IN OUT T_Menu) IS
	BEGIN
	--Menu_Bar
		Gtk_New(M.barreMenu);
	--Menu
		Gtk_New(M.menu);
	--Menu_Item
		Gtk_New(M.m_Fichier,"Fichier");
	--Ajout de l'item
		Append(M.barreMenu,M.m_fichier);
	END Initialize;	
END P_Menu;
