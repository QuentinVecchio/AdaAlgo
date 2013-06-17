with definitions; use definitions;
package body analyse is
	
	-------------------------
	-- Procedure d'analyse --
	-------------------------
	procedure Analyse_Code(tab: in out T_tab_ligne;res: out T_Tab_Bloc) is

	type_ligne: T_type_ligne;
	begin
		while NOT estVide(tab) loop
		        type_ligne := GetType(donne_tete(tab));
		        case type_ligne is
 		                when commentaire => Ajout_com(donne_tete(tab), Res);
 		                when affectation => Ajout_aff(donne_tete(tab), Res);
		                when module      => Ajout_Mod(donne_tete(tab), Res);
		                when pour	 => Ajout_Pour (tab, Res);
		                when tq		 => Ajout_tq (tab, Res);
		                when repeter	 => Ajout_repeter (tab, Res);
		                when cond        => Ajout_cond(tab, Res);
				when testcase	 => Ajout_case(tab, Res);
		                when others      => NULL;  -- sinon, sinonsi ,fsi, fpour, ftq, jusqu'a
		        end case;
		        enleve_enTete(tab);
		end loop;
	end Analyse_Code;	
	
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
			elsif(startWith(ligne, "cas"))then
				typeligne:= testcase;
			elsif(contains(ligne, ":"))then
				typeligne:= lignecas;
			end if;
			
			return typeligne;
	
	end GetType;

	-----------
	-- AJOUT --
	-----------
	
	--ajout d'un commentaire
	procedure Ajout_com(L: chaine; Res: in out T_Tab_Bloc) is
		L_courant : chaine := L;
	begin
		L_courant := trimLeft(L_courant);
		L_courant := trimRight(L_courant);
		L_courant:= substring(L_courant, 3, length(L_courant));
		L_courant := trimLeft(L_courant);
		
		ajoutCommentaire(Res, L_courant);
	
	end Ajout_com;

	procedure Ajout_aff(L: chaine; res: in out T_Tab_Bloc)is
		partGauche, partDroit: chaine;
		L_courant: chaine := L;
	begin
		L_courant := trimLeft(L_courant);
		L_courant := trimRight(L_courant);
		partGauche := substring(L_courant, 1, strpos(L_courant, '<'));
		partDroit := substring(L_courant, strpos(L_courant, '<')+1, length(L_courant));
		partGauche := trimRight(partGauche);
		partDroit := trimLeft(partDroit);
		
		ajoutAffectation(res,  partGauche, partDroit);
	end Ajout_aff;
	
	
	
	procedure Ajout_Mod(L: chaine; res: in out T_Tab_Bloc)is
		L_courant : chaine := L;
	begin
		L_courant := trimLeft(L_courant);
		L_courant := trimRight(L_courant);
		
		ajoutModule(res, L_courant);
	end Ajout_Mod;



	
	procedure Ajout_Pour(tab: in out T_tab_ligne; Res: in out T_Tab_Bloc) is
		ListeInterne : T_tab_Bloc;
		condition : chaine;
	begin

		--on recupere la ligne de condition
		condition := donne_tete(tab);
		
		--on enleve des espaces possible a la fin de la ligne	
		condition := trimLeft(condition);

		--on enleve le 'faire'
		condition := substring(condition, length(condition)-6, length(condition));
		condition := trimLeft(condition);

		--on enleve le 'pour'
		condition := trimRight(condition);
		condition := substring(condition, length(condition)-5, length(condition));
		
		--on eleve les eventuelle espaces
		condition := trimLeft(condition);
		condition := trimRight(condition);		
		
		--on enleve le premier element de tab qui est ici la condition
		enleve_enTete(tab);

		--on rappel analyse code sur l'interieure de la boucle
		Analyse_Code(tab, ListeInterne);
		
		--on ajout en mémoire la boucle
		ajoutPour(Res, condition, ListeInterne);
	
	end Ajout_Pour;


	
	procedure Ajout_tq(tab: in out T_tab_ligne; Res: in out T_Tab_Bloc) is
		ListeInterne : T_tab_Bloc;
		condition : chaine;	
	Begin
		--on recupere la ligne de condition
		condition := donne_tete(tab);
		
		--on enleve des espaces possible a la fin de la ligne	
		condition := trimLeft(condition);

		--on enleve le 'faire'
		condition := substring(condition, length(condition)-6, length(condition));
		condition := trimLeft(condition);

		--on enleve le 'tq'
		condition := trimRight(condition);
		condition := substring(condition, length(condition)-3, length(condition));
		
		--on eleve les eventuelle espaces
		condition := trimLeft(condition);
		condition := trimRight(condition);

		--on enleve le premier element de tab qui est ici la condition
		enleve_enTete(tab);

		--on rappel analyse code sur l'interieure de la boucle
		Analyse_Code(tab, ListeInterne);
		
		--on ajout en mémoire la boucle
		ajoutPour(Res, condition, ListeInterne);
		
	end Ajout_tq;


	
	procedure Ajout_repeter(tab: in out T_tab_ligne; Res: in out T_Tab_Bloc) is
		ListeInterne : T_tab_Bloc;
		condition : chaine;		
	begin
		--on eleve le premier element de 'tab' qui est ici 	
		enleve_enTete(tab);

		--on rappel analyse code sur l'interieure de la boucle
		Analyse_Code(tab, ListeInterne);
		

		--on recupere la ligne de condition
		condition := donne_tete(tab);
		
		--on enleve des espaces possible a la fin de la ligne	
		condition := trimLeft(condition);

		--on enleve le 'tq'
		condition := trimRight(condition);
		condition := substring(condition, length(condition)-3, length(condition));
		
		--on eleve les eventuelle espaces
		condition := trimLeft(condition);
		condition := trimRight(condition);		
	
		--on ajout en mémoire la boucle
		ajoutPour(Res, condition, ListeInterne);
										
	end Ajout_repeter;	
	
	procedure Ajout_cond (tab: in out T_tab_ligne ; Res: in out T_Tab_Bloc) is
		tab_Bloc : T_Tab_Bloc;
		ListeInterne : T_Tab_Bloc;
		L_courant : chaine;
		type_cond : T_elmt;
	begin
		loop
			L_courant := donne_tete(tab);
			L_courant := trimLeft(L_courant);

			enleve_enTete(tab);
			
			if(startWith(L_courant, "si")) then
				L_courant := substring(L_courant, 3, length(L_courant));
				type_cond := si;
			elsif(startWith(L_courant, "sinon si")) then
				type_cond := sinonsi;
			else
				type_cond := sinon;
			end if;


			Analyse_Code(tab, tab_Bloc);
			case type_cond is
				when si => Ajout_Si(tab_Bloc, L_courant,ListeInterne);
				when sinon => Ajout_SinonSi(tab_Bloc, L_courant, ListeInterne);
				when others => Ajout_Sinon(tab_Bloc, ListeInterne);
			end case;
				
			L_courant := donne_tete(tab);
			L_courant := trimLeft(L_courant);
			L_courant := trimRight(L_courant);
		exit when contains(L_courant, "fsi");
		end loop;

		--derniere etape : ajouter la condition dans la liste principale
		ajoutBlocCond(Res, tab_Bloc);	
	end Ajout_cond;

	procedure Ajout_case(tab: in out T_tab_ligne ; Res: in out T_tab_bloc) is
		tab_Bloc : T_Tab_Bloc;
		L_courant : chaine;
		ListeInterne : T_Tab_Bloc;
		condition : chaine;
		Variable : chaine;
	begin
		--recupération de la variable
		L_courant := donne_tete(tab);
		enleve_enTete(tab);
		L_courant := trimLeft(L_courant);
		L_courant := trimRight(L_courant);
		
		L_courant := substring(L_courant, 4, length(L_courant));
		L_courant := substring(L_courant, 1, length(L_courant)-7);
		Variable := L_courant;

		
		--enregistrement des instructions dans la mémoire
		L_courant := donne_tete(tab);
		enleve_enTete(tab);
		loop				

			L_courant := trimLeft(L_courant);
			condition := L_courant;
			
			--mise en forme de la condition pour implementation mémoire
			condition := substring(condition, 1, strpos(condition, ':')-1);
			condition := trimLeft(condition);
			condition := trimRight(condition);

			


			L_courant := substring(L_courant, strpos(L_courant, ':')+1, length(L_courant));
			L_courant := trimLeft(L_courant);
			
			Ajout_enTete(tab, l_courant);

			Analyse_code(tab, ListeInterne);

			AjoutCas(tab_Bloc, ListeInterne, condition);

		exit when contains(L_courant, "fincas");
		end loop;	
		--derniere etape : ajouter la condition dans la liste principale
		AjoutBlocCas(Res, tab_Bloc,Variable);

		
	end Ajout_case;
	
end analyse;
