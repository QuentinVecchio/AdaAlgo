package body analyse is
	
	-------------------------
	-- Procedure d'analyse --
	-------------------------
	procedure analyse(tab: in out T_tab_ligne; l_cour: natural; res: out T_Tab_Bloc) is

	type_ligne: T_type_ligne;
	begin
		--while trouver une condition and tab'last /= L_cour loop
		while tab'last /= L_cour loop
		        type_ligne := GetType(Tab(l_cour));
		        case type_ligne is
-- 		                when commentaire => Ajout_com(tab(l_cour), Res);
-- 		                when affectation => Ajout_aff(tab(l_cour), Res);
-- 		                when module      => Ajout_Mod(tab(l_cour), Res);
-- 		                when pour | tq   => Ajout_pour_tq (tab(l_cour), Res);
-- 		                when repeter     => Ajout_rep(tab, l_cour,Res);
-- 		                when cond        => Ajout_cond(tab, l_cour, Res);
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
		blocCom : Bloc(commentaire);
		L_courant : chaine := L;
	begin
		L_courant := trimLeft(L_courant);
		L_courant := trimRight(L_courant);
		L_courant:= substring(L_courant, 2, length(L_courant));
		L_courant := trimLeft(L_courant);
		blocCom.MonCom := L_courant;
		--utiliser une fonction pour la manipulation du type T_Tab_Bloc
	
	end Ajout_com;



end analyse;
