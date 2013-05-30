with simple_io, conversion, definitions, mstring,gestionBloc, typeEnum;
use simple_io, conversion, definitions, mstring,gestionBloc;


procedure testconversion is

	function testConversionCommentaire return boolean is
		aReussi: boolean := true;
		T: T_Tab_Bloc;
		L: T_Tab_Ligne;
		BlocCom :Bloc(commentaire);
		res: chaine := createChaine("--Je suis un commentaire:)");
		begin
			creerListe(T);
			ajoutCommentaire(T, createChaine("Je suis un commentaire:)"));
			donneTete(T, BlocCom);
			conversionCommentaire(BlocCom,L);
			if(donne_tete(L) = res)then
				Put_line("Conversion d'un commentaire réussi !");
			else
				Put_line("==>Erreur de conversion:");
				Put_line("Attendu  :"+ res);
				Put_line("Reçu     :"+ donne_tete(L));
				aReussi := false;
			end if;
		
		return aReussi;
	end testConversionCommentaire;

	function testConversionAffectation return boolean is
		aReussi: boolean := true;
		T, T2: T_Tab_Bloc;
		L: T_Tab_Ligne;
		BlocAff, BlocAff2: bloc(affectation);
		res: chaine := createChaine("age := age + 1");
		resf: chaine := createChaine(" ");
		begin
			creerListe(T);
			creerListe(T2);
			--ajoutAffectation(T, createChaine("age"), createChaine("age div (5 mod 3)"));
			ajoutAffectation(T, createChaine("age"), createChaine("age + 1"));
			ajoutAffectation(T, createChaine("age"), createChaine("age div (5 mod 3)"));

			donneTete(T, BlocAff);
			conversionAffectation(BlocAff,L);
			resf := donne_tete(L);
			if(not startWith(resf, "age"))then
				put_line("L'affectation ne commence pas par 'age'");
				aReussi := false;
			end if;
			
			-- a remplacer par un endwith plus avantageux
			if(not contains(resf, "age + 1"))then
				put_line("L'affectation ne finit pas par 'age +1'");
				aReussi := false;
			end if;
			
			if(not contains(resf, ":="))then
				put_line("L'affectation ne comporte pas de ':='");
				aReussi := false;
			end if;
			
			if(not aReussi)then
				put_line("Valeur reçue    :"+ resf);
				put_line("Valeur attendue :"+res);
			end if;
			
			donneTete(T2, BlocAff2);	
			conversionAffectation(BlocAff2,L);
			resf := donne_tete(L);
			res := createChaine("age := age / (5 rem 3)");
			if(contains(resf, "mod"))then
				put_line("Il reste encore des mod, -> rem");
				aReussi := false;
			end if;
			
			if(contains(resf, "div"))then
				put_line("Il reste encore des div, -> /");
				aReussi := false;
			end if;
			
			
			if(contains(resf, "div") or else contains(resf, "mod"))then
				put_line("Valeur reçue     :"+ resf);
				put_line("Valeur attendue  :"+res);
			end if;
			
			return aReussi;
	end testConversionAffectation;
	
	function testConversionModule return boolean is
		aReussi: boolean := false;
		T: T_Tab_Bloc;
		L: T_Tab_Ligne;
		BlocModule: Bloc(module);
		tmp : chaine;
		resf: chaine;
		begin
			creerListe(T);
			tmp := createChaine("lire(..)");
			ajoutModule(T, tmp);
			DonneTete(T, BlocModule);
			conversionModule(BlocModule,L);
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
	
	function testConversionAda return boolean is
		aReussi: boolean := false;
		T: T_Tab_Bloc;
		L: T_Tab_Ligne;

		begin
			creerListe(T);
			ajoutCommentaire(T, createChaine("c'est moi"));
			ajoutCommentaire(T, createChaine("Encore moi !"));
			ajoutAffectation(T, createChaine("surface"), createChaine("c*c"));
		
			conversionAda(T, L);
			if(estVide(L))then
				put_line("La procedure conversionAda ne renvoit rien !");
				aReussi := false;
			end if;
			
		
			return aReussi;
		
	end testConversionAda;
	
	
	
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
		
		if(testConversionAda)then
			Put_line("#Test de ConversionAda reussi avec succes");
		else
			Put_line("#Il reste encore des erreurs dans ConversionAda");
		end if;		
end testconversion;
