package body analyse is
	
	-------------------------
	-- Procedure d'analyse --
	-------------------------
	procedure analyse(tab: in out T_tab_ligne; l_cour: natural; res: out T_Tab_Bloc) is

	begin
		while trouver une condition and tab'last /= L_cour loop
		        type_ligne := GetType(Tab(l_cour));
		        case type_ligne is
		                when commentaire => Ajout_com(tab(l_cour), Res);
		                when affectation => Ajout_aff(tab(l_cour), Res);
		                when module      => Ajout_Mod(tab(l_cour), Res);
		                when pour | tq   => Ajout_pour_tq (tab(l_cour), Res);
		                when repeter     => Ajout_rep(tab, l_cour,Res);
		                when cond        => Ajout_cond(tab, l_cour, Res);
		                when others      => NULL;
		        end case;
		end loop;
	end analyse;




	-----------
	-- AJOUT --
	-----------
	
	--ajout d'un commentaire
	procedure Ajout_com(L: chaine, Res : in out T_Tab_Bloc) is
		blocCom : Bloc(commentaire);
	begin
		L := trimLeft(L);
		L := trimRight(L);
		L := substring(L, 2, length(L));
		L := trimLeft(L);
		blocCom.MonCom := L;
		--utiliser une fonction pour la manipulation du type T_Tab_Bloc
	
	end Ajout_com;



end analyse;
