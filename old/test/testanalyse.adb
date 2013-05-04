package body testanalyse is



	procedure afficheTab(T: Tabligne) is
	
		begin
		
			for I in T'range loop
				put_line(T(I));
			end loop;
	end;
	
	function GetType(ligne: chaine)return T_type_ligne is
	
		typeligne : T_type_ligne;
	
		begin
	
			if(startWith(ligne, "c:"))then
				typeligne:= commentaire;
			elsif(contains(ligne, "<-"))then
				typeligne:= affectation;
			elsif(startWith(ligne, "sinonsi"))then
				typeligne := sinonsi;
			elsif(startWith(ligne, "sinon"))then
				typeligne := sinon;
			elsif(startWith(ligne, "si"))then
				typeligne:= cond;
			elsif(startWith(ligne, "fsi"))then
				typeligne:= fsi;
			elsif(startWith(ligne, "lire") or else startWith(ligne, "ecrire"))then
				typeligne:= module;
			elsif(startWith(ligne, "pour"))then
				typeligne:= pour;
			elsif(startWith(ligne, "fpour"))then
				typeligne:= fpour;
			elsif(startWith(ligne, "ftq"))then
				typeligne:= ftq;
			elsif(startWith(ligne, "tq"))then
				typeligne:= tq;
			elsif(startWith(ligne, "repeter"))then
				typeligne:= repeter;
			elsif(startWith(ligne, "jusqua"))then
				typeligne:= jqa;
			end if;
			
			return typeligne;
	
	
	end GetType;

	
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
		
	
	procedure lanceTest is
	
	begin
		
		if(testGettype)then
			put_line("Fonction testGettype a passé tout les tests !");
		else
			put_line("La fonction n'est pas encore parfaite !, il y a des errreurs! ");
		end if;
		
	end lanceTest;
		
end testanalyse;