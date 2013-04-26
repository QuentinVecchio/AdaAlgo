
procedure analyse(tab: in out T_tab_ligne; l_cour: natural; res: out T_Tab_Bloc) is
	continue : boolean := True;

begin
	while continue and Then tab'last /= L_cour loop
		continue := False
		type_ligne := GetType(Tab(l_cour));
		case type_ligne is
			when commentaire => Ajout_com(tab(l_cour), Res);
					    continue := True;
					    l_cour = l_cour + 1;
			when affectation => Ajout_aff(tab(l_cour), Res);
		    			    continue := True;
					    l_cour = l_cour + 1;
			when module 	 => Ajout_Mod(tab(l_cour), Res);
					    continue := True;
					    l_cour = l_cour + 1;
			when pour | tq 	 => Ajout_pour_tq (tab(l_cour), Res);
			when repeter	 => Ajout_rep(tab, l_cour,Res);
			when cond	 => Ajout_cond(tab, l_cour, Res);
			when others	 => NULL;
		end case;
	end loop;
end analyse;


