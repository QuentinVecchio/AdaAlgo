package body generateur is

	procedure enregistrer(chemin: string; algo, variable: T_Tab_ligne)is
	fic: text_io.file_type;	
	tmp_algo : T_Tab_ligne := algo;
	tmp_var : T_Tab_ligne := variable;
	tmp_string: string(1..1000);
	l_string : integer;
	begin
		begin
			text_io.open(fic, text_io.out_file, chemin);

		exception
				when NAME_ERROR => text_io.create(fic, text_io.out_file, chemin);
		end;

		put_line(fic, "<var>");
		
		while(NOT estVide(tmp_var)) loop
			toString(donne_tete(tmp_var), tmp_string, l_string);
			put_line(fic, tmp_string(1..l_string));
			donne_suivant(tmp_var);
		end loop;
		put_line(fic, "</var>");
		put_line(fic, "<algo>");
		while(NOT estVide(tmp_algo)) loop
			toString(donne_tete(tmp_algo), tmp_string, l_string);
			put_line(fic, tmp_string(1..l_string));
			donne_suivant(tmp_algo);
		end loop;
		put_line(fic, "</algo>");

		text_io.close(fic);
	end enregistrer;

	procedure ouvrir(chemin: string; algo, variable: in out T_Tab_ligne)is
	fic: text_io.file_type;
	ligne_courante: string (1..1000);
	l_courant : integer;
	begin
		algo:= Creer_liste;
		variable:= Creer_liste;

		text_io.open(fic, text_io.in_file, chemin);
		get_line(fic, ligne_courante,l_courant);

		loop
			get_line(fic, ligne_courante,l_courant);
			
			if ligne_courante(1..6) /= "</var>" then
				Ajout_queue(variable, createchaine(ligne_courante(1..l_courant)));
			end if;
		exit when ligne_courante(1..6) = "</var>";
		end loop;

		get_line(fic, ligne_courante,l_courant);


		loop
			get_line(fic, ligne_courante,l_courant);
			
			if ligne_courante(1..7) /= "</algo>" then
				Ajout_queue(algo, createchaine(ligne_courante(1..l_courant)));
			end if;
		exit when ligne_courante(1..7) = "</algo>";
		end loop;

		text_io.close(fic);
	end ouvrir;

end generateur;
