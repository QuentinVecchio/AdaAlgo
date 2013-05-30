package body conversion is

	procedure conversionAda(listeBloc : in out T_TAB_BLOC; listeLigne : in out T_TAB_LIGNE) is
		elt : Bloc; 
	begin
		while (estVide(listeBloc) = FALSE) loop
			donneTete(listeBloc,elt);--On affecte le bloc a analyser à elt
			case elt.Forme is
				when commentaire  => conversionCommentaire(elt,listeLigne);
                        	when module  => conversionModule(elt,listeLigne);
                        	when affectation => conversionAffectation(elt,listeLigne);
                        	when pour => conversionPour(elt,listeLigne);
				when tq => conversionTantque(elt,listeLigne);
				when repeter => conversionRepeter(elt,listeLigne);
                        	--when blocCond => 
                      		--when blocCase => conversionCasParmi();                              
				when others => NULL;
			end case;
		end loop;
	end conversionAda;
	
	procedure conversionCommentaire(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
	begin
		Ajout_queue(Ligne,"--" + m_bloc.MonCom);
	end conversionCommentaire;
	
	procedure conversionAffectation(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
	begin
		Ajout_queue(Ligne,m_bloc.vG + ":=" + m_bloc.vD + ";");
	end conversionAffectation;

	procedure conversionModule(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
	begin
		if(tabBloc.MonMod(1..4) = "LIRE" OR tabBloc.MonMod(1..4) = "lire") then --On teste si c'est le module lire
			Ajout_queue(Ligne,"GET" + tabBloc.MonMod(5..tabBloc.MonMod'Last));
		elsif(tabBloc.MonMod(1..5) = "ECRIRE" OR tabBloc.MonMod(1..5) = "ecrire") then -- On teste si c'est le module ecrire
			Ajout_queue(Ligne,"PUT" + tabBloc.MonMod(6..tabBloc.MonMod'Last));
		endif;
	end conversionModule;

	procedure conversionPour(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
	begin
		NULL;
		--:= "FOR I in " + tabBloc.CondContinu(9)+".."+tabBloc.CondContinu(9) +"loop";
		--conversionAda();
		--:= "end loop;";
	end conversionPour;

	procedure conversionTantque(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
        begin
		NULL;
                --:= "while" + tabBloc.CondContinu + "loop";
                --conversionAda(tabBloc.Tab_Bloc,);
                --:= "end loop;";
        end conversionTantque;

	procedure conversionRepeter(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
        begin
		NULL;
		--:= "loop"
                --conversionAda(tabBloc.Tab_Bloc,);
                --:= "while" + tabBloc.CondContinu +";";
        end conversionRepeter;

	procedure conversionCasParmi(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
	begin
		NULL;
		--:= "case" + tabBloc.variableATester + "is"
	end conversionCasParmi;

end conversion;
