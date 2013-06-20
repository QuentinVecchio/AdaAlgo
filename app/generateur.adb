package body generateur is

	procedure creerFic(nom: string; fic: out text_io.file_type)is
		begin
			text_io.create(fic, text_io.out_file, nom);
	end creerFic;

	procedure init(nomModule: chaine; fic: text_io.file_type)is
		
		nom: string(1..100);
		l_nom: integer;
		begin
			toString(nomModule, nom, l_nom);

			put_line(fic, "with simple_io;");
			put_line(fic, "use simple_io;");
			new_line(fic);
			--put(fic, ASCII.HT);			
			put_line(fic, "procedure "&nom(1..l_nom)&" is");
	end init;

	procedure ecrireCorps(defVariable, instructions: in out T_Tab_Ligne; fic: text_io.file_type) is
		
		courant: string(1..150);
		l_courant: integer;
		begin
			while(NOT estVide(defVariable)) loop
					toString(donne_Tete(defVariable), courant, l_courant);
					put_line(fic, courant(1..l_courant));
					enleve_enTete(defVariable);
			end loop;
			new_line(fic);
			put_line(fic, "begin");
			new_line(fic);
			while(NOT estVide(instructions)) loop
					toString(donne_Tete(instructions), courant, l_courant);
					put_line(fic, courant(1..l_courant));
					enleve_enTete(instructions);
			end loop;

	end ecrireCorps;


	procedure fermer(nomModule: chaine; fic: in out text_io.file_type) is
		nom: string(1..100);
		l_nom: integer;
		begin
			toString(nomModule, nom, l_nom);
			new_line(fic, 5);
			put_line(fic, "end "&nom(1..l_nom)&";");
			text_io.close(fic);
	end fermer;

end generateur;
