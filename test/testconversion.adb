with simple_io, conversion, definitions, mstring,gestionBloc, typeEnum;
use simple_io, conversion, definitions, mstring,gestionBloc;


procedure testconversion is

	function testConversionCommentaire return boolean is
		aReussi: boolean := true;
		T: T_Tab_Bloc;
		L: T_Tab_Ligne;
		res: chaine := createChaine("--Je suis un commentaire:)");
		begin
			creerListe(T);
			ajoutCommentaire(T, createChaine("Je suis un commentaire:)"));
			conversionCommentaire(T,L);
			if(donne_tete(L) = res)then
				Put_line("Conversion d'un commentaire réussi !");
			else
				Put_line("==>Erreur de conversion:");
				Put_line("Attendu: "+ res);
				Put_line("Reçu:    "+ donne_tete(L));
				aReussi := false;
			end if;
		
		return aReussi;
	end testConversionCommentaire;

	function testConversionAffectation return boolean is
		aReussi: boolean := true;
		T: T_Tab_Bloc;
		L: T_Tab_Ligne;
		res: chaine := createChaine("age := age + 1");
		resf: chaine := createChaine(" ");
		begin
			creerListe(T);
			ajoutAffectation(T, createChaine("age"), createChaine("age + 1"));
			conversionAffectation(T,L);
			resf := donne_tete(L);
			if(not startWith(resf, "age"))then
				put_line("L'affectation ne commence pas par 'age'");
				aReussi := false;
			end if;
			
			-- a remplacer par un endwith plus avantageux
			if(not contains(resf, "age +1"))then
				put_line("L'affectation ne finit pas par 'age +1'");
				aReussi := false;
			end if;
			
			if(not contains(resf, ":="))then
				put_line("L'affectation ne comporte pas de ':='");
				aReussi := false;
			end if;
			
			if(not aReussi)then
				put_line("Valeur reçue:   "+ resf);
				put_line("Valeur attendue:"+res);
			end if;
			return aReussi;
	end testConversionAffectation;
	
	function testConversionModule return boolean is
		aReussi: boolean := false;
		T: T_Tab_Bloc;
		L: T_Tab_Ligne;
		tmp : chaine;
		resf: chaine;
		begin
			creerListe(T);
			tmp := createChaine("lire(..)");
			ajoutModule(T, tmp);
			conversionModule(T,L);
			resf:= donne_tete(L);
		
			if(not startWith(resf, "put_line("))then
				put_line("La ligne ne commence pas par un put_line");
				aReussi := false;
			end if;
			
			--a remplacer par endwith 
			if(not contains(resf, ");"))then
				put_line("L'appel de module ne comporte pas de ');'");
				aReussi := false;
			end if;
		
			return aReussi;
		
	end testConversionModule;
	
	
	begin
		Put_line("Début de test du fichier conversion.adb");
		if(testConversionCommentaire)then
			Put_line("#Test de conversionCommentaire reussi avec succes");
		else
			Put_line("#Il reste encore des erreurs dans conversionCommentaire");
		end if;
		
		if(testConversionAffectation)then
			Put_line("#Test de ConversionAffectation reussi avec succes");
		else
			Put_line("#Il reste encore des erreurs dans ConversionAffectation");
		end if;		
		
		if(testConversionModule)then
			Put_line("#Test de conversionModule reussi avec succes");
		else
			Put_line("#Il reste encore des erreurs dans conversionModule");
		end if;		
		
		
end testconversion;