WITH Gtk.Menu_Bar;	USE Gtk.Menu_Bar;
WITH Gtk.Menu;		USE Gtk.Menu;
WITH Gtk.Menu_Item;	USE Gtk.Menu_Item;
WITH Gtk.Menu_Shell;	USE Gtk.Menu_Shell;
WITH Ada.Finalization ; USE Ada.Finalization ;

PACKAGE P_Menu IS

	TYPE T_Menu IS NEW Controlled WITH RECORD
		barreMenu : Gtk_Menu_Bar;
		menu : Gtk_Menu;
		m_Fichier : Gtk_Menu_Item;
	END RECORD;

	PROCEDURE Initialize(M : IN OUT T_Menu);
END P_Menu;
