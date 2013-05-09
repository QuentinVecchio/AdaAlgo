with simple_io, mstring, definitions, analyse, gestionbloc;
use simple_io, mstring, definitions, analyse, gestionbloc;


procedure testanalyse is
	
	testAlgo : T_Tab_Ligne:=(	CreateChaine("lire (a, b, c)"),
								CreateChaine("discr <- (b * b) - (4 * a * c)"),
								CreateChaine("c: mon premier commentaire"),
								CreateChaine("si discr < 0 alors"),
								CreateChaine("ecrire ('il n'y a pas de solution dans R')"),
								CreateChaine("sinonsi discr = 0 alors"),
								CreateChaine("res <- (-b)/(2 * a)"),
								CreateChaine("ecrire('la fonction admet une solution : x = ', res)"),
								CreateChaine("sinon"),
								CreateChaine("racine <- sqrt(discr)"),
								CreateChaine("res1 <- (-b + racine)/(2 * a)"),
								CreateChaine("res2 <- (-b - racine)/(2 * a)"),
								CreateChaine("ecrire ('l'equation admet deux solution : x1 = ', res1, ' et x2 = ', res2)"),
								CreateChaine("fsi"),
								CreateChaine("pour i de 1 à 15 faire"),
								CreateChaine("fpour"),
								CreateChaine("tq i < 10 faire"),
								CreateChaine("ftq"),
								CreateChaine("repeter"),
								CreateChaine("jusqua i > 10")
								);
							
	function testGettype return boolean is
		
		passeTest: boolean:= true;
		begin
		
		if(GetType(testAlgo(1)) /= module)then
			put_line("La ligne 1 n'est pas reconnu comme étant un module 'lire'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(testAlgo(1))));
			passeTest := false;
		end if;
	
		if(GetType(testAlgo(2)) /= affectation)then
			put_line("La ligne 2 n'est pas reconnu comme étant une affectation");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(testAlgo(2))));
			passeTest := false;
		end if;
		
		if(GetType(testAlgo(3)) /= commentaire)then
			put_line("La ligne 3 n'est pas reconnu comme étant un commentaire");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(testAlgo(3))));
			passeTest := false;
		end if;
		
		if(GetType(testAlgo(4)) /= cond)then
			put_line("La ligne 4 n'est pas reconnu comme étant un 'si'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(testAlgo(4))));
			passeTest := false;
		end if;
		
		if(GetType(testAlgo(5)) /= module)then
			put_line("La ligne 5 n'est pas reconnu comme étant un module 'ecrire'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(testAlgo(5))));
			passeTest := false;
		end if;
		
		if(GetType(testAlgo(6)) /= sinonsi)then
			put_line("La ligne  n'est pas reconnu comme étant un 'sinonsi'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(testAlgo(6))));
			passeTest := false;
		end if;
		
		if(GetType(testAlgo(9)) /= sinon)then
			put_line("La ligne 9 n'est pas reconnu comme étant un 'sinon'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(testAlgo(9))));
			passeTest := false;
		end if;
		
		if(GetType(testAlgo(14)) /= fsi)then
			put_line("La ligne 14 n'est pas reconnu comme étant un 'fsi'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(testAlgo(14))));
			passeTest := false;
		end if;
		
		if(GetType(testAlgo(15)) /= pour)then
			put_line("La ligne 15 n'est pas reconnu comme étant un 'pour'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(testAlgo(15))));
			passeTest := false;
		end if;
		
		if(GetType(testAlgo(16)) /= fpour)then
			put_line("La ligne 16 n'est pas reconnu comme étant un 'fpour'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(testAlgo(16))));
			passeTest := false;
		end if;
		
		if(GetType(testAlgo(17)) /= tq)then
			put_line("La ligne 17 n'est pas reconnu comme étant un 'pour'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(testAlgo(17))));
			passeTest := false;
		end if;
		
		if(GetType(testAlgo(18)) /= ftq)then
			put_line("La ligne 18 n'est pas reconnu comme étant un 'ftq'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(testAlgo(18))));
			passeTest := false;
		end if;
		
		if(GetType(testAlgo(19)) /= repeter)then
			put_line("La ligne 19 n'est pas reconnu comme étant un 'repeter'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(testAlgo(19))));
			passeTest := false;
		end if;
		if(GetType(testAlgo(20)) /= jqa)then
			put_line("La ligne 20 n'est pas reconnu comme étant un 'jusqua'");
			put_line("->Reconnu comme étant "&T_type_ligne'image(GetType(testAlgo(20))));
			passeTest := false;
		end if;
		
		return passeTest;
		
	end testGettype;
	
	function testAjoutCom return boolean is
		passeTest : Boolean := True;
		comm : chaine;
		testbloc : bloc(commentaire);
		Tab_bloctest : T_Tab_Bloc;
		
	begin
		comm := CreateChaine("UN PETIT COMMENTAIRE");
		creerListe(Tab_bloctest);


		Ajout_com(comm, Tab_bloctest);	
		

		donneTete(Tab_bloctest, testbloc);

		if testbloc.MonCom /=comm then
			passeTest := false;
			put(testbloc.moncom);
		end if;
	
		return passeTest;
	
	end testAjoutCom;
	
	begin
		
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
					
	
	
end testanalyse;
