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
WITh Gtk.Message_Dialog;USE Gtk.Message_Dialog;
WITH Gtk.Handlers ;
with mstring;	use mstring;
with definitions; use definitions;
with gestionbloc; use gestionbloc;
with analyse; use analyse;
with conversion; use conversion;

PROCEDURE appli_test IS
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

			code :chaine;			
			monCode: T_Tab_ligne;

			procedure labeltoStr(entree: chaine; sortie: out T_Tab_ligne)is

				i: integer;	
				tmp: chaine := entree;	
				begin
					sortie := Creer_liste;

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
			end labeltoStr;

			procedure strtolabel(entree: in out T_Tab_ligne; sortie: in out chaine)is
				
				tmp : chaine;

				function donneHT(nb: integer) return chaine is
				tmp: chaine := createchaine(' ');				
				begin
						if(nb > 0)then
							tmp := createchaine(ASCII.HT);
							for I in 2..nb loop

								tmp := tmp + ASCII.HT;
							end loop;
						end if;
						return tmp;
				end donneHT;

				nbTab : integer := 0;
				begin
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
			end strtolabel;

			result : chaine;
			resultString : string(1..100000);
			l_result : integer;

			win : gtk_window;
			label : gtk_label;

			resBloc: T_Tab_Bloc;
			listeLigne : T_TAB_LIGNE;
 
		BEGIN
			Gtk_New(buffer);
			buffer := Get_Buffer(Text);
			Get_Start_Iter(buffer,start_iter);
			Get_End_Iter(buffer,end_iter); 

			code := createChaine(Get_Text(buffer,start_Iter,end_Iter,TRUE));

   		
			while(contains(code, ASCII.LF&ASCII.LF)) loop
				code := replaceStr(code, createchaine(ASCII.LF&ASCII.LF), createChaine(ASCII.LF));
			end loop;
			while(strpos(code, ASCII.HT) /=0) loop

				code := replaceStr(code, createchaine(ASCII.HT), createChaine(' '));
			end loop;
			put_line(code);

			labeltoStr(code, monCode);
			--return;
			Analyse_Code(monCode, resBloc);
			conversionAda(resBloc, listeLigne);


			strtolabel(listeLigne, result);
			toString(result, resultString, l_result);

			Gtk_New(win,Window_Toplevel);
			win.Set_Title("Fenetre");
			win.set_default_size(500,400);
			gtk_new(label, resultString(1..l_result));
			win.add(label);
			win.show_all;

   	
		END Compiler;
		
--*****************CODE SOURCE*****************--
BEGIN
   	Init ;
--Initialisation de la fenetre principale
   	Gtk_New(fenetrePrincipale,Window_Toplevel);
   	fenetrePrincipale.Set_Title("Programme algo");
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
END appli_test ;

