with simple_io, mstring, definitions, analyse, gestionbloc;
use simple_io, mstring, definitions, analyse, gestionbloc;


procedure testanalyse is
	
	testAlgo : T_Tab_Ligne;
	
	procedure init is
		begin
		
		Creer_liste(testAlgo, CreateChaine("lire (a, b, c)"));
		Ajout_queue(testAlgo, CreateChaine("discr <- (b * b) - (4 * a * c)"));
		Ajout_queue(testAlgo, CreateChaine("c: mon premier commentaire"));
		Ajout_queue(testAlgo, CreateChaine("si discr < 0 alors"));
		Ajout_queue(testAlgo, CreateChaine("ecrire ('il n'y a pas de solution dans R')"));
		Ajout_queue(testAlgo, CreateChaine("sinonsi discr = 0 alors"));
		Ajout_queue(testAlgo, CreateChaine("res <- (-b)/(2 * a)"));
		Ajout_queue(testAlgo, CreateChaine("ecrire('la fonction admet une solution : x = ', res)"));
		Ajout_queue(testAlgo, CreateChaine("sinon"));
		Ajout_queue(testAlgo, CreateChaine("racine <- sqrt(discr)"));
		Ajout_queue(testAlgo, CreateChaine("res1 <- (-b + racine)/(2 * a)"));
		Ajout_queue(testAlgo, CreateChaine("res2 <- (-b - racine)/(2 * a)"));
		Ajout_queue(testAlgo, CreateChaine("ecrire ('l'equation admet deux solution : x1 = ', res1, ' et x2 = ', res2)"));
		Ajout_queue(testAlgo, CreateChaine("fsi"));
		Ajout_queue(testAlgo, CreateChaine("pour i de 1 à 15 faire"));
		Ajout_queue(testAlgo, CreateChaine("fpour"));
		Ajout_queue(testAlgo, CreateChaine("tq i < 10 faire"));
		Ajout_queue(testAlgo, CreateChaine("ftq"));
		Ajout_queue(testAlgo, CreateChaine("repeter"));
		Ajout_queue(testAlgo, CreateChaine("jusqua i > 10"));

		
	end init;
							
	function testGettype return boolean is
		

		passeTest: boolean:= true;
		courant : chaine := CreateChaine(" ");
		
		
		begin
		donne_tete(testAlgo, courant);
		if(GetType(courant) /= module)then
			put_line("La ligne 1 n'est pas reconnu comme étant un module 'lire'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(courant)));
			passeTest := false;
		end if;
		enleve_enTete(testAlgo);	
		donne_tete(testAlgo, courant);
	
		if(GetType(courant) /= affectation)then
			put_line("La ligne 2 n'est pas reconnu comme étant une affectation");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(courant)));
			passeTest := false;
		end if;
		

		enleve_enTete(testAlgo);	
		donne_tete(testAlgo, courant);
		if(GetType(courant) /= commentaire)then
			put_line("La ligne 3 n'est pas reconnu comme étant un commentaire");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(courant)));
			passeTest := false;
		end if;
		
		
		enleve_enTete(testAlgo);	
		donne_tete(testAlgo, courant);
		if(GetType(courant) /= cond)then
			put_line("La ligne 4 n'est pas reconnu comme étant un 'si'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(courant)));
			passeTest := false;
		end if;
		
		enleve_enTete(testAlgo);	
		donne_tete(testAlgo, courant);
		
		if(GetType(courant) /= module)then
			put_line("La ligne 5 n'est pas reconnu comme étant un module 'ecrire'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(courant)));
			passeTest := false;
		end if;
		
		enleve_enTete(testAlgo);	
		donne_tete(testAlgo, courant);
		if(GetType(courant) /= sinonsi)then
			put_line("La ligne  6 n'est pas reconnu comme étant un 'sinonsi'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(courant)));
			passeTest := false;
		end if;
		
		enleve_enTete(testAlgo);	
		enleve_enTete(testAlgo);	
		enleve_enTete(testAlgo);	
		donne_tete(testAlgo, courant);
		if(GetType(courant) /= sinon)then
			put_line("La ligne 9 n'est pas reconnu comme étant un 'sinon'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(courant)));
			passeTest := false;
		end if;
		
		enleve_enTete(testAlgo);	
		enleve_enTete(testAlgo);
		enleve_enTete(testAlgo);
		enleve_enTete(testAlgo);
		enleve_enTete(testAlgo);
		donne_tete(testAlgo, courant);
		if(GetType(courant) /= fsi)then
			put_line("La ligne 14 n'est pas reconnu comme étant un 'fsi'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(courant)));
			passeTest := false;
		end if;
		
		enleve_enTete(testAlgo);
		donne_tete(testAlgo, courant);
		if(GetType(courant) /= pour)then
			put_line("La ligne 15 n'est pas reconnu comme étant un 'pour'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(courant)));
			passeTest := false;
		end if;
		
		enleve_enTete(testAlgo);
		donne_tete(testAlgo, courant);
		if(GetType(courant) /= fpour)then
			put_line("La ligne 16 n'est pas reconnu comme étant un 'fpour'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(courant)));
			passeTest := false;
		end if;
		
		enleve_enTete(testAlgo);
		donne_tete(testAlgo, courant);
		if(GetType(courant) /= tq)then
			put_line("La ligne 17 n'est pas reconnu comme étant un 'pour'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(courant)));
			passeTest := false;
		end if;
		
		enleve_enTete(testAlgo);
		donne_tete(testAlgo, courant);
		if(GetType(courant) /= ftq)then
			put_line("La ligne 18 n'est pas reconnu comme étant un 'ftq'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(courant)));
			passeTest := false;
		end if;
		
		enleve_enTete(testAlgo);
		donne_tete(testAlgo, courant);
		if(GetType(courant) /= repeter)then
			put_line("La ligne 19 n'est pas reconnu comme étant un 'repeter'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(courant)));
			passeTest := false;
		end if;
		
		enleve_enTete(testAlgo);
		donne_tete(testAlgo, courant);
		if(GetType(courant) /= jqa)then
			put_line("La ligne 20 n'est pas reconnu comme étant un 'jusqua'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(courant)));
			passeTest := false;
		end if;
		
		return passeTest;
		
	end testGettype;
	
	function testAjoutCom return boolean is
		passeTest : Boolean := True;
		comm : chaine:= CreateChaine("c: UN PETIT COMMENTAIRE");
		testbloc : bloc(commentaire);
		Tab_bloctest : T_Tab_Bloc;
		
	begin
		creerListe(Tab_bloctest);

		Ajout_com(comm, Tab_bloctest);	
		
		-- Le résultat du commentaire si tout fonctionne
		comm := CreateChaine("UN PETIT COMMENTAIRE");
		donneTete(Tab_bloctest, testbloc);

		
		if testbloc.MonCom /=comm then
			passeTest := false;
			Put_line("Le résultat attendu: "+comm);
			Put_line("Le résultat obtenu : "+testbloc.MonCom);
			new_line;
		end if;
	
		return passeTest;
	
	end testAjoutCom;
	
	function testAnalyseCom return boolean is
	
		passeTest : boolean := true;
		Tab_bloctest: T_Tab_Bloc;
		Algo: T_Tab_Ligne;
		courant : Bloc(commentaire);
		
	begin
		creerListe(Tab_bloctest);
		
		Creer_liste(Algo, CreateChaine("c: coucou"));
		Ajout_queue(Algo, CreateChaine("c: discr <- (b * b) - (4 * a * c)"));
		

		donneTete(Tab_bloctest, courant);
		if(courant.Forme /= commentaire)then
			put_line("La première ligne n'a pas été ajouté en tant que commentaire");
			passeTest := false;
		end if;
		enleveTete(Tab_bloctest);
		donneTete(Tab_bloctest, courant);
		if(courant.Forme /= commentaire)then
			put_line("La seconde ligne n'a pas été ajouté en tant que commentaire");
			passeTest := false;
		end if;
		
		return passeTest;
	end testAnalyseCom;
	
	begin
		
		init;
		
		if(testGettype)then
			put_line("Fonction testGettype a passé tout les tests !");
		else
			put_line("La fonction testGettype n'est pas encore parfaite !, il y a des errreurs! ");
		end if;
		
		if testAjoutCom then
			put_line("Fonction testAjoutCom a passé tout les tests !");
		else
			put_line("La fonction testAjoutCom n'est pas encore parfaite !, il y a des errreurs! ");
		end if;
					
		if testAnalyseCom then
			put_line("La fonction analyse fonctionne !");
		else
			put_line("Il reste des erreurs dans la fonction analyse");
		end if;
	
	
end testanalyse;
