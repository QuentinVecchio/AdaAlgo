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

	procedure enregistrer(chemin, entete: string; algo, variable: T_Tab_ligne) is
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

		put_line(fic, "<entete>");
		put_line(fic, entete);
		put_line(fic, "</entete>");

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

	procedure ouvrir(chemin: string; entete: out chaine; algo, variable: in out T_Tab_ligne) is
	fic: text_io.file_type;
	ligne_courante: string (1..1000);
	l_courant : integer;
	begin
		algo:= Creer_liste;
		variable:= Creer_liste;

		text_io.open(fic, text_io.in_file, chemin);

		get_line(fic, ligne_courante,l_courant);

		get_line(fic, ligne_courante, l_courant);
		entete := createchaine(ligne_courante(1..l_courant));

		get_line(fic, ligne_courante,l_courant);


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

	procedure generer(entete, lexique, algo: in string; resultat: out chaine; success: out boolean) is
		c_entete : chaine ;
		c_lexique : chaine ;
		c_algo : chaine ;
		c_nom_algo : chaine;
		tab_lexique, tab_algo, tab_erreur: T_Tab_ligne := Creer_liste;		
		res_lexique , tmp_lexique:T_tab_Lexique;
		res_algo: T_tab_bloc;

		tab_resultat: T_Tab_ligne;
		c_res: chaine;
		s_res : string (1..10000);
		l_res: integer;

		parcours :ligne;
		res : boolean;
	begin

		c_lexique := createchaine(lexique);

		c_algo := createchaine(algo);

		c_nom_algo := substring(createchaine(entete),strpos(createchaine(entete),' '), strpos(createchaine(entete),'(')-1);


		labeltoStr(c_lexique, tab_lexique);
		labeltoStr(c_algo, tab_algo);
		success := debuggagealgo(tab_algo, tab_erreur);
		--success := true;
		if(success) then
			tab_resultat := Creer_liste;
			res_lexique := Creer_liste;
			Ajout_queue(tab_resultat, createchaine("with simple_io; use simple_io;"&ASCII.LF));

			conversionEntete(createchaine(entete),c_entete);
			put_line("JE" + "PASSE");
			Ajout_queue(tab_resultat,c_entete + " is "+ASCII.LF);
			analyseLexique(tab_lexique, res_lexique);
			tmp_lexique := res_lexique;
			--while (not estvide(tmp_lexique))loop
			--	 donne_tete(tmp_lexique, parcours);
			--		if(parcours.Forme = fonction or else parcours.Forme = module)then
			--			donneSousProgramme(trimLeft(parcours.nom)+".alg",tab_resultat, res);						
			--			put_line(trimLeft(parcours.nom)+".alg");
		--			end if;

			--	donne_suivant(tmp_lexique);
			--end loop;			

			conversionLexique(res_lexique, tab_resultat);
			


			Ajout_queue(tab_resultat, createchaine(ASCII.LF&"begin"&ASCII.LF));

			Analyse_Code(tab_algo, res_algo);
			conversionAda(res_algo, tab_resultat);

			Ajout_queue(tab_resultat, ASCII.LF&"end "+c_nom_algo+";" +ASCII.LF);

		else
			tab_resultat := tab_erreur;
		end if;
			affiche_liste(tab_resultat);
		strtolabel(tab_resultat, resultat);


	end generer;

	procedure donneSousProgramme(cheminSousProgramme: chaine; resultat: in out T_Tab_ligne; success: out boolean) is
	entete : chaine;
	chemin : string(1..1000);
	l_chaine : integer;

	tab_lexique, tab_algo: T_Tab_ligne := Creer_liste;		
	res_lexique :T_tab_Lexique;
	res_algo: T_tab_bloc;
	algo, variable,tab_erreur : T_Tab_ligne := Creer_liste;

	begin
		toString(cheminSousProgramme,chemin, l_chaine);
		ouvrir(chemin(1..l_chaine), entete, algo, variable);

		success := debuggagealgo(algo, tab_erreur);

		if(success) then
			resultat := Creer_liste;
			res_lexique := Creer_liste;

			Ajout_queue(resultat, entete);
			analyseLexique(tab_lexique, res_lexique);
			conversionLexique(res_lexique, resultat);

			--ajout ss-pgme
			--while(NOT estVide(res_lexique))loop
			--	null;
			--end loop;

			Ajout_queue(resultat, createchaine(ASCII.LF&"begin"&ASCII.LF));

			Analyse_Code(tab_algo, res_algo);
			conversionAda(res_algo, resultat);

			Ajout_queue(resultat, ASCII.LF&"end "+substring(entete,strpos(entete,' '), strpos(entete,'('))+";"+ ASCII.LF);

		else
			resultat := tab_erreur;
		end if;

	end donneSousProgramme;


	procedure labeltoStr(entree: in out chaine; sortie: out T_Tab_ligne) is
		i: integer;	
		tmp: chaine := entree;	
	begin
		sortie := Creer_liste;
		while(contains(tmp, ASCII.LF&ASCII.LF)) loop
				tmp := replaceStr(tmp, createchaine(ASCII.LF&ASCII.LF), createChaine(ASCII.LF));
		end loop;
		while(strpos(tmp, ASCII.HT) /=0) loop
				tmp := replaceStr(tmp, createchaine(ASCII.HT), createChaine(' '));
		end loop;
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

		procedure strtolabel(entree: in out T_Tab_ligne; sortie: in out chaine) is
			tmp : chaine;
			function donneHT(nb: integer) return chaine IS
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
















end generateur;
