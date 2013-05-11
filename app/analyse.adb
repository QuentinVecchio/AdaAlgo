package body analyse is
	
	-------------------------
	-- Procedure d'analyse --
	-------------------------
	procedure analyse(tab: in out T_tab_ligne;res: out T_Tab_Bloc) is

	type_ligne: T_type_ligne;
	begin
		--while trouver une condition and tab'last /= L_cour loop
		while estVide(tab) loop
		        type_ligne := GetType(donne_tete(tab));
		        case type_ligne is
 		                when commentaire => Ajout_com(donne_tete(tab), Res);
 		                when affectation => Ajout_aff(donne_tete(tab), Res);
		                when module      => Ajout_Mod(donne_tete(tab), Res);
		                when pour | tq   => Ajout_pour_tq (tab,Res);
		                when repeter     => Ajout_rep(tab,Res);
		                when cond        => Ajout_cond(tab, Res);
		                when others      => NULL;
		        end case;
		end loop;
	end analyse;	
	
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

	-----------
	-- AJOUT --
	-----------
	
	--ajout d'un commentaire
	procedure Ajout_com(L: chaine; Res : in out T_Tab_Bloc) is
		L_courant : chaine := L;
	begin
		L_courant := trimLeft(L_courant);
		L_courant := trimRight(L_courant);
		L_courant:= substring(L_courant, 3, length(L_courant));
		L_courant := trimLeft(L_courant);
		ajoutCommentaire(Res, L_courant);
	
	end Ajout_com;

	procedure Ajout_aff(L: chaine; res: T_Tab_Bloc)is
		begin
			null;
	end Ajout_aff;
	
	procedure Ajout_Mod(L: chaine; res: T_Tab_Bloc)is
		begin
			null;
	end Ajout_Mod;
	
	procedure Ajout_pour_tq (tab: T_tab_ligne ; Res: T_Tab_Bloc) is
		begin
			null;
	end Ajout_pour_tq;

	procedure Ajout_rep (tab: T_tab_ligne ; Res: T_Tab_Bloc) is
		begin
			null;
	end Ajout_rep;
	
	procedure Ajout_cond (tab: T_tab_ligne ; Res: T_Tab_Bloc) is
		begin
			null;
	end Ajout_cond;
	
end analyse;
